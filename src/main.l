/* Nome: Mariane Tiemi Iguti RA: 147279 
   EA876 -Trabalho 01 */
%{

#include <stdlib.h>
#include <string.h>

void yyerror(char *);
#include "y.tab.h"

%}

IGNORA .*[\n]*
NOME [A-Za-z]+[_]*[:]*
%%

(<[\?]xml[ ]version=["]1[\.]0["][ ]encoding=["]ISO[\-]8859[\-]1["][\?]>) ;
(<[\?]xml[ ]version=["]1[\.]0["][ ]encoding=["]UTF[\-]8["][ ]standalone=["]yes["][\?]>) ;

(<[/]*PRESTADOR_CIDADE>) { return BELEM_PRESTADOR_TAG; }

(<[/]*TOMADOR_CIDADE>) { return BELEM_TOMADOR_TAG; }   
                         
(<[/]*VALOR_SERVICO>) { return BELEM_SERVICO_TAG; }

(<[/]*VALOR_ISS>) { return BELEM_ISS_TAG; }  

(<(ns3:)*PrestadorServico>) { printf("tag p:%s\n", yytext);return CORUMBA_PRESTADOR_ABRETAG; }

(<[/](ns3:)*PrestadorServico>) { printf("tag p:%s\n", yytext);return CORUMBA_PRESTADOR_FECHATAG; }

(<(ns3:)*Tomador>) { printf("tag t:%s\n", yytext);return CORUMBA_GERADOR_ABRETAG; }

(<[/](ns3:)*Tomador>) { printf("tag t:%s\n", yytext);return CORUMBA_GERADOR_FECHATAG; }

(<[/]*(ns3:)*CodigoMunicipio>) { printf("tag c:%s\n", yytext);return CORUMBA_CODIGO_TAG; }

(<[/]*(ns3:)*ValorServicos>) { return CORUMBA_SERVICO_TAG; }

(<[/]*(ns3:)*IssRetido>) {return CORUMBA_ISS_TAG; }                                                 

[<][A-Za-z][^>]+[>] { printf("abre:%s\n", yytext);
                yylval.string = strdup(yytext); 
                return ABRETAG;
              }
                
[<][/][^>]+[>] {/* printf("fecha:%s\n", yytext);*/return FECHATAG; }

[A-Za-z]+[ ]*[A-Za-z]*[ ]*[A-Za-z]* {// printf("string:%s\n", yytext);
                                        yylval.string = strdup(yytext);
                                        return STRING;
                                    }                                                     

([0-9]+[,]*[0-9]*)|([0-9]+[.]*[0-9]*) { 
                                        int i; int size = strlen(yytext); 
                                        for(i = 0; i < size; i++)
                                        { 
                                            if(yytext[i] == ',')
                                                yytext[i] = '.';    
                                        }
                                        yylval.number= atof(yytext);
                                       // printf("numero:%.2f\n", yylval.number);
                                        return NUMERO;

                                      }
[\t]* ;                                                                   
[\n] ;
. ;

%%

int yywrap() 
{  
  return 1;
}
