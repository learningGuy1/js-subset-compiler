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

exception DoubleLet of string;;

(* ================= AFFICHAGE ================= *)

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

(* ================= CODE ET OPTIMISATION ================= *)		

let rec code prog = match prog with
	| Prog(l) -> let (decvar, foncvar, program, fonc, varlist) = code_list l in decvar ^ foncvar ^ program ^ "Halt\n" ^ fonc

and concat5 x y = let (a,b,c,d,l),(e,f,g,h,ll) = x,y in (a^e,b^f,c^g,d^h,l@ll)

and condense5 x = let (a,b,c,d,l) = x in a^b^c^d

and third5 x = let (a,b,c,d,l) = x in c

and check_let var x= 
	let (a,b,c,d,l) = x in match l with
	| [] -> false
	| y::ll -> var = y || check_let var (a,b,c,d,ll)

and code_list l = match l with
	| [] -> ("","","","", [])
	| com::q -> let next = code_list q in 
							match com with 
							| Let x -> (if (check_let x next) then raise (DoubleLet x) else concat5 (code_com com) next)	
							| Function (f,param,fcode) -> (if (check_let f next) then raise (DoubleLet f) else concat5 (code_com com) next)
							|_ -> concat5 (code_com com) next

and code_com com = 
	let check_not_func = "TypeOf\nCstNb 5\nEquals\nConJmp 1\nError\n"
	and cast_bo = "TypeOf\nCases 2\nJump 7\nNoop\nNbToBo\nJump 4\nNoop\nNoop\nDrop\nCsteBo false\n" in match com with
	| Expr e -> ("", "", code_expr (opti_expr e), "", [])
	| Block b -> let Prog(l) = b in ("", "", condense5 (code_list l), "", []) 
	| Semicol -> ("","","","",[])
	| Let x -> ("DclVar " ^ x ^ "\n", "", "", "",[x])
	| IfThenElse (cond, den, els) -> ("", "", code_expr cond ^ check_not_func ^ cast_bo ^
										"ConJmp " ^ (string_of_int ((com_length den) + 1) ) ^ "\n" ^
										third5 (code_com den) ^ "Jump " ^ (string_of_int ( (com_length els) + 1) ) ^ "\n" ^ third5 (code_com els),"",[])
	| While (cond, com) ->  ("", "", code_expr cond ^ check_not_func ^ cast_bo ^ "ConJmp " ^ (string_of_int ((com_length com) + 1)) ^ "\n" ^ third5 (code_com com)
													^ "Jump " ^ (string_of_int (-(com_length com) -(expr_length cond) - 2 - 5 (*check fonction*) - 10 (*Cast en bool*))) ^ "\n", "",[])
	| DoWhile (com, cond) -> ("", "", third5 (code_com com) ^ code_expr cond ^ check_not_func ^ cast_bo ^ "Not\nConJmp " 
													^ (string_of_int (-(com_length com) -(expr_length cond) - 2 - 5 (*check fonction*) - 10 (*Cast en bool*))) ^ "\n", "",[])
	| Function (f,param,fcode) -> ("DclVar " ^ f ^ "\n", "NewClot func_" ^ f ^ "\n" ^ (func_param param) ^ "SetVar " ^ f ^ "\n", "", "func_"^f^":\n" ^ condense5 (code_com fcode),[f])
  | Return a -> ("", "", code_expr a ^ "Return\n", "",[])
and func_param args =
	let Dec_args(l) = args in	match l with
		| [] -> ""
		| a::ll -> (func_param (Dec_args ll)) ^ "DclArg " ^ a ^ "\n"
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
	| Undefined -> expr
	| Assign (g,d) -> Assign(g, opti_expr d)
	| Var x -> expr
	| Et (g,d) -> Et (opti_expr g, opti_expr d)
	| FCall (f,args) -> FCall (f, opti_call_args args)
and opti_call_args args =
	match args with
	| Call_args l -> Call_args (List.map opti_expr l)
and code_expr expr = 
	let check_not_func = "TypeOf\nCstNb 5\nEquals\nConJmp 1\nError\n" 
	and check_not_undef = "TypeOf\nCstNb 3\nEquals\nConJmp 1\nError\n" 
	and cast_bo = "TypeOf\nCases 2\nJump 7\nNoop\nNbToBo\nJump 4\nNoop\nNoop\nDrop\nCsteBo false\n" 
	and cast_nb = "TypeOf\nCases\nBoToNb\n" in match expr with
	Plus (g,d) -> code_expr g ^ check_not_func ^ check_not_undef ^ cast_nb ^ code_expr d ^ check_not_func ^ check_not_undef ^ cast_nb ^ "AddiNb\n"
	| Moins (g,d) -> code_expr g ^ check_not_func ^ check_not_undef ^ cast_nb ^ code_expr d ^ check_not_func ^ check_not_undef ^ cast_nb ^ "SubiNb\n"
	| Mult (g,d) -> code_expr g ^ check_not_func ^ check_not_undef ^ cast_nb ^ code_expr d ^ check_not_func ^ check_not_undef ^ cast_nb ^ "MultNb\n"
	| Div (g,d) -> code_expr g ^ check_not_func ^ check_not_undef ^ cast_nb ^ code_expr d ^ check_not_func ^ check_not_undef ^ cast_nb ^ "DiviNb\n"
	| Neg e -> code_expr e ^ check_not_func ^ check_not_undef ^ cast_nb ^ "NegaNb\n"
	| Num n -> "CstNb " ^ (string_of_float n) ^ "\n"
	| Eq (g,d) -> code_expr g ^ check_not_func ^ code_expr d ^ check_not_func ^ "Equals\n"
	| Greq (g,d) -> code_expr g ^ check_not_func ^ check_not_undef ^ cast_nb ^ code_expr d ^ check_not_func ^ check_not_undef ^ cast_nb ^ "GrEqNb\n"
	| Gr (g,d) -> code_expr g ^ check_not_func ^ check_not_undef ^ cast_nb ^ code_expr d ^ check_not_func ^ check_not_undef ^ cast_nb ^ "GrStNb\n"
	| Loeq (g,d) -> code_expr g ^ check_not_func ^ check_not_undef ^ cast_nb ^ code_expr d ^ check_not_func ^ check_not_undef ^ cast_nb ^ "LoEqNb\n"
	| Lo (g,d) -> code_expr g ^ check_not_func ^ check_not_undef ^ cast_nb ^ code_expr d ^ check_not_func ^ check_not_undef ^ cast_nb ^ "LoStNb\n" 
	| Bool b ->  "CsteBo " ^ (string_of_bool b) ^ "\n"
	| Undefined -> "CsteUn\n"
	| Assign (g,d) -> code_expr d ^ "SetVar " ^ g ^ "\n"
	| Var x -> "GetVar " ^ x ^ "\n"
	| Not f -> code_expr f ^ check_not_func ^ cast_bo ^ "Not\n"
	| Et (g,d) -> code_expr g ^ check_not_func ^ cast_bo ^ "ConJmp " ^ (string_of_int ((expr_length d) + 5 (*check fonction*) + 10 (*Cast en bool*) + 1) ) ^ "\n" 
								^ code_expr d ^ check_not_func ^ cast_bo ^ "Jump 1\n" ^ "CsteBo false\n" 
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
	| Plus (g,d) -> 1 + expr_length g + expr_length d + 4*5 (*check fonction et undefined*) + 3*2 (*Cast en nb*)
	| Moins (g,d) -> 1 + expr_length g + expr_length d + 4*5 (*check fonction et undefined*) + 3*2 (*Cast en nb*)
	| Mult (g,d) -> 1 + expr_length g + expr_length d + 4*5 (*check fonction et undefined*) + 3*2 (*Cast en nb*)
	| Div (g,d) -> 1 + expr_length g + expr_length d + 4*5 (*check fonction et undefined*) + 3*2 (*Cast en nb*)
	| Neg e -> 1 + expr_length e  + 2*5 (*check fonction et undefined*) + 3 (*Cast en nb*)
	| Num n -> 1 
	| Not e -> 1 + expr_length e + 5 (*check fonction*) + 10 (*Cast en bool*)
	| Eq (g,d) -> 1 + expr_length g + expr_length d + 2*5 (*check fonction*)
	| Greq (g,d) -> 1 + expr_length g + expr_length d + 4*5 (*check fonction et undefined*) + 3*2 (*Cast en nb*)
	| Gr (g,d) -> 1 + expr_length g + expr_length d + 4*5 (*check fonction et undefined*) + 3*2 (*Cast en nb*)
	| Loeq (g,d) -> 1 + expr_length g + expr_length d + 4*5 (*check fonction et undefined*) + 3*2 (*Cast en nb*)
	| Lo (g,d) -> 1 + expr_length g + expr_length d + 4*5 (*check fonction et undefined*) + 3*2 (*Cast en nb*)
	| Bool b ->  1 
	| Undefined -> 1
	| Assign (_,d) -> 1 + expr_length d
	| Var x -> 1
	| Et (g,d) -> 3 + expr_length g + expr_length d + 2*5 (*check fonction*) + 2*10 (*Cast en bool*)
	| FCall (_,args) -> (let Call_args l = args in call_args_length l + List.length l + 3)
and code_length_list l = match l with
	| [] -> 0
	| c::q -> com_length c + code_length_list q	
and call_args_length l =
	match l with
	| [] -> 0
	| x::ll -> expr_length x + call_args_length ll
and com_length com = match com with
	| Expr e -> expr_length (opti_expr e)
	| Semicol -> 0
	| Block (Prog l) -> code_length_list l
	| Let x -> 1;
	| IfThenElse (cond, den, els) -> expr_length cond + com_length den + com_length els + 2 + 5 (*check fonction*) + 10 (*Cast en bool*)
	| While (cond, com) -> expr_length cond + com_length com + 2 + 5 (*check fonction*) + 10 (*Cast en bool*)
	| DoWhile (com, cond) -> com_length com + expr_length cond + 2 + 5 (*check fonction*) + 10 (*Cast en bool*)
	| Function (_,param,fcode) ->  (let Dec_args l = param in 2 + List.length l + com_length fcode)
	| Return a -> expr_length a + 1
;;





