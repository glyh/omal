
let read source = 
  Parser.parse_string source

let print (value: Ast.value) =
  value |> Ast.string_of_value |> print_endline

let rep input = 
  input |> read |> Eval.eval |> print

let interactive () =
  while true do
    read_line () |> rep
  done

