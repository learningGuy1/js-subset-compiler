{
	open Parseur (*généré à partir de parseur.mly et définit les tokens*)
	exception Eof
	exception TokenInconnu
}

(*On utilise des expressions régulières pour reconnaître des patterns*)
rule token = parse
	[' ' '\t' '\r']
		{ token lexbuf } 	(*quand on lit un espace, une tabulation,... 
					on ne crée pas de token*)
	| ['\n']
		{ EOL }			(*Retourne Token EOL quand changement de ligne*)
	| ['0'-'9']+ as lexem
		{ NUMBER(int_of_string lexem) }		
	| '+'
		{ PLUS }		(*...*)
	| '-'
		{ MINUS }
	| '*'
		{ TIMES }
	| '('
		{ GPAREN }
	| ')'
		{ DPAREN }
	| ';'
		{ EOCOMMAND }
	| eof
		{ raise Eof }		(*Lance une exception quand fin de fichier*)
	| _
		{ raise TokenInconnu }	(*Lance une exception quand symbole inconnu*)
