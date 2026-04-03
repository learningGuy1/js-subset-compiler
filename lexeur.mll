{
	open Parseur (*généré à partir de parseur.mly et définit les tokens*)
	exception TokenInconnu
}

(*On utilise des expressions régulières pour reconnaître des patterns*)
rule token = parse
	[' ' '\t' '\r' '\n'] | "//"[^'\n']* | ("/*"([^'*']*('*'[^'/'])*)*"*/") 

		{ token lexbuf } 	(*quand on lit un espace, une tabulation,... 
					on ne crée pas de token*)	

	(*FLOTTANTS*)
	| (['0'-'9']*'.'?['0'-'9']+)|(['0'-'9']+'.'?['0'-'9']*)
		{ NUMBER }		(*Retourne Token NUMBER pour les flottants*)
	(*FLOTTANTS SCIENTIFIQUES*)
	| ( (['0'-'9']*'.'?['0'-'9']+)|(['0'-'9']+'.'?['0'-'9']*) )'e''-'?['0'-'9']+
		{ NUMBER }
	(*VARIABLES*)
	(*NaN*)
	| "NaN"
		{ NUMBER }
	| '+'
		{ PLUS }		
	| '-'
		{ MINUS }
	| '*'
		{ TIMES }
	| '/'
		{ DIV }
	| '('
		{ GPAREN }
	| ')'
		{ DPAREN }
	(*Parentheses de block de code *)
	| '{'
		{ OBLOCK}
	| '}'
		{ FBLOCK }
		
	| "if"
		{ IF }
	| "else"
		{ ELSE }
	
	(*BOOLEENS*)
	| "true"|"false" 
		{ BOOLEAN }
	| "=="
		{ EQ }
	| ">="
		{ GREQ }
	| '>'
		{ GR }
	| "<="
		{ LOEQ }
	| '<'
		{ LO }
	| '!'
		{ NOT }
	| "&&"
		{ ET}
	| '='
		{ ASSIGN }
		
	| ';'
		{ EOCOMMAND }
	| ['a'-'z']+(['A'-'Z']|['a'-'z']|['0'-'9']|'_')* 
		{ VAR }
	| eof
		{ EOF }
	| _
		{ raise TokenInconnu }	(*Lance une exception quand symbole inconnu*)
