%token <float> NUMBER
%token PLUS MINUS TIMES DIV GPAREN DPAREN EOL EOCOMMAND

%left PLUS MINUS 	
%left TIMES DIV		
%nonassoc UMINUS 	
			
%type <float> main expression 
%start main 
%%
main:
	commande EOL { $1 } 
	;
commande:
	expression EOCOMMAND { $1 }
	;
expression:
	expression PLUS expression 	{ $1+.$3 }
	| expression MINUS expression 	{ $1-.$3 }
	| expression TIMES expression 	{ $1*.$3 }
	| expression DIV expression 	{ $1/.$3 }
	| GPAREN expression DPAREN	{ $2 	}
	| MINUS expression %prec UMINUS { -.$2	}
	| NUMBER 			{ $1 	}
	;
