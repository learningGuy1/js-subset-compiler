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
	| (['0'-'9']*'.'?['0'-'9']+)|(['0'-'9']+'.'?['0'-'9']*) as lexem
		{ NUMBER(float_of_string lexem) }		(*Retourne Token NUMBER pour les flottants*)
	(*FLOTTANTS SCIENTIFIQUES*)
	| ( (['0'-'9']*'.'?['0'-'9']+)|(['0'-'9']+'.'?['0'-'9']*) )'e''-'?['0'-'9']+ as lexem
		{ NUMBER(float_of_string lexem) }
	(*NaN*)
	| "NaN"
		{ NUMBER(nan) }
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
	| "true"|"false" as lexem
		{ BOOLEAN(bool_of_string lexem) }
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
	
	| "function"
		{ FUNC }
	
	| "return"
		{ RETURN }
	| ","
		{ COMMA }
	| ['a'-'z']+(['A'-'Z']|['a'-'z']|['0'-'9']|'_')* as lexem
		{ VAR(lexem)}
	| eof
		{ EOF }
	| _
		{ raise TokenInconnu }	(*Lance une exception quand symbole inconnu*)


	
	
	
	
	
	
	
	
	
	
	
	
	
