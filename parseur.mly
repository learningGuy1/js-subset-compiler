
%{
  open AST
%}

%token <float> NUMBER
%token <bool> BOOLEAN
%token <string> VAR

%token NUMBER PLUS MINUS TIMES DIV GPAREN DPAREN BOOLEAN EQ GREQ GR LOEQ LO NOT EOCOMMAND VAR ASSIGN EOF IF ELSE ET

%left ASSIGN
%left EQ
%left GREQ LOEQ GR LO
%left PLUS MINUS 	
%left TIMES DIV		
%nonassoc NOT UMINUS 	

%type <AST.programme_a> main
%type <AST.commande_a> commande
%type <AST.expression_a> expression

%start main 
%%
main:
	commande EOF { Prog($1::[]) }
	| commande main  { let Prog(l)=$2 in Prog($1::l) } 
	;
commande:
	expression EOCOMMAND 		{ Expr($1) }
	;
expression:
	expression PLUS expression 	{ Plus($1,$3) }
	| expression MINUS expression 	{ Moins($1,$3) }
	| expression TIMES expression 	{ Mult($1,$3) }
	| expression DIV expression 	{ Div($1,$3) }
	| GPAREN expression DPAREN 	{ $2 }
	| MINUS expression %prec UMINUS	{ Neg $2 }
	| NUMBER 			{ Num($1) }
	| expression EQ expression
		{ Eq($1,$3) }
	| expression GREQ expression
		{ Greq($1,$3) }
	| expression GR expression
		{ Gr($1,$3) }
	| expression LOEQ expression
		{ Loeq($1,$3) }
	| expression LO expression
		{ Lo($1,$3) }
	| NOT expression
		{ Not($2) }
	| BOOLEAN
		{ Bool($1) }
	| VAR ASSIGN expression
		{ Assign($1,$3) }
	| VAR
		{ Var($1) }
	;
