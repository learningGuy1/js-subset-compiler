%{
  open AST
   let print_args l =
    List.iter (fun a -> Printf.printf "arg: %s\n" a) l;
    flush stdout
%}

%token <float> NUMBER
%token <bool> BOOLEAN
%token <string> VAR
%token NUMBER PLUS MINUS TIMES DIV GPAREN DPAREN BOOLEAN EQ GREQ GR LOEQ LO NOT EOCOMMAND VAR ASSIGN EOF IF ELSE ET OBLOCK FBLOCK DO WHILE FUNC COMMA RETURN CALL UNDEFINED

%right ASSIGN
%left ET
%left EQ
%left GREQ LOEQ GR LO
%left PLUS MINUS 	
%left TIMES DIV		
%nonassoc NOT UMINUS 	


%type <AST.programme_a> main
%type <AST.commande_a> commande
%type <AST.expression_a> expression
%type <AST.call_arguments_a> arguments
%type <AST.decl_args> decl_args


%start main 
%%
main:
	| EOF { Prog([]) }
	| commande { Prog($1::[]) }
	| commande main  { let Prog(l)=$2 in Prog($1::l) } 
	;
commande:
	expression EOCOMMAND  { Expr($1) }
	| EOCOMMAND { Semicol }
	| OBLOCK main FBLOCK { Block($2) }
	| IF GPAREN expression DPAREN commande ELSE commande { IfThenElse($3,$5,$7) } 
	| WHILE GPAREN expression DPAREN commande { While($3,$5) }
	| DO commande WHILE GPAREN expression DPAREN { DoWhile($2,$5) }
	| FUNC VAR GPAREN decl_args DPAREN commande {Function($2,$4,$6)}
	| RETURN expression EOCOMMAND {Return($2)}
	;
decl_args:
	| {Dec_args([])}
	| VAR {Dec_args($1::[])}
	| VAR COMMA decl_args { let Dec_args(l) = $3 in Dec_args($1::l) }
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
	| UNDEFINED 
		{ Undefined }
	| VAR ASSIGN expression
		{ Assign($1,$3) }
	| VAR
		{ Var($1) }
	| expression ET expression { Et($1,$3) }
	| VAR GPAREN arguments DPAREN{ FCall($1,$3)}
	;
arguments: 
	|  {Call_args([])}
	| expression {Call_args ($1::[])}
	| expression COMMA arguments { let Call_args(l) =$3 in Call_args($1::l)}
	;
