/* Nome: Mariane Tiemi Iguti RA: 147279 
   EA876 -Trabalho 01 */
%{

#include <stdlib.h>
#include <string.h>

void yyerror(char *);
#include "y.tab.h"

%}

IGNORA .*[\n]*
NOME [A-Z]+[_]*
%%

(<[\?]xml[ ]version=["]1[\.]0["][ ]encoding=["]ISO[\-]8859[\-]1["][\?]>) ;

(<[/]*PRESTADOR_CIDADE>) { return BELEM_PRESTADOR_TAG; }

(<[/]*TOMADOR_CIDADE>) { return BELEM_TOMADOR_TAG; }   
                         
(<[/]*VALOR_SERVICO>) { return BELEM_SERVICO_TAG; }

(<[/]*VALOR_ISS>) { return BELEM_ISS_TAG; }                                                        

[<]{NOME}+[>] { 
                yylval.string = strdup(yytext); 
                return ABRETAG;
              }
                
[<][/]{NOME}+[>] { return FECHATAG; }


[A-Za-z]+[ ]*[A-Za-z]*[ ]*[A-Za-z]* { 
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
                                        //printf("numero:%.2f\n", yylval.number);
                                        return NUMERO;
                                      }                             
[\n] ;
. ;

%%

int yywrap() 
{  
  return 1;
}
