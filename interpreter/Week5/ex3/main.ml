open Syntax
open Eval
       
let rec read_eval_print env =
  print_string "# ";
  flush stdout;
  let cmd = Parser.toplevel Lexer.main (Lexing.from_channel stdin) in
  let (id, newenv, v) = eval_command env cmd in
  (
   try
	print_command cmd;
   print_newline ();
   Printf.printf "%s = " id;
   print_value v;
   print_newline ();
   read_eval_print newenv
   with	| Parsing.Parse_error ->
	  print_endline "Parse Error!")

let initial_env =
  extend "i" (VInt 1)
	 (extend "v" (VInt 5)
		 (extend "x" (VInt 10)
			 empty_env))
    
let _ = read_eval_print initial_env
