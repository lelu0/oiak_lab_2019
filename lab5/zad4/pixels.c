#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>

Uint32 getpixel(SDL_Surface *surface, int x, int y)
{
int bpp = surface->format->BytesPerPixel;
Uint8 *p = (Uint8 *)surface->pixels + y *surface->pitch + x *bpp;
switch(bpp) {
case 1:
	return *p;
case 2:
	return *(Uint16*)p;
case 3:
	if(SDL_BYTEORDER == SDL_BIG_ENDIAN)
		return p[0] << 16 | p[1] << 8 | p[2];
//składowe koloru (BE)
	else
		return p[0] | p[1] << 8 | p[2] << 16; 
//składowe koloru (LE)
	case 4:
		return *(Uint32 *)p;
	default:
		return 0;   
}
}

void putpixel(SDL_Surface *surface, int x, int y, Uint32 pixel){
int bpp = surface->format->BytesPerPixel;
Uint8 *p = (Uint8 *)surface->pixels + y * surface->pitch + x * bpp;
switch(bpp) {

case 1:
*p = pixel;
break;
case 2:
*(Uint16 *)p = pixel;
break;
case 3:
if(SDL_BYTEORDER == SDL_BIG_ENDIAN) {
p[0] = (pixel >> 16) & 0xff;
//składowa niebieska (BE)
p[1] = (pixel >> 8) & 0xff; 
//składowa zielona
p[2] = pixel & 0xff;
//składowa czerwona (BE)
} else {
p[0] = pixel & 0xff; 
//składowa czerwona (LE)
p[1] = (pixel >> 8) & 0xff; 
//składowa zielona
p[2] = (pixel >> 16) & 0xff; 
//składowa niebieska (LE)
}
break;
case 4:
*(Uint32 *)p = pixel;
break; 
}
}

