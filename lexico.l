/*SECCION DEFINICIONES*/

%{
#include <stdio.h>
#include <stdlib.h>

FILE *yyin;
%}

/*SECCION OPCIONES*/
%option noyywrap
%option yylineno

/*aca definimos los tokens mas elementales*/
DIGITO              [0-9]
LETRA               [A-Za-z]
OPERADORES          [*/\-+]
PUNTO               "."
ESPACIO             " "
ID                  {LETRA}({LETRA}|{DIGITO})*
CONST_INT           {DIGITO}+
CONST_FLOAT         {DIGITO}+{PUNTO}{DIGITO}+
/*CONST_STRING        \"({LETRA}|{DIGITO}|{OPERADORES}|{ESPACIO})*\"*/
CONST_STRING        \"[^"\n]*\"
PUNTO_COMA          ";"
PARENTESIS_ABRE     "("
PARENTESIS_CIERRA   ")"
LLAVE_ABRE          "{"
LLAVE_CIERRA        "}"
OP_SUMA             "+"
OP_RESTA            "\-"
OP_MULTIPLICA       "*"
OP_DIVISION         "/"
OP_IGUAL            ":"
OP_MENOR            "<"
OP_MAYOR            ">"
OP_MENOR_IGUAL      "<="
OP_MAYOR_IGUAL      ">="
OP_IGUAL_CONDICION  "=="
OP_NEGADO           "!="
COMA                ","
BARRA               "/"
ASTERISCO           "*"
COMENTARIO          {BARRA}{ASTERISCO}[^*/]*{ASTERISCO}{BARRA}
TAB                 "\t"
/*SALTO_LINEA         "\n"*/
/*palabras reservadas*/
ENTERO_DEC          "Integer"
FLOAT_DEC           "Float"
ESCRITURA           "write"
DECVAR              "DECVAR"
ENDDEC              "ENDDEC"
WHILE               "while"
CONDICION_IF        "if"
CONDICION_ELSE      "else"

/*SECCION REGLAS*/
%%
{ENTERO_DEC}            {printf("declaracion de entero: %s\n",yytext);}
{FLOAT_DEC}             {printf("declaracion de float: %s\n",yytext);}
{ESCRITURA}             {printf("escritura: %s\n",yytext);}
{DECVAR}                {printf("inicio de declaracion variables: %s\n",yytext);}
{ENDDEC}                {printf("fin de declarcion variables: %s\n",yytext);}
{WHILE}                 {printf("bucle while: %s\n",yytext);}
{CONDICION_IF}          {printf("condicion if: %s\n",yytext);}
{CONDICION_ELSE}        {printf("condicion else: %s\n",yytext);}

{CONST_INT}             {printf("constante entera: %s\n",yytext);}
{CONST_FLOAT}           {printf("constante float: %s\n",yytext);}
{CONST_STRING}          {printf("constante texto: %s\n",yytext);}
{ID}                    {printf("Identificador: %s\n",yytext);}
{COMA}                  {printf("coma: %s\n",yytext);}
{PUNTO_COMA}            {printf("punto y coma: %s\n",yytext);}
{PARENTESIS_ABRE}       {printf("parentesis abre: %s\n",yytext);}
{PARENTESIS_CIERRA}     {printf("parentesis cierra: %s\n",yytext);}
{LLAVE_ABRE}            {printf("llave abre: %s\n",yytext);}
{LLAVE_CIERRA}          {printf("llave cierra: %s\n",yytext);}
{OP_SUMA}               {printf("operador suma: %s\n",yytext);}
{OP_RESTA}              {printf("operador resta: %s\n",yytext);}
{OP_MULTIPLICA}         {printf("operador multipicacion: %s\n",yytext);}
{OP_DIVISION}           {printf("operador division: %s\n",yytext);}
{OP_IGUAL}              {printf("operador igual: %s\n",yytext);}
{OP_MENOR}              {printf("operador <: %s\n",yytext);}
{OP_MAYOR}              {printf("operador mayor: %s\n",yytext);}
{OP_MENOR_IGUAL}        {printf("operador menor o igual: %s\n",yytext);}
{OP_MAYOR_IGUAL}        {printf("operador mayor o igual: %s\n",yytext);}
{OP_IGUAL_CONDICION}    {printf("operador igual condicional: %s\n",yytext);}
{OP_NEGADO}             {printf("operador negado: %s\n",yytext);}
{COMENTARIO}            {printf("comentario\n");}
{TAB}
{ESPACIO}
.                       {yyerror();}

%%

int main(int argc,char *argv[])
{
    if((yyin = fopen(argv[1],"rt")) == NULL)
    {
        printf("\nNo se puede abrir el archivo: %s\n", argv[1]);
    }
    else {
        yylex();
    }
    printf("cantidad de lineas %d",yylineno);
    fclose(yyin);

    return 0;
}

int yyerror(void){
    printf("Error lexico encontrado\n. \"%s\" no es valido\n",yytext);
    exit(1); 
}