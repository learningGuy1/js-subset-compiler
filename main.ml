let _ =
	try
		let lexbuf = Lexing.from_channel (open_in Sys.argv.(1)) in 	(*lexeur lancé sur stdin*)
		Parseur.main Lexeur.token lexbuf 	(*parseur une ligne*)
		|> Format.fprintf (Format.formatter_of_out_channel  (open_out Sys.argv.(2)) )  "%a\n%!" AST.print_programme  ;
	with
	| Lexeur.Eof -> exit 0
	| Lexeur.TokenInconnu					(*erreur de lexing*)
	| Parsing.Parse_error ->				(*erreur de parsing*)
		Printf.printf "Ceci n'est pas une expression arithmétique\n" 
