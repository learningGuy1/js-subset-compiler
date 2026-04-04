type programme_a =
	Prog of commande_a list
and commande_a =
	Expr of expression_a
	| Block of programme_a
	| IfThenElse of expression_a * commande_a* commande_a
	| Semicol
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
	| Et of expression_a * expression_a
;;

(* Fonctions d'affichage *)

let rec print_programme form prog = match prog with
	| Prog(l) -> (match l with 
					| com::ll -> print_commande form com; print_programme form (Prog(ll))
					| [] -> ())
and print_commande form com = match com with
	| Expr e -> Format.fprintf form "Exp(%a)\n" print_expr e
	| Block c -> Format.fprintf form "Block( %a )\n" print_programme c 
	| IfThenElse (cond,den,els) ->    Format.fprintf form "IfThenElse( %a , %a , %a )\n"
      print_expr cond
      print_commande den
      print_commande els 
     | Semicol -> Format.fprintf form ""
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
	| Et (g,d) -> print_binaire form "&&" g d
	
and print_binaire form s g d =
	Format.fprintf form "%s%s%a%s%a%s" s "(" print_expr g ", " print_expr d ")"
;;

let rec code prog = match prog with
	| Prog(l) -> code_list l
	
and code_list l = match l with
	| [] -> "Halt"
	| com::q -> code_com com ^ code_list q
	
and code_com com = match com with
	| Expr e -> com_expr e
	| Block b -> code b
	| Semicol -> ""
	| IfThenElse (cond,den,els) -> (com_expr cond ^
      code_com den ^
      code_com els )
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
	| Bool b ->  "CsteBo " ^ (string_of_bool b) ^ "\n"
	| Assign (g,d) -> com_expr d ^ "SetVar " ^ g ^ "\n"
	| Var x -> "GetVar " ^ x ^ "\n"
	| Not e -> 
	| Et (g,d) -> com_expr g ^ "ConJmp " ^ (string_of_int ((expr_length d)+ 1) ) ^ "\n" ^ com_expr d ^ "ConJmp 2\n" ^ "CsteBo true\n" ^ "Jump 1\n" ^ "CsteBo false\n"
and expr_length expr = match expr with
	| Plus (g,d) -> 1 + expr_length g + expr_length d
	| Moins (g,d) -> 1 + expr_length g + expr_length d
	| Mult (g,d) -> 1 + expr_length g + expr_length d
	| Div (g,d) -> 1 + expr_length g + expr_length d
	| Neg e -> 1 + expr_length e 
	| Num n -> 1 
	| Not e -> 1 + expr_length e
	| Eq (g,d) -> 1 + expr_length g + expr_length d
	| Greq (g,d) -> 1 + expr_length g + expr_length d
	| Gr (g,d) -> 1 + expr_length g + expr_length d
	| Loeq (g,d) -> 1 + expr_length g + expr_length d
	| Lo (g,d) -> 1 + expr_length g + expr_length d
	| Bool b ->  1 
	| Assign (_,d) -> 1 + expr_length d
	| Var x -> 1
	| Et (g,d) -> 1 + expr_length g + expr_length d
;;
