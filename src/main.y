/* Nome: Mariane Tiemi Iguti RA: 147279 
   EA876 - Laboratório 3 - PythonListParser */
%{

#include <stdio.h>
#include <stdlib.h>
void yyerror(char *c);
int yylex(void);

%}

%token MUNICIPIO_PRESTADOR MUNICIPIO_GERADOR VALOR_SERVICO ISS_RETIDO IGNORA1

%union
{
    char* string;
    float number;
}

%token <string> CIDADE
%token <number> NUMERO
%%

PROGRAMA: 
        PROGRAMA DADOS_BELEM
        |
        ;

DADOS_BELEM:   
        IGNORA1 MUNICIPIO_PRESTADOR CIDADE MUNICIPIO_PRESTADOR IGNORA1 MUNICIPIO_GERADOR CIDADE MUNICIPIO_GERADOR IGNORA1 VALOR_SERVICO NUMERO VALOR_SERVICO ISS_RETIDO NUMERO ISS_RETIDO IGNORA1 { printf("%s, %s, %.2f, %.2f\n", $7, $3, $11, $14);}             

                       
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
