%token NUMBER PLUS MINUS TIMES DIV GPAREN DPAREN EOL EOCOMMAND

%left PLUS MINUS 	
%left TIMES DIV		
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
	| expression DIV expression
	{}
	| GPAREN expression DPAREN
	{}
	| MINUS expression %prec UMINUS
	{}
	| NUMBER
	{}
	;
