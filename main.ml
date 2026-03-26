let _ =
	try
		let lexbuf = Lexing.from_channel (open_in Sys.argv.(1)) in
		Parseur.main Lexeur.token lexbuf
	with
	| Lexeur.TokenInconnu					(*erreur de lexing*)
	| Parsing.Parse_error ->				(*erreur de parsing*)
		Printf.fprintf (open_out Sys.argv.(2)) "Ceci n'est pas une expression arithmétique\n"
