#ifndef TIME_INT_H
#define TIME_INT_H

#include "core.h"

#define REGINT (*(uint32 *)(0x4000200))
#define TIME0INT ((uint8)0b11)

#define TIME0REG (*(uint16 *)(0x4000100))
#define TIME0CNTL (*(uint16 *)(0x4000102))

void set_timer(uint16 time);
#endif