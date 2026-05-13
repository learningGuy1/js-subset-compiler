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

	(*ACCOLADES POUR BLOC DE CODE*)
	| '{'
		{ OBLOCK}
	| '}'
		{ FBLOCK }
	
	(*CONDITIONNEL IF*)
	| "if"
		{ IF }
	| "else"
		{ ELSE }
	
	(*CONDITIONNEL WHILE*)
	| "do"
		{ DO }
	| "while"
		{ WHILE }

	(*BOOLEENS*)
	| "true"|"false" 
		{ BOOLEAN }
	| '='
		{ ASSIGN }
	| '<'
		{ LO }
	| '>'
		{ GR }
	| "=="
		{ EQ }
	| ">="
		{ GREQ }
	| "<="
		{ LOEQ }
	| '!'
		{ NOT }
	| "&&"
		{ ET}
	| ';'
		{ EOCOMMAND }
	| "function"
		{ FUNC }
	| "return"
		{ RETURN }
	| ","
		{ COMMA }
	| "let"
		{ LET }
	| "undefined"
		{ UNDEFINED }
	| "null"
		{ NULL}
	| ":"
		{ COLUMN }
	| "."
		{ DOT }
	| ['a'-'z']+(['A'-'Z']|['a'-'z']|['0'-'9']|'_')*
		{ VAR }
	| eof
		{ EOF }
	| _
		{ raise TokenInconnu }	(*Lance une exception quand symbole inconnu*)
