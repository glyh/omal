{
  open Menhir_parser

  exception LexError of string

  let[@inline] failwith msg = raise (LexError msg)

  let [@inline] illegal c = 
    failwith (Printf.sprintf "[lexer] unexpected character: '%c'" c)
}

let WS = [ ' ' '\t' ]

let newline = "\r\n" | '\r' | '\n'

let int_tok = '-'?  ('0' | ['1' - '9'] ['0' - '9']*)

let ident0 = ['A'-'Z' 'a'-'z' '?' '*' '+'] 

let ident_rest = '-' | ident0 | ['0' - '9']

let ident_tok = ident0 ident_rest*

let keyword_tok = ':' ident_tok

rule next_token = parse
  | '(' { LPAREN }
  | ')' { RPAREN }
  | '[' { LBRACKET }
  | ']' { RBRACKET }
  | "true" { TRUE }
  | "false" { FALSE }
  | "nil" { NIL }
  | '"' { raw_string (Buffer.create 17) lexbuf }
  | ident_tok { SYMBOL (Lexing.lexeme lexbuf) }
  | keyword_tok { 
    let tok = Lexing.lexeme lexbuf in
    let tok_len = String.length tok in
    let tok_stripped = String.sub tok 1 (tok_len - 1) in
    KEYWORD (tok_stripped)
  }
  | int_tok { INT (int_of_string (Lexing.lexeme lexbuf))}
  | newline { Lexing.new_line lexbuf; next_token lexbuf }
  | eof { EOF }
  | _ { next_token lexbuf }
and raw_string buf = parse
  | newline 
    { failwith "[lexer] raw string literal spans across line" }
  | eof 
    { failwith "[lexer] unterminated raw string literal at EOF" }
  | '\\' '\\' { Buffer.add_char buf '\\'; raw_string buf lexbuf }
  | '\\' '"' { Buffer.add_char buf '"'; raw_string buf lexbuf }
  | '\\' 'n' { Buffer.add_char buf '\n'; raw_string buf lexbuf }
  | '"' { STR (Buffer.contents buf) }
  | [^ '"' '\\']+
    { 
      Buffer.add_string buf (Lexing.lexeme lexbuf);
      raw_string buf lexbuf
    }
