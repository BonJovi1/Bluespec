The basic logic for both the codes is the same: try to reduce the accesses to the main memory to save time! As we know, the cache lies closer to the processor in the memory hierarchy. So if the data is present in the cache itself, we don't need to access the main memory; saving up on a good amount of time!

1. matrix_add.c

The code given was adding the two matrices the normal way, but was accessing elements column by column (a11 + b11, a21+b21 and so on...).
The optimization we do is simple: the logic for the addition remains the same, however, instead of adding up elements column by column, we go ROW BY ROW! i.e. a11 + b11 , a12 + b12 and so on. The reason this works faster is because elements of a matrix are stored row wise in the computer. So when we traverse along the row, we fetch data from the cache more often than we would, if we traversed along the column. When a particular element is brought from the memory, 64 KB of its following elements (in a contiguous array) are also brought up to the cache.

gcc matrix_add.c
./a.out

Matrix Initialization Time:  0.009108
Your Matrix Addition Time:  0.004498
Given Matrix Addition Time:  0.045197
Your code speedup when compared with given method: 10.05x

2. matrix_mul.c

Te naive code given was simply multiplying the two matrices(each row*each column) which was resulting in a lot of accesses to the main memory. Now instead of that , we us a BLOCK or a TILE of some size and obtain submatrices. So we compute the product on submatrices(matrices of size TILE_SIZE). 

Matrices are stored in row major order and when a particular element is brought from the memory, 64 KB of its following elements (in a contiguous array) are also brought up to the cache. So again, we reduce the number of main memory accesses and reduce time by having a higher hit rate at the cache! A benefits from spatial locality (close by elements will be accessed soon) and B from temporal locality (element will be accessed again)!

When we increase the size of each block, more elements get stored in the cache and this leads to even lesser accesses to the main memory! But we can only increase the Tile size upto a certain limit because the cache can store only limited amount of data.

./a.out (TILE_SIZE=2) (N=1024)

Matrix Initialization Time:  0.009082
Your Matrix Multiplication Time: 16.531931
Naive Matrix Multiplication Time: 22.695689
Your code speedup when compared with Naive method: 1.37x

./a.out (TILE_SIZE=4) (N=1024)

[abhinav.g@CR13013 20171059]$ ./a.out
Matrix Initialization Time:  0.008648
Your Matrix Multiplication Time:  6.931031
Naive Matrix Multiplication Time: 20.345236
Your code speedup when compared with Naive method: 2.94x

./a.out (TILE_SIZE=8) (N=1024)

[abhinav.g@CR13013 20171059]$ gcc matrix_mul.c 
[abhinav.g@CR13013 20171059]$ ./a.out
Matrix Initialization Time:  0.008962
Your Matrix Multiplication Time:  5.399130
Naive Matrix Multiplication Time: 21.343452
Your code speedup when compared with Naive method: 3.95x


(TILE_SIZE=16) along with the linux perf tool to determine L1-dcache hits!

sudo perf stat -e L1-dcache-loads,L1-dcache-load-misses,L1-dcache-stores ./a.out
[sudo] password for abhinav: 
Matrix Initialization Time:  0.005470
Your Matrix Multiplication Time:  4.017116
Naive Matrix Multiplication Time: 18.415691
Your code speedup when compared with Naive method: 4.58x

 Performance counter stats for './a.out':

   39,12,57,78,365      L1-dcache-loads                                             
    3,20,97,33,867      L1-dcache-load-misses     #    8.20% of all L1-dcache hits  
    6,60,57,56,853      L1-dcache-stores                                            

      34.545404954 seconds time elapsed

For N=2048 and N=4096 the code was taking too much time to execute. 




