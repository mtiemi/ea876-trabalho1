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

[<]{NOME}+[>] { printf("tag:%s", yytext);return ABRETAG;}
[<][/]{NOME}+[>] { printf("tag:%s", yytext);return FECHATAG;}
[<].+[>];

[A-Za-z]+[ ]*[A-Za-z]*[ ]*[A-Za-z]* { yylval.string = strdup(yytext);
printf("string:%s", yytext);
                            return STRING;}                                                     

([0-9]+[,]*[0-9]*)|([0-9]+[.]*[0-9]*) { int i; int size = strlen(yytext); 
                    for(i = 0; i < size; i++)
                    { 
                        if(yytext[i] == ',')
                            yytext[i] = '.';    
                    }
                    yylval.number= atof(yytext);
                    printf("numero:%.2f", yylval.number);
                    return NUMERO;}
      
                               
[\n];

. ; 

%%

int yywrap() 
{  
  return 1;
}
