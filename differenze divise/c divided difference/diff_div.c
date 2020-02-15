#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void error (char* message);
double** allocate_mat(int dim);
double** deallocate_mat(double** matrix, int dim);
double* allocate_vect(int dim);
double* deallocate_vect(double* vect);
double horner(double** matrix, double* xdata, int dim, double point);
double** populate_matrix(double** matrix, double* xdata, int dim);

int main(int argc, char** argv){
	FILE* fp = fopen(argv[1], "r");
	if(!fp)error("impossibile aprire il file");
	int dim;
	double x;
    fscanf(fp, "%d", &dim);
	fscanf(fp, "%lf", &x);
	double** matrix = allocate_mat(dim);
	double* xdata = allocate_vect(dim);
	for(int i=0; i<dim; i++){
		fscanf(fp, "%lf", &xdata[i]);
	}
	for(int i=0; i<dim; i++)
	       	fscanf(fp, "%lf", &matrix[i][0]);
	fclose(fp);	
	matrix = populate_matrix(matrix, xdata, dim);
	double res = horner(matrix, xdata, dim, x);
	printf("il risultato dell'interpolazione in %8.8lf e' %8.8lf\n", x, res);
	matrix = deallocate_mat(matrix, dim);
	xdata = deallocate_vect(xdata);
	return 0;
}

void error (char* message){
	fprintf(stderr, "%s\n", message);
	exit(1);
}

double** allocate_mat(int dim){
	double** matrix = (double**)calloc(dim, sizeof(double*));
	if(!matrix)error("error in function allocate_mat");
	for(int i=0; i<dim; i++){
		matrix[i] = (double*) calloc(dim, sizeof(double));
		if(!matrix[i]) error("error in function allocate_mat");
	}
	return matrix;
}

double** deallocate_mat(double** matrix, int dim){
	for(int i=0; i<dim; i++) free(matrix[i]);
	free(matrix);
	return NULL;
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

double horner(double** matrix, double* xdata, int dim, double point){
	double res = matrix[dim-1][dim-1];
	for(int i=dim-2; i>=0; i--)
		res = matrix[i][i] + res*(point-xdata[i]);
	return res;

}

double** populate_matrix(double** matrix, double* xdata, int dim){
	for(int i=1; i<dim; i++)
		for(int j=1; j<=i; j++)
			matrix[i][j] = (matrix[i][j-1]-matrix[i-1][j-1])/(xdata[i]-xdata[i-j]);
	return matrix;
}
