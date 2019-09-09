#include <stdio.h>
#include <stdlib.h>
#include "my_math.h"

void run_cli(char*);
void run_cmd(int, char**);

int main(int argc, char **argv){
	if (argc < 2)
		run_cli(argv[0]);
	else
		run_cmd(argc, argv);
	return 0;
}

void run_cli(char *name){
	printf("Usage: %s <list of number>\n", name);
	printf("Example: %s 1 2 3 4\n", name);
}

void run_cmd(int argc, char **argv){
	float* arr = (float*)malloc((argc-1) * sizeof(float));
	for (int i=1; i<argc; i++){
		arr[i-1] = atof(argv[i]);
	}

	float avg = calc_average(arr, argc-1);
	free(arr);

	printf("Average: %.4f\n", avg);
}
