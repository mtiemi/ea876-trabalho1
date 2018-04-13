/* Nome: Mariane Tiemi Iguti RA: 147279 
   EA876 - Laboratório 3 - PythonListParser */
%{

#include <stdio.h>
#include <stdlib.h>
void yyerror(char *c);
int yylex(void);

%}

%token ABRETAG FECHATAG

%union
{
    char* string;
    float number;
}

%token <string> STRING
%token <number> NUMERO
%%

PROGRAMA: 
        PROGRAMA TAG {printf("Terminei.");}
        |
        ;
ELEMENTO:
        STRING
        | NUMERO
        | TAG
        | ELEMENTO ELEMENTO
        ;
TAG:
    ABRETAG ELEMENTO FECHATAG
    ;        
;
                    
%%

void yyerror(char *s) 
{
    printf("ERRO\n"); // em caso de lista invalida, print ERRO
}

int main() 
{
    yyparse();
    return 0;
}
