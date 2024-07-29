open Ast
module StrMap = Map.Make(String)

exception Error of string

let rec add_vs (vs: value list): int =
  match vs with
  | Int(i) :: rest -> i + add_vs rest
  | _ :: _ -> raise (Error "Expecting int in add")
  | [] -> 0

let sub_vs (vs: value list): int =
  match vs with
  | [Int(i); Int(j)] -> i - j 
  | _ -> raise (Error "Expecting 2 ints for sub")

let rec mul_vs (vs: value list): int =
  match vs with
  | Int(i) :: rest -> i * mul_vs rest
  | _ :: _ -> raise (Error "Expecting int in mul")
  | [] -> 0

let div_vs (vs: value list): int =
  match vs with
  | [Int(i); Int(j)] -> i / j 
  | _ -> raise (Error "Expecting 2 ints for div")

let repl_env: (value list -> value) StrMap.t = [
  ("+", fun vs -> Int(add_vs vs));
  ("-", fun vs -> Int(sub_vs vs));
  ("*", fun vs -> Int(mul_vs vs));
  ("/", fun vs -> Int(div_vs vs));
] |> List.to_seq |> StrMap.of_seq

let eval form =
  match form with
  | List(Symbol f :: args) ->
      begin match StrMap.find_opt f repl_env with
      | None -> raise (Error("No such function " ^ f))
      | Some(fn) -> fn args
      end
  | v -> v
