#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void error (char* message);
double* allocate_vect(int dim);
double* deallocate_vect(double* vect);
double lagrange(double* xdata, double* ydata, int dim, double point);

int main(int argc, char** argv){
	FILE* fp = fopen(argv[1], "r");
	if(!fp)error("impossibile aprire il file");
	int dim;
	double x, res;
    fscanf(fp, "%d", &dim);
	fscanf(fp, "%lf", &x);
	double* xdata = allocate_vect(dim);
	double* ydata = allocate_vect(dim);
	for(int i=0; i<dim; i++){
		fscanf(fp, "%lf", &xdata[i]);
	}
	for(int i=0; i<dim; i++)
	       	fscanf(fp, "%lf", &ydata[i]);
	fclose(fp);
	res = lagrange(xdata, ydata, dim, x);
	printf("il valore interpolato in %lf e' %lf\n", x, res);
	xdata = deallocate_vect(xdata);
	ydata = deallocate_vect(ydata);
	return 0;
}

void error (char* message){
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

double lagrange(double* xdata, double* ydata, int dim, double point){
	double res = 0;
	for(int i=0; i<dim; i++){
		double weigth = 1;
		for(int j=0; j<dim; j++){
			if(i==j) continue;
			weigth *= (point-xdata[j])/(xdata[i]-xdata[j]);
		}
		weigth*=ydata[i];
		res += weigth;
	}
	return res;
}

















