type programme_a =
	Prog of commande_a list
and commande_a =
	Expr of expression_a
	| Block of programme_a
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
	| Assign of string * expression_a
	| Var of string
	| Et of expression_a * expression_a
	| FCall of string * call_arguments_a
and call_arguments_a =
	| Call_args of expression_a list
;;

(* ================= AFFICHAGE ================= *)

let rec print_programme form prog = match prog with
	| Prog(l) -> (match l with 
					| com::ll -> print_commande form com; print_programme form (Prog(ll))
					| [] -> ())
and print_commande form com = match com with
	| Expr e -> Format.fprintf form "Exp(%a)\n" print_expr e
	| Block c -> Format.fprintf form "Block(%a)\n" print_programme c 
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

(* ================= CODE ET OPTIMISATION ================= *)		

let rec code prog = match prog with
	| Prog(l) -> code_list l
	
and code_list l = match l with
	| [] -> ""
	| com::q -> code_com com ^ code_list q
	
and code_com com = match com with
	| Expr e -> code_expr (opti_expr e)
	| Block b -> code b
	| Semicol -> ""
	| IfThenElse (cond, den, els) -> (code_expr cond ^
										"ConJmp " ^ (string_of_int ((com_length els) + 1) ) ^ "\n" ^
										code_com den ^ "Jump " ^ (string_of_int ( (com_length els) + 1) ) ^ "\n" ^code_com els )
	| While (cond, com) ->  code_expr cond ^ "ConJmp " ^ (string_of_int ((com_length com) + 1)) ^ "\n" ^ code_com com ^ "Jump " ^ (string_of_int (-(com_length com) -(expr_length cond) - 2)) ^ "\n"
	| DoWhile (com, cond) -> code_com com ^ code_expr cond ^ "Not\nConJmp " ^ (string_of_int (-(com_length com) -(expr_length cond) - 2)) ^ "\n"
	| Function (f,param,fcode) -> "NewClot func_" ^ f ^ "\n" ^(func_param f param) ^"func_"^f^":\n" ^code_com fcode
    | Return a -> code_expr a ^ "Return\n"
and func_param f args =
	match args with
	| Dec_args l ->
		(match l with
		| [] -> "SetVar " ^ f ^ "\n"
		| a::ll -> "DclArg " ^ a ^ "\n" ^ (func_param f (Dec_args ll)))
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
	| Et (g,d) -> Et (opti_expr g, opti_expr d)
	| FCall (f,args) -> FCall (f, opti_call_args args)
and opti_call_args args =
	match args with
	| Call_args l -> Call_args (List.map opti_expr l)
and code_expr expr = match expr with
	Plus (g,d) -> code_expr g ^ code_expr d ^ "AddiNb\n"
	| Moins (g,d) -> code_expr g ^ code_expr d ^ "SubiNb\n"
	| Mult (g,d) -> code_expr g ^ code_expr d ^ "MultNb\n"
	| Div (g,d) -> code_expr g ^ code_expr d ^ "DiviNb\n"
	| Neg e -> code_expr e ^ "NegaNb\n"
	| Num n -> "CstNb " ^ (string_of_float n) ^ "\n"
	| Eq (g,d) -> code_expr g ^ code_expr d ^ "Equals\n"
	| Greq (g,d) -> code_expr g ^ code_expr d ^ "GrEqNb\n"
	| Gr (g,d) -> code_expr g ^ code_expr d ^ "GrStNb\n"
	| Loeq (g,d) -> code_expr g ^ code_expr d ^ "LoEqNb\n"
	| Lo (g,d) -> code_expr g ^ code_expr d ^ "LoStNb\n" 
	| Bool b ->  "CsteBo " ^ (string_of_bool b) ^ "\n"
	| Assign (g,d) -> code_expr d ^ "SetVar " ^ g ^ "\n"
	| Var x -> "GetVar " ^ x ^ "\n"
	| Not f -> code_expr f ^ "Not\n"
	| Et (g,d) -> code_expr g ^ "ConJmp " ^ (string_of_int ((expr_length d)+ 1) ) ^ "\n" ^ code_expr d  ^ "Jump 1\n" ^ "CsteBo false\n" 
	| FCall (f,args) ->"GetVar " ^ f ^ "\n" ^"StCall\n" ^code_call_args args ^"Call\n"
and code_call_args args =
	match args with
	| Call_args l -> code_call_args_list l
and code_call_args_list l =
	match l with
	| [] -> ""
	| a::q ->code_expr a ^"SetArg\n" ^ code_call_args_list q
(*=============== CALCUL DE LONGUEUR =================*)

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
	| Et (g,d) -> 3 + expr_length g + expr_length d
	| FCall (_,args) -> call_args_length args + 2
and code_length_list l = match l with
	| [] -> 0
	| c::q -> com_length c + code_length_list q	
and call_args_length args =
	match args with
	| Call_args l -> call_args_length_list l

and call_args_length_list l =
	match l with
	| [] -> 0
	| a::q -> expr_length a + 1 + call_args_length_list q
and com_length com = match com with
	| Expr e -> expr_length e
	| Semicol -> 0
	| Block (Prog l) -> code_length_list l
	| IfThenElse (cond, den, els) -> expr_length cond + com_length den + com_length els + 2
	| While (cond, com) -> expr_length cond + com_length com + 2
	| DoWhile (com, cond) -> com_length com + expr_length cond + 2 
	| Function (_, _, body) -> com_length body + 1
	| Return a -> expr_length a + 1
;;





