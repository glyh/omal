type value = 
  | Symbol of string
  | String of string
  | Keyword of string
  | Int of int
  | Bool of bool
  | Nil
  | List of value list
  | Vec of value list

let to_char_list s = List.init (String.length s) (String.get s)

let quote_string (s: string) = 
  s
  |> to_char_list
  |> List.map (
    fun c -> 
      match c with
      | '\\' -> "\\\\"
      | '"' -> "\\\""
      | '\n' -> "\\n"
      | c -> String.make 1 c
    )
  |> String.concat ""
  (*String.s*)
  (*|> String.l*)

let rec string_of_value (f: value) =
  match f with
  | Symbol(s) -> s
  | String(s) ->
      "\"" ^ quote_string s ^ "\""
  | Keyword(k) ->
      ":" ^ k
  | Int(i) -> string_of_int i
  | Bool(true) -> "true"
  | Bool(false) -> "false"
  | Nil -> "nil"
  | List(fs) -> 
      "(" ^
      (fs |> List.map string_of_value |> String.concat " ") ^ 
      ")"
  | Vec(fs) -> 
      "[" ^
      (fs |> List.map string_of_value |> String.concat " ") ^ 
      "]"
