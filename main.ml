let _ =
	try
		let lexbuf = Lexing.from_channel (open_in Sys.argv.(1)) in 	(*lexeur lancé sur stdin*)
		while true do					(*on ne s'arrête pas*)
			Parseur.main Lexeur.token lexbuf	(*parseur une ligne*)
		done
	with
	| Lexeur.Eof -> exit 0
	| Lexeur.TokenInconnu					(*erreur de lexing*)
	| Parsing.Parse_error ->				(*erreur de parsing*)
		Printf.fprintf (open_out Sys.argv.(2)) "Ceci n'est pas une expression arithmétique\n"
