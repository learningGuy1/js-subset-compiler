%token NUMBER PLUS MINUS TIMES DIV GPAREN DPAREN BOOLEAN EQ GREQ GR LOEQ LO NOT EOL EOCOMMAND

%left EQ
%left GREQ LOEQ GR LO
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
	| expression EQ expression
	{}
	| expression GREQ expression
	{}
	| expression GR expression
	{}
	| expression LOEQ expression
	{}
	| expression LO expression
	{}
	| NOT expression
	{}
	| BOOLEAN
	{}
	;
