include Nice_parser.Make(struct
  type result = Ast.value
  type token = Menhir_parser.token
  exception ParseError = Menhir_parser.Error
  let parse = Menhir_parser.program_eof
  include Lexer
end)
