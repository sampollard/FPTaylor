open List
open Lib
open Expr

let diff v =
  let rec diff = function
    | Const _ -> expr_0
    | Var x -> if x = v then expr_1 else expr_0
    | U_op (op, f, arg) ->
      begin
	let ( ** ) = mk_mul f and
	    ( // ) = mk_div f and
	    pow = mk_nat_pow f and
	    neg = mk_neg f in
	let da = diff arg in
	match op with
	  | Op_neg -> neg da
	  | Op_inv -> neg (da // (pow arg expr_2))
	  | Op_sqrt -> da // (expr_2 ** mk_sqrt f arg)
	  | Op_sin -> da ** mk_cos f arg
	  | Op_cos -> neg (da ** mk_sin f arg)
	  | Op_tan -> da // (pow (mk_cos f arg) expr_2)
	  | Op_exp -> da ** mk_exp f arg
	  | Op_log -> da // arg
	  | _ -> failwith ("diff: Unsupported operation: " ^ op_name op f)
      end
    | Bin_op (op, f, arg1, arg2) ->
      begin
	let (++) = mk_add f and
	    (--) = mk_sub f and
	    ( ** ) = mk_mul f and
	    ( // ) = mk_div f and
	    pow = mk_nat_pow f in
	let da1 = diff arg1 and
	    da2 = diff arg2 in
	match op with
	  | Op_add -> da1 ++ da2
	  | Op_sub -> da1 -- da2
	  | Op_mul -> (da1 ** arg2) ++ (arg1 ** da2)
	  | Op_div -> ((da1 ** arg2) -- (arg1 ** da2)) // (pow arg2 expr_2)
	  | Op_nat_pow -> da1 ** (arg2 ** (pow arg1 (arg2 -- expr_1)))
	  | _ -> failwith ("diff: Unsupported operation: " ^ op_name op f)
      end
    | Gen_op (op, f, args) ->
      begin
	let (++) = mk_add f and
	    ( ** ) = mk_mul f in
	match (op, args) with
	  | (Op_fma, [a; b; c]) ->
	    let da = diff a and
		db = diff b and
		dc = diff c in
	    ((da ** b) ++ (a ** db)) ++ dc
	  | _ -> failwith ("diff: Unsupported operation: " ^ op_name op f)
      end
  in
  diff

  
