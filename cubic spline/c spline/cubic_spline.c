#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

typedef struct{
	int dim;
	double* xdata;
	double* hj;
	double* aj;
	double* bj;
	double* cj;
	double* dj;
}Spline;

void error(char* message);
double* allocate_vect(int dim);
double* deallocate_vect(double* vect);
double** allocate_matrix(int dim);
double** deallocate_matrix(double** m, int dim);
Spline makespline_from_file(FILE* fp);
Spline populate_spline(Spline s, char* type, double der_x0, double der_xn);
double* solve_lin_sys(double** matrix, double* b, int dim);
double* solve(double** matrix, double* b, int dim);
int binary_search(double* vect, int dim, double key);
double* evaluate_spline(Spline s, double* pti_eval, int num_point);
Spline del_Spline(Spline s);

int main(int argc, char** argv){
	FILE* fp = fopen(argv[1], "r");
	if(!fp)error("could not read teh file");
	Spline s = makespline_from_file(fp);
	s = populate_spline(s, "Natural", 0.0, 4.4);
	int dim;
	fscanf(fp, "%d", &dim);
	double* points_to_evaluate = allocate_vect(dim);
	for(int i=0; i<dim; i++) fscanf(fp, "%lf", &points_to_evaluate[i]);
	double* interpolation = evaluate_spline(s, points_to_evaluate, dim);
	printf("x -------- f(x)\n");
	for(int i=0; i<dim; i++)
		printf("%lf := %lf\n", points_to_evaluate[i], interpolation[i]);
	free(points_to_evaluate);
	free(interpolation);
	fclose(fp);
	s = del_Spline(s);
	return 0;
}

void error(char* message){
	fprintf(stderr, "%s\n", message);
	exit(1);
}

double* allocate_vect(int dim){
	double* vect = (double*)calloc(dim, sizeof(double));
	if(!vect)error("error in function allocate vect");
	return vect;
}

double* deallocate_vect(double* vect){
	free(vect);
	return NULL;
}

double** allocate_matrix(int dim){
	double** m = (double**)calloc(dim, sizeof(double));
	if(!m) error("error in funcion allocate_matrix");
	for(int i=0; i<dim; i++){
		m[i] = allocate_vect(dim);
		if(!m[i]) error("error in fuction allocate_matrix");
	}
	return m;
}

double** deallocate_matrix(double** m, int dim){
	for(int i=0; i<dim; i++) m[i] = deallocate_vect(m[i]);
	free(m);
	return NULL;
}

Spline makespline_from_file(FILE* fp){
	Spline s;	
	fscanf(fp,"%d", &s.dim);
	s.xdata = allocate_vect(s.dim);
	s.aj = allocate_vect(s.dim);
	s.bj = allocate_vect(s.dim);
	s.cj = allocate_vect(s.dim);
	s.dj = allocate_vect(s.dim);
	s.hj = allocate_vect(s.dim-1);
	for(int i=0; i<s.dim*2; i++)
		(i<s.dim) ? fscanf(fp, "%lf", &s.xdata[i]) : fscanf(fp, "%lf", &s.aj[i-s.dim]);
	for(int i=0; i<s.dim-1; i++)
		s.hj[i] = s.xdata[i+1]-s.xdata[i];
	return s;
}

Spline populate_spline(Spline s, char* type, double der_x0, double der_xn){
	double** matrix = allocate_matrix(s.dim);
	double* aus = allocate_vect(s.dim);
	if(!strcmp("Clamped", type)){
		matrix[0][0] = 2*s.hj[0]; matrix[0][1] = s.hj[0];
		matrix[s.dim-1][s.dim-1] = 2*s.hj[s.dim-1];	matrix[s.dim-1][s.dim-2] = s.hj[s.dim-1];
		aus[0] = 3*(s.aj[1]-s.aj[0])/s.hj[0] - der_x0;
		aus[s.dim-1] = 3*(s.aj[s.dim-1]-s.aj[s.dim-2])/s.hj[s.dim-1] - der_xn;
	}
	else matrix[0][0] = matrix [s.dim-1][s.dim-1] = 1;
	for(int i=1; i<s.dim-1; i++){
		matrix[i][i-1] = s.hj[i-1];
		matrix[i][i] = 2*(s.hj[i-1] + s.hj[i]);
		matrix[i][i+1] = s.hj[i];
		aus[i] = 3*(s.aj[i+1]-s.aj[i])/s.hj[i] - 3*(s.aj[i]-s.aj[i-1])/s.hj[i-1];
	}
	s.cj = solve_lin_sys(matrix, aus, s.dim);  
	for(int i=0; i<s.dim-1; i++){
		s.bj[i] = (s.aj[i+1]-s.aj[i])/s.hj[i] - s.hj[i]*(2*s.cj[i]+s.cj[i+1])/3;
		s.dj[i] = (s.cj[i+1] - s.cj[i])/3*s.hj[i];
	}
	if(!strcmp("Not-a-Knot", type)){
		s.dj[0] = s.dj[1];
		s.dj[s.dim-1] = s.dj[s.dim-2];
	}
	aus = deallocate_vect(aus);
	matrix = deallocate_matrix(matrix, s.dim);
	return s;
}

double* solve_lin_sys(double** matrix, double* b, int dim){// Ax = b --> x = A/b
	//LU decomposition
	double* sol;
	double pivot;
	for(int i=1; i<dim; i++){
		for(int j=i; j<dim; j++){
			if(matrix[j][i-1] == 0) continue;
			pivot = matrix[j][i-1]/matrix[i-1][i-1];
			for(int z=i; z<dim; z++)
				matrix[j][z] -= pivot*matrix[i-1][z];
			matrix[j][i-1] = pivot;
		}
	}	
	return sol = solve(matrix, b, dim);
}

double* solve(double** matrix, double* b, int dim){
	double* solution = allocate_vect(dim);	
	for(int i=1; i<dim; i++){
		for(int j=0; j<i; j++)
			b[i] -= b[j]*matrix[i][j];
		solution[i] = b[i];
	}
	solution[dim-1] /= matrix[dim-1][dim-1];
	for(int i=dim-2; i>=0; i--){
		for(int j=dim-1; j>i; j--){
			solution[i] -= solution[j]*matrix[i][j];	
		}
		solution[i] /= matrix[i][i];
	}
	return solution;
}

int binary_search(double* vect, int dim, double key){
    int low = 0;
    int up = dim-1;
    if(vect[up] < key) return up;
    if(vect[low] > key) return low;
    int index;
    while(up != low){
        index = (low+up)/2;
        if(key > vect[index] && key < vect[index+1]) break;
        else if (key < vect[index])
            up = index;
        else 
            low = index+1;
    }
    return index;
}

double* evaluate_spline(Spline s, double* pti_eval, int num_point){
	double* y = allocate_vect(num_point);
	for(int i=0; i<num_point; i++){
		int index = binary_search(s.xdata, s.dim-1, pti_eval[i]);
		y[i] = s.aj[index] + s.bj[index]*(pti_eval[i]-s.xdata[i]) + s.cj[index]*(pti_eval[i]-s.xdata[i])*(pti_eval[i]-s.xdata[i]) + s.dj[index]*(pti_eval[i]-s.xdata[i])*(pti_eval[i]-s.xdata[i])*(pti_eval[i]-s.xdata[i]);
	}
	return y;
}

Spline del_Spline(Spline s){
	free(s.aj);
	free(s.bj);
	free(s.cj);
	free(s.dj);
	free(s.hj);
	free(s.xdata);
	s.dim = 0;
	return s;
}
