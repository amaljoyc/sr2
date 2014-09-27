fun pow(x : int, y : int) = 
    if y = 0
    then 1
    else x * pow(x, y-1)
 
val x = pow(2, 3)

fun div_mod(x : int, y : int) =
    (x div y, x mod y)

val y = div_mod(5, 2)

fun sort_pair(pr : int * int) = 
    if (#1 pr) < (#2 pr)
    then pr
    else (#2 pr, #1 pr)

fun sum_list(xs : int list) = 
    if null xs
    then 0
    else hd xs + sum_list(tl xs)

fun append(xs : int list, ys : int list) = 
    if null xs
    then ys
    else hd xs :: append(tl(xs), ys)

fun sum_pair_list(xs : (int * int) list) = 
    if null xs
    then 0
    else #1 (hd xs) + #2 (hd xs) + sum_pair_list(tl xs)

fun silly(x : int) = 
    let
	val y = x
    in
	y
    end

datatype mytype = Str of string 
		| TwoInt of (int*int)
		| Pizza

fun case_example(x : mytype) = 
    case x of
	Pizza => 100
      | Str s => String.size s
      | TwoInt (in1, in2) => in1 + in2
   
	     
datatype exp = Constant of int
       | Negate of exp
       | Add of (exp * exp)

fun eval e = 
    case e of
	Constant i => i
      | Negate e1 => ~ (eval e1)
      | Add(e1, e2) => (eval e1) + (eval e2)
   
type amal = string

fun inc_or_zero intoption = 
    case intoption of
	NONE => 0
      | SOME i => i+1  

fun sum_list xs = 
    case xs of
	[] => 0
      | x::xs' => x + sum_list(xs') 

fun append2(xs, ys) = 
    case xs of
	[] => ys
      | x::xs' => x::append(xs', ys)

fun sum_triple (x,y,z) =
    x + y + z

fun sum_record {first=x, second=y, third=z} = 
    x + y + z

exception ListLengthMismatch

fun zip triplet = 
    case triplet of
	([],[],[]) => []
      | (hd1::tl1, hd2::tl2, hd3::tl3) => (hd1, hd2, hd3)::zip(tl1, tl2, tl3)
      | _ => raise ListLengthMismatch

fun map(f, xs) =
    case xs of
	[] => []
      | x::xs' => (f x)::map(f, xs')

val m1 = map(hd, [[1,2,3], [4,5], [6,7,8]])
val m2 = map((fn x => x+1), [1,2,3,4]) 

fun f y = 
    let 
	val x = y+1
    in
	fn z => x + y + z
    end

structure MyModule = 
struct
    
val x = 10
	    
fun test x = 
    x
	
end

(* fun mystery f xs = *)
fun mystery f = fn xs =>
    let
        fun g xs =
           case xs of
             [] => NONE
           | x::xs' => if f x then SOME x else g xs'
    in
	case xs of
            [] => NONE
	  | x::xs' => if f x then g xs' else mystery f xs'
    end

(* fun null xs = case xs of [] => true | _ => false *)
(* fun null xs = xs=[] *)
(* fun null xs = if null xs then true else false *)
(* fun null xs = ((fn z => false) (hd xs)) handle List.Empty => true *)

fun test () = fn x => x + 2
