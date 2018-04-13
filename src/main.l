/* Nome: Mariane Tiemi Iguti RA: 147279 
   EA876 -Trabalho 01 */
%{

#include <stdlib.h>
#include <string.h>

void yyerror(char *);
#include "y.tab.h"

%}

IGNORA .+[\n]*

%%

([ ]*<PRESTADOR_CIDADE>)|(<[/]PRESTADOR_CIDADE>[\n]) { return MUNICIPIO_PRESTADOR;}

([ ]*<TOMADOR_CIDADE>)|(<[/]TOMADOR_CIDADE>[\n]) { return MUNICIPIO_GERADOR;}

([ ]*<VALOR_ISS>)|(<[/]VALOR_ISS>[\n]) { return ISS_RETIDO;}

([ ]*<VALOR_SERVICO>)|(<[/]VALOR_SERVICO>[\n]) { return VALOR_SERVICO;}

(<[\?]xml[ ]version=["]1[\.]0["][ ]encoding=["]ISO[\-]8859[\-]1["][\?]>){IGNORA}*(<[/]PRESTADOR_CIDADE_CODIGO>[\n])|([ ]*<PRESTADOR_UF>){IGNORA}*(<[/]TOMADOR_CIDADE_CODIGO>[\n])|([ ]*<TOMADOR_UF>){IGNORA}*(<[/]VALOR_DEDUCAO>[\n])|([ ]*<VALOR_PIS>){IGNORA}* { return IGNORA1;}

[A-Z]+[ ]*[A-Z]*[ ]*[A-Z]* { yylval.string = strdup(yytext);
                            return CIDADE;}                                                     

[0-9]+[,]*[0-9]* { int i; int size = strlen(yytext); 
                    for(i = 0; i < size; i++)
                    { 
                        if(yytext[i] == ',')
                            yytext[i] = '.';    
                    }
                    yylval.number= atof(yytext);
                    return NUMERO; }
                    
                    
                    
                    
                    
                               
[\n]; 

%%

int yywrap() 
{  
  return 1;
}
