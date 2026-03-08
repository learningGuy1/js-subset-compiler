type commande_a =
	Expr of expression_a
and expression_a =
	| Plus of expression_a * expression_a
	| Moins of expression_a * expression_a
	| Mult of expression_a * expression_a
	| Div of expression_a * expression_a
	| Neg of expression_a
	| Num of float
;;

(* Fonctions d'affichage *)

let rec print_commande form com = match com with
	| Expr e -> Format.fprintf form "@[<2>Exp(%a)@]" print_expr e

and print_expr form expr = match expr with
	| Plus (g,d) -> print_binaire form "+" g d
	| Moins (g,d) -> print_binaire form "-" g d
	| Mult (g,d) -> print_binaire form "*" g d
	| Div (g,d) -> print_binaire form "/" g d
	| Neg e -> Format.fprintf form "@[<2>%s@ %a@]" "-'" print_expr e
	| Num n -> Format.fprintf form "@[<2>Num[%f]@]" n

and print_binaire form s g d =
	Format.fprintf form "@[<2>%s%s@ %a%s@ %a%s@]" s "(" print_expr g " ," print_expr d " )"
;;
