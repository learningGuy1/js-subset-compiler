%token NUMBER PLUS MINUS TIMES DIV GPAREN DPAREN BOOLEAN EQ GREQ GR LOEQ LO NOT EOCOMMAND VAR ASSIGN EOF IF ELSE ET OBLOCK FBLOCK DO WHILE FUNC COMMA RETURN CALL UNDEFINED LET

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
	| LET VAR EOCOMMAND {}
	| IF GPAREN expression DPAREN commande ELSE commande {} 
	| WHILE GPAREN expression DPAREN commande {}
	| DO commande WHILE GPAREN expression DPAREN {}
	| FUNC VAR GPAREN decl_args DPAREN commande {}
	| RETURN expression EOCOMMAND {}
	;
decl_args:
	| {}
	| VAR {}
	| VAR COMMA decl_args {}
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
	| UNDEFINED {}
	| VAR ASSIGN expression {}
	| VAR {}
	| expression ASSIGN expression {}
	| expression ET expression {}
	| VAR GPAREN arguments DPAREN{}
	;
arguments: 
	| {}
	| expression {}
	| expression COMMA arguments {}
	;
