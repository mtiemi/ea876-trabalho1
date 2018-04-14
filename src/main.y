/* Nome: Mariane Tiemi Iguti RA: 147279 
   EA876 - Laboratório 3 - PythonListParser */
%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(char *c);
int yylex(void);

char* municipio_gerador, *municipio_prestador;
float valor_servico, valor_iss;
int codigo_corumba;

%}

%token FECHATAG BELEM_PRESTADOR_TAG BELEM_TOMADOR_TAG BELEM_SERVICO_TAG BELEM_ISS_TAG
%token CORUMBA_PRESTADOR_ABRETAG CORUMBA_PRESTADOR_FECHATAG CORUMBA_GERADOR_ABRETAG CORUMBA_GERADOR_FECHATAG CORUMBA_CODIGO_TAG CORUMBA_SERVICO_TAG CORUMBA_ISS_TAG

%union
{
    char* string;
    float number;
}

%token <string> STRING ABRETAG
%token <number> NUMERO
%%

PROGRAMA: 
        PROGRAMA TAG { printf("%s,%s,%.2f,%.2f\n", municipio_gerador, municipio_prestador, valor_servico, valor_iss); }
        |
        ;
        
ELEMENTO:
        STRING
        | NUMERO
        | TAG
        | ELEMENTO ELEMENTO
        |
        ;
TAG:   
    GERADOR_BELEM
    | PRESTADOR_BELEM
    | SERVICO_BELEM
    | ISS_BELEM
    | CODIGO_CORUMBA
    | SERVICO_CORUMBA
    | ISS_CORUMBA 
    | PRESTADOR_CORUMBA
    | GERADOR_CORUMBA    
    | ABRETAG ELEMENTO FECHATAG   
    ;   
     
PRESTADOR_BELEM:
             BELEM_PRESTADOR_TAG STRING BELEM_PRESTADOR_TAG {
                                                                municipio_prestador = malloc(sizeof(char));
                                                                strcpy(municipio_prestador, $2);        
                                                            } ;
GERADOR_BELEM:
            BELEM_TOMADOR_TAG STRING BELEM_TOMADOR_TAG {
                                                            municipio_gerador = malloc(sizeof(char));
                                                            strcpy(municipio_gerador, $2);
                                                        } ;                                        
SERVICO_BELEM:
            BELEM_SERVICO_TAG NUMERO BELEM_SERVICO_TAG { valor_servico = $2; } ;
            
ISS_BELEM:
        BELEM_ISS_TAG NUMERO BELEM_ISS_TAG { valor_iss = $2; } ;
        
CODIGO_CORUMBA:
            CORUMBA_CODIGO_TAG NUMERO CORUMBA_CODIGO_TAG { $<number>$ = $2;codigo_corumba = $2;} ; 
PRESTADOR_CORUMBA:
             CORUMBA_PRESTADOR_ABRETAG ELEMENTO CORUMBA_PRESTADOR_FECHATAG  {municipio_prestador = malloc(sizeof(char));
                                                                            // printf("codigo:%d\n", codigo_corumba);
                                                                        sprintf(municipio_prestador, "%d", codigo_corumba);
                                                                 } ;
GERADOR_CORUMBA:
             CORUMBA_GERADOR_ABRETAG ELEMENTO CORUMBA_GERADOR_FECHATAG  {municipio_gerador = malloc(sizeof(char));
             //printf("codigo2:%d\n", codigo_corumba);
                                                                sprintf(municipio_gerador, "%d", codigo_corumba);} 
             
                                                           
                                                                ;                                                                                              

SERVICO_CORUMBA:
        CORUMBA_SERVICO_TAG NUMERO CORUMBA_SERVICO_TAG { valor_servico = $2; } ;
        
ISS_CORUMBA:        
        CORUMBA_ISS_TAG NUMERO CORUMBA_ISS_TAG { valor_iss = $2; } ;                    
%%

void yyerror(char *s) 
{
    printf("ERRO\n"); // em caso de lista invalida, print ERRO
}

int main() 
{
    yyparse();
    free(municipio_gerador);
    free(municipio_prestador);
    
    return 0;
}
