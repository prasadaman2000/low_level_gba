#include "../include/core.h"
#include "../include/mem.h"

typedef struct matrix_t {
    uint8 dim1;
    uint8 dim2;
    uint32* data;
} matrix;


matrix* new_matrix(uint8 n, uint8 m) {
    matrix* mat = malloc(sizeof(matrix));
    mat->dim1 = n;
    mat->dim2 = m;
    mat->data = malloc(sizeof(uint32) * n * m);
    uint32* d = mat->data;
    while (d < mat->data + n * m) {
        *d = 0;
        ++d;
    }
    return mat;
}

void matrix_write(matrix* mat, uint8 x, uint8 y, uint32 val) {
    uint32* location = mat->data + y + x * (mat->dim1);
    _write_debug_value((uint32)location);
    *location = val;
}

uint32 matrix_access(matrix* mat, uint8 x, uint8 y) {
    return *(mat->data + y + x * (mat->dim1));
}

void free_matrix(matrix* m) {
    free(m->data);
    free(m);
}

matrix* matmul(matrix* m1, matrix* m2) {
    if (m1->dim2 != m2->dim1) {
        return NULL;
    }

    matrix* to_ret = new_matrix(m1->dim1, m2->dim2);
    for (uint8 m1x = 0; m1x < m1->dim1; ++m1x) {
        for (uint8 m1y = 0; m1y < m1->dim2; ++m1y) {
            for (uint8 m2y = 0; m2y < m2->dim2; ++m2y) {
                uint32 new_val = matrix_access(to_ret, m1x, m2y)
                    + matrix_access(m1, m1x, m1y) * matrix_access(m2, m1y, m2y);
                matrix_write(to_ret, m1x, m2y, new_val);
            }
        }
    }

    return to_ret;
}

uint32 det(matrix* m) {
    if ((m->dim1 != 3) && (m->dim2 != 3)) {
        return 0;
    }

    uint32 a = matrix_access(m, 0, 0);
    uint32 b = matrix_access(m, 0, 1);
    uint32 c = matrix_access(m, 0, 2);
    uint32 d = matrix_access(m, 1, 0);
    uint32 e = matrix_access(m, 1, 1);
    uint32 f = matrix_access(m, 1, 2);
    uint32 g = matrix_access(m, 2, 0);
    uint32 h = matrix_access(m, 2, 1);
    uint32 i = matrix_access(m, 2, 2);

    return a * (e * i - f * h) - b * (d * i - f * g) + c * (d * h - e * g);
}

void matrix_copy(matrix* src, matrix* dst) {
    if ((src->dim1 > dst->dim1) || (src->dim2 > dst->dim2)) {
        _write_debug_value(0xBEEF);
        _panic();
    }

    for (uint8 srcX = 0; srcX < src->dim1; ++srcX) {
        for (uint8 srcY = 0; srcY < src->dim2; ++srcY) {
            matrix_write(dst, srcX, srcY, matrix_access(src, srcX, srcY));
        }
    }
}



/*
1 2    1 3 5      m1(0,0) * m2(0,0) + m1()
3 4    2 4 6
5 6

 */