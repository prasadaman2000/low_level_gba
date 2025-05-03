#ifndef MATRIX_H
#define MATRIX_H

#include "core.h"

typedef struct matrix_t matrix;
matrix* new_matrix(uint8 n, uint8 m);
void matrix_write(matrix* mat, uint8 x, uint8 y, uint32 val);
matrix* matmul(matrix* m1, matrix* m2);
uint32 det(matrix* m);
uint32 matrix_access(matrix* m, uint8 x, uint8 y);
void free_matrix(matrix* m);
void matrix_copy(matrix* src, matrix* dst);

#endif