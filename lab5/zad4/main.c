#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>
#include "pixels.h"


SDL_Surface *Load_image(char *file_name)
{
	SDL_Surface *tmp = IMG_Load(file_name);
	// Otwórz plik z obrazem*/
	if (tmp == NULL) {
		fprintf(stderr, "Sth gone wrong \n");
		exit(0);
	}
	return tmp;
}

void Paint(SDL_Surface *image, SDL_Surface *screen){
	SDL_BlitSurface(image, NULL, screen, NULL);
	SDL_UpdateRect(screen,0,0,0,0);
}

void negative(SDL_Surface *original, SDL_Surface *result){
	Uint32 pixel;
	for(int h=0; h < original->h; h++){
		for(int w=0; w < original->w; w++){ 
			pixel = getpixel(original, original->w-w, h);
			__asm__(
			"movq %0, %%mm0;"
			"pcmpeqd %%mm1, %%mm1;"
			"pxor %%mm1, %%mm0;"
			"pandn %%mm1, %%mm0;"
			"movq %%mm0, %0;"
			:"=r" (pixel)
			:"r" (pixel));
			putpixel(result, w,h,pixel);
		}
	}
}

void main(){
	SDL_SetVideoMode(640,480,16, SDL_HWSURFACE); //dziwne, ale tylko z tym dziala
	SDL_Surface *screen, *image;
	Uint32 flags;
	int depth;
	char in; 
	SDL_Event event;
	flags = SDL_SWSURFACE;

	image = Load_image("sample.bmp");
	SDL_WM_SetCaption("sample.bmp", "showimage");
	depth = SDL_VideoModeOK(image->w, image->h, 32, flags);	
	printf("depth: %d \n", depth);
	if(depth == 0) exit(0);
	screen = SDL_SetVideoMode(image->w, image->h, 32, flags);	

	if( image->format->palette && screen->format->palette) //ustawia palete, jesli istnieje
		SDL_SetColors(screen, image->format->palette->colors, 0, image->format->palette->ncolors);
	
	SDL_Surface *flipped = Load_image("sample.bmp");
	SDL_LockSurface(image);
	SDL_LockSurface(flipped);
	printf("Make it negative! \n");
	negative(image, flipped);
	SDL_UnlockSurface(image);
	SDL_UnlockSurface(flipped);
	Paint(flipped, screen); // RYSUJEMY!
	printf("I made it! \n");
	
	scanf("%c",&in);
	//clean up
	SDL_FreeSurface(image); //Zamknij obrazek
} 
