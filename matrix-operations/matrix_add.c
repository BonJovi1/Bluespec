#include <stdio.h>
#include <time.h>
#define N 1<<10	

int A[N][N], B[N][N], C[N][N] ;

/******************************************************************************/

double cpu_time ( void )

/******************************************************************************/
/*
  Purpose:

    CPU_TIME returns the current reading on the CPU clock.

  Discussion:

    The CPU time measurements available through this routine are often
    not very accurate.  In some cases, the accuracy is no better than
    a hundredth of a second.  

  Licensing:

    This code is distributed under the GNU LGPL license. 

  Modified:

    05 April 2018

  Author:

    Lavanya Ramapantulu

  Parameters:

    Output, double CPU_TIME, the current reading of the CPU clock, in seconds.
*/
{
  double value;

  value = ( double ) clock ( ) 
        / ( double ) CLOCKS_PER_SEC;

  return value;
}

int main()
{
	int i, j, k;
	double time[3], start, stop;

	/* Initialize the matrices */

	start = cpu_time();

	for(i=0; i<N; ++i){
		for(j=0; j<N; ++j){
			A[i][j]=i-j;
			B[i][j]=i+j;
		}
	}

	stop = cpu_time();

	time[0] = stop - start;

	/* Matrix Addition. 
	   Improve the performance of this code
	    */
	start = cpu_time();

	for(j=0; j<N; ++j){
		for(i=0; i<N; ++i){
			C[i][j] = A[i][j] + B[i][j];
		}
	}
	
	stop = cpu_time();

	time[1] = stop - start;
	

	start = cpu_time();
	/*Write your code here*/
	for(i=0;i<N;++i)
	{
		for(j=0;j<N;++j)
			C[i][j] = A[i][j] + B[i][j];
	}

	
	/*Your code ends here*/
	stop = cpu_time();

	time[2] = stop - start;

	printf("Matrix Initialization Time: %9f\n", time[0]);
	printf("Your Matrix Addition Time: %9f\n", time[2]);
	printf("Given Matrix Addition Time: %9f\n", time[1]);
	printf("Your code speedup when compared with given method: %1.2fx\n", time[1]/time[2]);
}
