(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

fun all_except_option(s, xs) =
    let
	fun helper(hs, xs) = 
	    case xs of
		[] => NONE
	      | x::xs' => if same_string(s, x)
			  then SOME(hs @ xs')
			  else helper(hs @ [x], xs')
    in
	helper([], xs)
    end

fun get_substitutions1(xss, s) =
    case xss of
	[] => []
     | xs::xss' => case all_except_option(s, xs) of 
		       NONE => [] @ get_substitutions1(xss', s)
		    | SOME lst => lst @ get_substitutions1(xss', s)

fun get_substitutions2(xss, s) =
    let
	fun helper(xss, ys) =
	    case xss of
		[] => ys
	      | xs::xss' => case all_except_option(s, xs) of
				NONE => helper(xss', ys)
			      | SOME lst => helper(xss', ys @ lst)  
    in
	helper(xss, [])
    end

fun similar_names(xss, full_name) =
    let
	fun helper((xs, y, z), full_names) =
	    case xs of
		[] => full_names
	      | x::xs' => helper((xs', y, z), {first=x, middle=y, last=z}::full_names)
    in
	helper(case full_name of
		   {first=x, middle=y, last=z} => (x::get_substitutions2(xss, x), y, z), [])
    end

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

fun card_color(c) =
    case c of
	(Clubs,_) => Black
      | (Spades,_) => Black 
      | (_,_) => Red

fun card_value(c) =
    case c of
	(_,Num i) => i
      | (_,Ace) => 11
      | (_,_) => 10  

fun remove_card(cs, c, e) =
    let
	fun helper(hs, cs) = 
	    case cs of
		[] => raise e
	      | x::cs' => if x = c
			  then hs @ cs'
			  else helper(hs @ [x], cs')
    in
	helper([], cs)
    end

fun all_same_color(cs) =
    case cs of
	[] => true
      | _::[] => true
      | head::(neck::rest) => (card_color(head) = card_color(neck) andalso all_same_color(neck::rest))

fun sum_cards(cs) =
    let
	fun get_sum(cs, sum) =
	    case cs of
		[] => sum
	      | c::cs' => get_sum(cs', sum + card_value(c))
    in
	get_sum(cs, 0)
    end

fun score(hcs, goal) =
    let
	val sum = sum_cards(hcs)
	fun get_score(pscore) = 
	    if all_same_color(hcs)
	    then pscore div 2
	    else pscore 
    in
	if sum > goal
	then get_score(3 * sum - goal)
	else get_score(goal - sum)				     
    end
    
fun officiate(cs, ms, goal) =
    let
	fun helper(ms, cs, hcs) =
	    case ms of
		[] => score(hcs, goal)
	      | m::ms' => case m of
			      Discard c => helper(ms', cs, remove_card(hcs, c, IllegalMove))
			    | Draw => case cs of
					  [] => score(hcs, goal) 
					| c::cs' => if sum_cards(c::hcs) > goal
						    then score(c::hcs, goal)
						    else helper(ms', cs', c::hcs) 
    in
	helper(ms, cs, [])
    end
