#include <stdio.h>
#include <string.h>

void main(void)
{
	char current, next;
	
	current=getchar();
	while(!feof(stdin)){		
		if(current=='\302'){
			next=getchar();
			if(!feof(stdin) && next=='\n')
				putchar('\n');
			else{
				putchar(current);
				if(!feof(stdin))
					putchar(next);
			}	
		}
		else if(current=='\303'){
			next=getchar();
			if(!feof(stdin) && next=='\n')
				putchar('\n');
			else
				if(!feof(stdin) && next!='\342'){
					putchar(current);
					if(!feof(stdin))
						putchar(next);
				}
				else if(!feof(stdin)){
					putchar('*');
					putchar('*');
				}	
		}
		else
			putchar(current);
		current=getchar();
	}
}

