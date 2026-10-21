%{
    #include <stdio.h>
    #include <string.h>
    char tag_name[256];
%}

%x TAG
%x ATTRIBUTE_VALUE

%%

"</"[a-zA-Z0-9_]*">" {
    printf("CLOSING %s TAG", yytext);
}

"<" {
    BEGIN(TAG);
}

<TAG>[a-zA-Z0-9]+ {
    strcpy(tag_name, yytext);
}

<TAG>[ \t]+[a-zA-Z_][a-zA-Z0-9_]*"=" {
    printf("ATTRIBUTE NAME: %s\n", yytext);
    BEGIN(ATTRIBUTE_VALUE);
}

<ATTRIBUTE_VALUE>\" {
    printf("ATTRIBUTE VALUE: ");
}

<ATTRIBUTE_VALUE>[^"]+ {
    printf("%s\n", yytext);
    BEGIN(TAG);
}

<TAG>">" {
    printf("OPENING %s TAG\n", tag_name);
    BEGIN(INITIAL);
}



%%

int yywrap(void) {
    return 1;
}

int main(void) {
    yylex();
    return 0;
}