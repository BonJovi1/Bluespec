#include <stdio.h>
#include <time.h>
#define TILE_SIZE 16
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

    06 June 2005

  Author:

    John Burkardt

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
	int i, j, k, prod_ij;
	int a,b,c;
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

	/* Naive Matrix Multiplication. 
	   Improve the performance of this code
	    */
	start = cpu_time();

	for(i=0; i<N; ++i){
		for(j=0; j<N; ++j){
			C[i][j] = 0;
			for(k=0; k<N; ++k){
				C[i][j] += A[i][k]*B[k][j];
			}
		}
	}
	
	stop = cpu_time();

	time[1] = stop - start;


	start = cpu_time();

	/* Your Matrix Multiplication Code */
	for(i=0;i<N;i+=TILE_SIZE)
	{
		for(j=0;j<N;j+=TILE_SIZE)
		{
			for(a=i;a<TILE_SIZE+i;++a)
			{
				for(b=j;b<TILE_SIZE+j;++b)
					C[a][b]=0;
			}
			
			for(k=0;k<N;k+=TILE_SIZE)
			{
				for(a=i;a<TILE_SIZE+i;++a)
				{
					for(b=j;b<TILE_SIZE+j;++b)
					{
						for(c=k;c<TILE_SIZE+k;++c)
							C[a][b]+=A[a][c]*B[c][b];
					}
				}
			}
		}
	}
	

	stop = cpu_time();

	for(i=0; i<N; ++i){
		for(j=0; j<N; ++j){
			prod_ij = 0;
			for(k=0; k<N; ++k){
				prod_ij += A[i][k]*B[k][j];
			}
			if (prod_ij != C[i][j]){
				printf("Error in computing C[%d,%d]\n", i, j);
				goto exit;
			}
		}
	}

exit:

	time[2] = stop - start;

	printf("Matrix Initialization Time: %9f\n", time[0]);
	printf("Your Matrix Multiplication Time: %9f\n", time[2]);
	printf("Naive Matrix Multiplication Time: %9f\n", time[1]);
	printf("Your code speedup when compared with Naive method: %1.2fx\n", time[1]/time[2]);
}