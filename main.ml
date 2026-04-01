let _ =
	try
		let lexbuf = Lexing.from_channel (open_in Sys.argv.(1)) in
		Parseur.main Lexeur.token lexbuf
	with
	| Lexeur.TokenInconnu ->				(*erreur de lexing*)
		Printf.printf "Erreur de lexing\n"
	| Parsing.Parse_error ->				(*erreur de parsing*)
		Printf.printf "Ceci n'est pas une expression arithmétique\n"
