{
	open Parseur (*généré à partir de parseur.mly et définit les tokens*)
	exception Eof
	exception TokenInconnu
}

(*On utilise des expressions régulières pour reconnaître des patterns*)
rule token = parse
	[' ' '\t' '\r' '\n']| "//"[^'\n']* 
		{ token lexbuf } 	(*quand on lit un espace, une tabulation,... 
					=on ne crée pas de token*)
	(*FLOTTANTS*)
	| ['0'-'9']+'.'?['0'-'9']* as lexem
		{ NUMBER(float_of_string lexem) }		(*Retourne Token NUMBER pour les entiers*)
	| '+'
		{ PLUS }		(*...*)
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
		
	| ';'
		{ EOCOMMAND }
	
	| eof
		{ EOF }		(*Lance une exception quand fin de fichier*)
	| _
		{ raise TokenInconnu }	(*Lance une exception quand symbole inconnu*)
