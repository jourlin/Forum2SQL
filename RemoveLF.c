#include <stdio.h>
#include <string.h>

void main(void)
{
	char line[255];
	int i=1,j;
	while(!feof(stdin)){
		gets(line);
		if((i%3)==0)
			puts(line);
		else{	
			printf("%s", line);
		}
		i++;
	}
}
