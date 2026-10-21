%{
    #include <stdio.h>
%}



%%

"<"[a-zA-Z0-9]*">" {
    printf("OPENING %s TAG", yytext);
}

%%

int yywrap(void) {
    return 1;
}

int main(void){

    yylex();
    return 0;
}
