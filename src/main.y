/* Nome: Mariane Tiemi Iguti RA: 147279 
   EA876 - Laboratório 3 - PythonListParser */
%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(char *c);
int yylex(void);

char* municipio_gerador, *municipio_prestador, *municipio_aux;
float valor_servico, valor_iss;
int codigo_corumba, flag = 0;

%}

%token ABRETAG FECHATAG BELEM_PRESTADOR_TAG BELEM_TOMADOR_TAG BELEM_SERVICO_TAG BELEM_ISS_TAG
%token CORUMBA_JOAOMON_PRESTADOR_ABRETAG CORUMBA_JOAOMON_PRESTADOR_FECHATAG CORUMBA_JOAOMON_GERADOR_ABRETAG CORUMBA_JOAOMON_GERADOR_FECHATAG CORUMBA_JOAOMON_CODIGO_ABRETAG CORUMBA_JOAOMON_CODIGO_FECHATAG CORUMBA_JOAOMON_SERVICO_TAG CORUMBA_JOAOMON_ISS_TAG
%token SAOLUIS_PRESTADOR_ABRETAG SAOLUIS_PRESTADOR_FECHATAG SAOLUIS_GERADOR_ABRETAG SAOLUIS_GERADOR_FECHATAG SAOLUIS_MUNICIPIO_ABRETAG SAOLUIS_MUNICIPIO_FECHATAG SAOLUIS_SERVICO_TAG

%union
{
    char* string;
    float number;
}

%token <string> STRING
%token <number> NUMERO
%%

PROGRAMA: 
        PROGRAMA TAG { if(flag == 0 )
                        {
                            printf("%s,%s,%.2f,%.2f\n", municipio_gerador, municipio_prestador, valor_servico, valor_iss);
                        
                        }else if(flag == 1)
                        {
                            printf("%s,%s,%.2f,ISS Retido desconhecido\n", municipio_gerador, municipio_prestador, valor_servico);
                        }; }
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
    | GERADOR_SAOLUIS
    | PRESTADOR_SAOLUIS
    | SERVICO_SAOLUIS
    | MUNICIPIO_SAOLUIS
    | CODIGO_CORUMBA_JOAOMON
    | SERVICO_CORUMBA_JOAOMON
    | ISS_CORUMBA_JOAOMON
    | PRESTADOR_CORUMBA_JOAOMON
    | GERADOR_CORUMBA_JOAOMON   
    | ABRETAG ELEMENTO FECHATAG   
    | CORUMBA_JOAOMON_CODIGO_ABRETAG ELEMENTO CORUMBA_JOAOMON_CODIGO_FECHATAG
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
        
CODIGO_CORUMBA_JOAOMON:
            CORUMBA_JOAOMON_CODIGO_ABRETAG NUMERO CORUMBA_JOAOMON_CODIGO_FECHATAG { $<number>$ = $2;codigo_corumba = $2;}
            ; 
PRESTADOR_CORUMBA_JOAOMON:
             CORUMBA_JOAOMON_PRESTADOR_ABRETAG ELEMENTO CORUMBA_JOAOMON_PRESTADOR_FECHATAG  { municipio_prestador = malloc(sizeof(char));
                                                                            // printf("codigo:%d\n", codigo_corumba);
                                                                        sprintf(municipio_prestador, "%d", codigo_corumba);
                                                                 } ;
GERADOR_CORUMBA_JOAOMON:
             CORUMBA_JOAOMON_GERADOR_ABRETAG ELEMENTO CORUMBA_JOAOMON_GERADOR_FECHATAG  { municipio_gerador = malloc(sizeof(char));
             //printf("codigo2:%d\n", codigo_corumba);
                                                                sprintf(municipio_gerador, "%d", codigo_corumba);}                                                                        
                                                                ;                                                                                              

SERVICO_CORUMBA_JOAOMON:
        CORUMBA_JOAOMON_SERVICO_TAG NUMERO CORUMBA_JOAOMON_SERVICO_TAG { valor_servico = $2; } ;
        
ISS_CORUMBA_JOAOMON:        
        CORUMBA_JOAOMON_ISS_TAG NUMERO CORUMBA_JOAOMON_ISS_TAG { valor_iss = $2; } ;   
        
MUNICIPIO_SAOLUIS:
                SAOLUIS_MUNICIPIO_ABRETAG STRING SAOLUIS_MUNICIPIO_FECHATAG {municipio_aux = malloc(sizeof(char));
                                                                            strcpy(municipio_aux, $2);
                                                                            };
        
PRESTADOR_SAOLUIS:
             SAOLUIS_PRESTADOR_ABRETAG ELEMENTO SAOLUIS_PRESTADOR_FECHATAG {
                                                                municipio_prestador = malloc(sizeof(char));
                                                                strcpy(municipio_prestador, municipio_aux);        
                                                            } ;
GERADOR_SAOLUIS:
            SAOLUIS_GERADOR_ABRETAG ELEMENTO SAOLUIS_GERADOR_FECHATAG {
                                                            municipio_gerador = malloc(sizeof(char));
                                                            strcpy(municipio_gerador, municipio_aux);
                                                        } ;                                        
SERVICO_SAOLUIS:
            SAOLUIS_SERVICO_TAG NUMERO SAOLUIS_SERVICO_TAG { valor_servico = $2; flag = 1;} ;        
        
                         
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
