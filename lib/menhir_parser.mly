%{
  [@@@coverage exclude_file]
  open Ast

%}

%token EOF
%token LPAREN
%token RPAREN
%token LBRACKET
%token RBRACKET
%token TRUE
%token FALSE
%token NIL
%token <string> SYMBOL
%token <string> STR
%token <string> KEYWORD
%token <int> INT

%start <value> program_eof

%%

program_eof:
  | f=form EOF { f }

form:
  | s=SYMBOL { Symbol(s) }
  | s=STR { String(s) }
  | s=KEYWORD { Keyword(s) }
  | TRUE { Bool(true) }
  | FALSE { Bool(false) }
  | NIL { Nil }
  | i=INT { Int(i) }
  | LPAREN fs=list(form) RPAREN { List(fs) }
  | LBRACKET fs=list(form) RBRACKET { Vec(fs) }
