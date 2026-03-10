type commande_a =
	Expr of expression_a
and expression_a =
	| Plus of expression_a * expression_a
	| Moins of expression_a * expression_a
	| Mult of expression_a * expression_a
	| Neg of expression_a
	| Num of int

type ast =
	| NULL
	| Noeud of type_noeud * int * ast * ast
and type_noeud = PLUS | MOINS | MULT | NEG | NUM
;;

(* Fonctions d'affichage *)

let rec print_commande form com = match com with
	| Expr e -> Format.fprintf form "@[<2>Exp(%a)@]" print_expr e

and print_expr form expr = match expr with
	| Plus (g,d) -> print_binaire form "+" g d
	| Moins (g,d) -> print_binaire form "-" g d
	| Mult (g,d) -> print_binaire form "*" g d
	| Neg e -> Format.fprintf form "@[<2>%s@ %a@]" "-'" print_expr e
	| Num n -> Format.fprintf form "@[<2>Num[%i]@]" n

and print_binaire form s g d =
	Format.fprintf form "@[<2>%s%s@ %a%s@ %a%s@]" s "(" print_expr g " ," print_expr d " )"
;;

let rec com_to_ast_expr expr = match expr with
	| Plus (g,d) -> Noeud(PLUS, 0, com_to_ast_expr g, com_to_ast_expr d)
	| Moins (g,d) -> Noeud(MOINS, 0, com_to_ast_expr g, com_to_ast_expr d)	
	| Mult (g,d) -> Noeud(MULT, 0, com_to_ast_expr g, com_to_ast_expr d)
	| Neg e -> Noeud(NEG, 0, com_to_ast_expr e, NULL)
	| Num n -> Noeud(NUM, n, NULL, NULL)
;;

let com_to_ast com = match com with
	| Expr e -> com_to_ast_expr e
;;

let code_string s n = match s with
	| PLUS -> "AddiNb\n"
	| MOINS -> "SubiNb\n"
	| MULT -> "MultNb\n"
	| NEG -> "NegaNb\n"
	| NUM -> "CstNb\n"^(string_of_int n)
;;

let rec code_ast ast = match ast with
	| NULL -> "";
	| Noeud(s,n,g,d) ->	code_ast g^(code_ast d)^(code_string s n)	
;;

let code com = let ast = com_to_ast com in code_ast ast
;;