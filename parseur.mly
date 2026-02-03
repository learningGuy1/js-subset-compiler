%token NUMBER PLUS MINUS TIMES GPAREN DPAREN EOL EOCOMMAND

%left PLUS MINUS 	
%left TIMES 		
%nonassoc UMINUS 	
			
%type <unit> main commande expression 
%start main 
%%
main:
	commande EOL {} 
	;
commande:
	expression EOCOMMAND {}
	;
expression:
	expression PLUS expression
	{}
	| expression MINUS expression
	{}
	| expression TIMES expression
	{}
	| GPAREN expression DPAREN
	{}
	| MINUS expression %prec UMINUS
	{}
	| NUMBER
	{}
	;
