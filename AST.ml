type programme_a =
	Prog of commande_a list
and commande_a =
	Expr of expression_a
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
	| Assign of string * expression_a
	| Var of string
;;

(* Fonctions d'affichage *)

let rec print_programme form prog = match prog with
	| Prog(l) -> (match l with 
					| com::ll -> print_commande form com; print_programme form (Prog(ll))
					| [] -> ())
and print_commande form com = match com with
	| Expr e -> Format.fprintf form "Exp(%a)\n" print_expr e
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
	| Assign (g,d) -> Format.fprintf form "=(Var[%s], %a)" g print_expr d
	| Var x -> Format.fprintf form "Var[%s]" x 
and print_binaire form s g d =
	Format.fprintf form "%s%s%a%s%a%s" s "(" print_expr g ", " print_expr d ")"
;;

let rec code prog = match prog with
	| Prog(l) -> code_list l
	
and code_list l = match l with
	| [] -> "Halt"
	| com::q -> code_com com ^ code_list q

and code_com com = match com with
	| Expr e -> com_expr (opti_expr e)

and opti_expr expr = match expr with
	Plus (g,d) -> (let (a,b) = (opti_expr g, opti_expr d) in
				match (a,b) with
				(Num x, Num y) -> Num (x+.y)
				|_ -> Plus(a,b))
	|Moins (g,d) -> (let (a,b) = (opti_expr g, opti_expr d) in
				match (a,b) with
				(Num x, Num y) -> Num (x-.y)
				|_ -> Moins(a,b))
	|Mult (g,d) -> (let (a,b) = (opti_expr g, opti_expr d) in
				match (a,b) with
				(Num x, Num y) -> Num (x*.y)
				|_ -> Mult(a,b))
	|Div (g,d) -> (let (a,b) = (opti_expr g, opti_expr d) in
				match (a,b) with
				(Num x, Num y) -> Num (x/.y)
				|_ -> Div(a,b))
	|Neg e -> (let a = opti_expr e in
				match a with
				Num x -> Num (-.x)
				|_ -> Neg a)
	|Num n -> expr
	| Eq (g,d) -> Eq (opti_expr g, opti_expr d)
	| Greq (g,d) -> Greq (opti_expr g, opti_expr d)
	| Gr (g,d) -> Gr (opti_expr g, opti_expr d)
	| Loeq (g,d) -> Loeq (opti_expr g, opti_expr d)
	| Lo (g,d) -> Lo (opti_expr g, opti_expr d)
	| Not f -> Not (opti_expr f)
	| Bool b -> expr
	| Assign (g,d) -> Assign(g, opti_expr d)
	| Var x -> expr

and com_expr expr = match expr with
	Plus (g,d) -> com_expr g ^ com_expr d ^ "AddiNb\n"
	| Moins (g,d) -> com_expr g ^ com_expr d ^ "SubiNb\n"
	| Mult (g,d) -> com_expr g ^ com_expr d ^ "MultNb\n"
	| Div (g,d) -> com_expr g ^ com_expr d ^ "DiviNb\n"
	| Neg e -> com_expr e ^ "NegaNb\n"
	| Num n -> "CstNb " ^ (string_of_float n) ^ "\n"
	| Eq (g,d) -> com_expr g ^ com_expr d ^ "Equals\n"
	| Greq (g,d) -> com_expr g ^ com_expr d ^ "GrEqNb\n"
	| Gr (g,d) -> com_expr g ^ com_expr d ^ "GrStNb\n"
	| Loeq (g,d) -> com_expr g ^ com_expr d ^ "LoEqNb\n"
	| Lo (g,d) -> com_expr g ^ com_expr d ^ "LoStNb\n"
	| Not f -> com_expr f ^ "Not\n"
	| Bool b ->  "CsteBo " ^ (string_of_bool b) ^ "\n"
	| Assign (g,d) -> com_expr d ^ "SetVar " ^ g ^ "\n"
	| Var x -> "GetVar " ^ x ^ "\n"



(*and com_expr expr = match expr with
	Plus (g,d) -> com_expr g ^ com_expr d ^ "AddiNb\n"
	| Moins (g,d) -> com_expr g ^ com_expr d ^ "SubiNb\n"
	| Mult (g,d) -> com_expr g ^ com_expr d ^ "MultNb\n"
	| Div (g,d) -> com_expr g ^ com_expr d ^ "DiviNb\n"
	| Neg e -> com_expr e ^ "NegaNb\n"
	| Num n -> "CstNb " ^ (string_of_float n) ^ "\n"
	| Eq (g,d) -> com_expr g ^ com_expr d ^ "Equals\n"
	| Greq (g,d) -> com_expr g ^ com_expr d ^ "GrEqNb\n"
	| Gr (g,d) -> com_expr g ^ com_expr d ^ "GrStNb\n"
	| Loeq (g,d) -> com_expr g ^ com_expr d ^ "LoEqNb\n"
	| Lo (g,d) -> com_expr g ^ com_expr d ^ "LoStNb\n"
	| Not f -> com_expr f ^ "Not\n"
	| Bool b ->  "CsteBo " ^ (string_of_bool b) ^ "\n"
	| Assign (g,d) -> com_expr d ^ "SetVar " ^ g ^ "\n"
	| Var x -> "GetVar " ^ x ^ "\n"
*);;
