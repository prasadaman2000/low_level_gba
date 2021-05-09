#ifndef GRAPHICS_H
#define GRAPHICS_H

#define SCREENBUFFER        ((volatile uint16*)0x06000000)
#define SCREEN_W            240
#define SCREEN_H            160
#define WHITE               0xFFFF
#define RED                 0x00FF
#define GREEN               0x0FF0
#define BLUE                0xFF00

void draw_pixel(int x, int y, unsigned short color);
void graphics_init();
void fill_color(unsigned short color);

#endif