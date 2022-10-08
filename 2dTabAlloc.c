#include <stdlib.h>
#include <stdio.h>


int**	_Alloc(int **tab, int a ,int b){
	int i = 0;
    int x = 0;
    int y = 0;

	tab = (int **)malloc(a * sizeof(int *));
	while (i < a){
		tab[i] = (int *)malloc(b * sizeof(int));
		i++;
	}
	while (x < a)
    {
        while(y < b)
            {
                tab[x][y] = 9;
                y++;
            }
        y = 0;
        x++;
    }
	return (tab);
}

void	_Free(int **tab, int x){
	int i = 0;

    i = 0;
	while(i < x){
		free (tab[i]);
		i++;
	}
	free(tab);
}
/*
void 	_Print(int **tab, int x, int y){

        printf("-------Global-------\n");
	for(int a = 0; a < x; a++){
        	for(int b = 0; b < y; b++){
                        printf("%2d",tab[a][b]);
                }
                printf("\n");

        }
        printf("-------Global-------\n");
}

void	_PrintSingle(int **tab, int x, int y){
        printf("-------Choice-------\n");
	printf("%d",tab[x][y]);
	printf("\n");
}

int 	main(void){

	int **tab;
	int x = 9;
	int y = 9;


	int a = 4;
	int b = 3;
    tab = NULL;
	tab = _Alloc(tab, x, y);
	_Print(tab,x,y);
	_PrintSingle(tab, a, b);
	_Free(tab,x);

	return 0;
}*/
