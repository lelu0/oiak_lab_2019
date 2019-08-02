#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>

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
	
	Paint(image, screen); // RYSUJEMY!
	printf("I made it! \n");
	
	scanf("%c",&in);
	//clean up
	SDL_FreeSurface(image); //Zamknij obrazek
} 
