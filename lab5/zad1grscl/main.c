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
	flags = SDL_SWSURFACE||SDL_HWPALETTE;

	//czarno-biala paleta z https://www.libsdl.org/release/SDL-1.2.15/docs/html/sdlsetcolors.html
	SDL_Color colors[256];
	int i;

	/* Fill colors with color information */
	for(i=0;i<256;i++){
  		colors[i].r=i;
  		colors[i].g=i;
  		colors[i].b=i;
	}



	image = Load_image("sample.bmp");
	SDL_WM_SetCaption("sample.bmp", "showimage");
	depth = SDL_VideoModeOK(image->w, image->h, 32, flags);	
	printf("depth: %d \n", depth);
	if(depth == 0) exit(0);
	screen = SDL_SetVideoMode(image->w, image->h, 32, flags);	
	
	SDL_SetColors(screen, colors, 0, 256); //ustawia czarno biala palete
	
	Paint(image, screen); // RYSUJEMY!
	printf("I made it! \n");
	
	scanf("%c",&in);
	//clean up
	SDL_FreeSurface(image); //Zamknij obrazek
} 
