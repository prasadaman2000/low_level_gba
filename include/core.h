#ifndef CORE_H
#define CORE_H

typedef unsigned char      uint8;
typedef unsigned short     uint16;
typedef unsigned int       uint32;
typedef int int32;

#define REG_DISPLAYCONTROL *((volatile uint32*)(0x04000000))
#define VIDEOMODE_3         0x0003
#define VIDEOMODE_4         0x0004
#define BGMODE_2            0x0400

void _panic();

#endif