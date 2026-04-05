%token NUMBER PLUS MINUS TIMES DIV GPAREN DPAREN BOOLEAN EQ GREQ GR LOEQ LO NOT EOCOMMAND VAR ASSIGN EOF IF ELSE ET OBLOCK FBLOCK DO WHILE

%right ASSIGN
%left ET
%left EQ
%left GREQ LOEQ GR LO
%left PLUS MINUS 	
%left TIMES DIV		
%nonassoc NOT UMINUS 	

%type <unit> main commande expression	
%start main 
%%
main:
	 EOF {}
	| commande {}
	| commande main  {}
	;
commande:
	expression EOCOMMAND {}
	| EOCOMMAND {}
	| OBLOCK main FBLOCK {}
	| IF GPAREN expression DPAREN commande ELSE commande {} 
	| WHILE GPAREN expression DPAREN commande {}
	| DO commande WHILE GPAREN expression DPAREN {}
	;
expression:
	expression PLUS expression {}
	| expression MINUS expression {}
	| expression TIMES expression {}
	| expression DIV expression {}
	| GPAREN expression DPAREN {}
	| MINUS expression %prec UMINUS {}
	| NUMBER {}
	| expression EQ expression {}
	| expression GREQ expression {}
	| expression GR expression {}
	| expression LOEQ expression {}
	| expression LO expression {}
	| NOT expression %prec NOT {}
	| BOOLEAN {}
	| VAR ASSIGN expression {}
	| VAR {}
	| expression ET expression {}
	;
