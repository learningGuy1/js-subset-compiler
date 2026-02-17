let _ =
	try
		let lexbuf = Lexing.from_channel stdin in 	(*lexeur lancé sur stdin*)
		while true do					(*on ne s'arrête pas*)
			Parseur.main Lexeur.token lexbuf	(*parseur une ligne*)
			|> Format.printf "%a\n%!" AST.print_commande ;
		done
	with
	| Lexeur.Eof -> exit 0
	| Lexeur.TokenInconnu					(*erreur de lexing*)
	| Parsing.Parse_error ->				(*erreur de parsing*)
		Printf.printf("Ceci n'est pas une expression arithmétique\n")
