%option noyywrap

%top {
    #include "query.h"
    #include "parser.h"
    #include <stdio.h>
    #include <stdlib.h>
}

%%

"+"       { return PLUS; }
"-"       { return MINUS; }
"*"       { return TIMES; }
"/"       { return DIVIDE; }
"("       { return LPAREN; }
")"       { return RPAREN; }

";"       { return SEMICOLON; }
","       { return POINT; }

"TRUE"    { return TRUE; }
"FALSE"   { return FALSE; }
"OR"      { return OR; }
"AND"     { return AND; }
"NOT"     { return NOT; }

"=="      { return EQUALS; }
"!="      { return NOT_EQUALS; }
"="       { return SET_EQUAL; }

"TABLE"   { return TABLE; }
"CREATE"  { return CREATE; }
"INSERT"  { return INSERT; }
"UPDATE"  { return UPDATE; }
"DELETE"  { return DELETE; }
"SELECT"  { return SELECT; }

"INTO" { return INTO; }
"VALUES" { return VALUES; }
"FROM" { return FROM; }
"WHERE" { return WHERE; }
"SET" { return SET; }



"INT" { return DT_INT; }
"REAL" { return DT_REAL; }
"TEXT" { return DT_TEXT; }
"CHAR" { return DT_CHAR; }
"VARCHAR" { return DT_VARCHAR; }


['][a-zA-Z0-9]+['] { 
    yylval.string_field = strdup(yytext);
    return VALUE_STRING;
}

[+-]?[1-9][0-9]* {
    yylval.integer_field = atoi(yytext);
    return NUMBER;
}

[+-]?([0-9]+[.])?[0-9]+ { 
    yylval.double_field = strtod(yytext, NULL);
    return REAL;
}

[a-zA-Z][a-zA-Z0-9]* { 
    yylval.string_field = strdup(yytext);
    return IDENTIFIER;
}


. ;
