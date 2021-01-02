#define SCREENBUFFER        ((volatile uint16*)0x06000000)
#define SCREEN_W            240
#define SCREEN_H            160

void draw_pixel(int x, int y, int color);
void graphics_init();