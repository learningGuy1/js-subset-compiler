type programme_a =
	Prog of commande_a list
and commande_a =
	Expr of expression_a
	| Block of programme_a
	| Let of string
	| IfThenElse of expression_a * commande_a* commande_a
	| While of expression_a * commande_a
	| DoWhile of commande_a * expression_a
	| Semicol
	| Function of string * decl_args * commande_a
	| Return of expression_a
and decl_args =
	 Dec_args of string list
and expression_a =
	| Plus of expression_a * expression_a
	| Moins of expression_a * expression_a
	| Mult of expression_a * expression_a
	| Div of expression_a * expression_a
	| Neg of expression_a
	| Num of float
	| Eq of expression_a * expression_a
	| Greq of expression_a * expression_a
	| Gr of expression_a * expression_a
	| Loeq of expression_a * expression_a
	| Lo of expression_a * expression_a
	| Not of expression_a
	| Bool of bool
	| Undefined
	| Assign of string * expression_a
	| Var of string
	| Et of expression_a * expression_a
	| FCall of string * call_arguments_a
and call_arguments_a =
	| Call_args of expression_a list
;;

(* Fonctions d'affichage *)

let rec print_programme form prog = match prog with
	| Prog(l) -> (match l with 
					| com::ll -> print_commande form com; print_programme form (Prog(ll))
					| [] -> ())
and print_commande form com = match com with
	| Expr e -> Format.fprintf form "Exp(%a)\n" print_expr e
	| Block c -> Format.fprintf form "Block(%a)\n" print_programme c 
	| Let x -> Format.fprintf form "Let[%s]\n" x
	| IfThenElse (cond,den,els) -> Format.fprintf form "IfThenElse(%a, %a, %a)\n"
      print_expr cond
      print_commande den
      print_commande els 
    | While (cond,com) -> Format.fprintf form "While(%a, %a)\n"
      print_expr cond
      print_commande com 
    | DoWhile (com,cond) -> Format.fprintf form "DoWhile(%a, %a)\n"
      print_commande com 
      print_expr cond
    | Semicol -> Format.fprintf form ""
    | Function (f,param,fcode) -> Format.fprintf form "%s((%a),%a)\n"
    	f
    	print_param param
    	print_commande fcode
    | Return a -> Format.fprintf form "Return(%a)" print_expr a
and print_param form param = match param with

	| Dec_args l -> match l with 
		| []  -> Format.fprintf form ""
		| [la] -> Format.fprintf form "%s" la
		| a::ll -> Format.fprintf form "%s,%a" a print_param (Dec_args ll)
and print_expr form expr = match expr with
	| Plus (g,d) -> print_binaire form "+" g d
	| Moins (g,d) -> print_binaire form "-" g d
	| Mult (g,d) -> print_binaire form "*" g d
	| Div (g,d) -> print_binaire form "/" g d
	| Neg e -> Format.fprintf form "%s %a" "-'" print_expr e
	| Num n -> Format.fprintf form "Num[%f]" n
	| Eq (g,d) -> print_binaire form "==" g d
	| Greq (g,d) -> print_binaire form ">=" g d
	| Gr (g,d) -> print_binaire form ">" g d
	| Loeq (g,d) -> print_binaire form "<=" g d
	| Lo (g,d) -> print_binaire form "<" g d
	| Not f -> Format.fprintf form "%s %a" "!" print_expr f
	| Bool b -> Format.fprintf form "Bool[%b]" b
	| Undefined -> Format.fprintf form "undefined"
	| Assign (g,d) -> Format.fprintf form "=(Var[%s], %a)" g print_expr d
	| Var x -> Format.fprintf form "Var[%s]" x
	| Et (g,d) -> print_binaire form "&&" g d
	| FCall(f,expr_args) -> Format.fprintf form "%s(%a)" f print_Call_args expr_args
and print_Call_args form expr_args = match expr_args with
	Call_args l -> match l with
		| [] -> Format.fprintf form ""
		| [a] -> Format.fprintf form "%a" print_expr a
		| a::ll -> Format.fprintf form "%a,%a" print_expr a print_Call_args (Call_args ll)
and print_binaire form s g d =
	Format.fprintf form "%s%s%a%s%a%s" s "(" print_expr g ", " print_expr d ")"
;;
