(* Dan Grossman, Coursera PL, HW2 Provided Tests *)
use "hw2.sml";

val l1 = all_except_option("b", ["a", "b", "c"]);
val l2 = all_except_option("d", ["a", "b", "c"]);

val l3 = get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],"Fred");
val l4 = get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],"Jeff");

val l5 = get_substitutions2([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],"Fred");
val l6 = get_substitutions2([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],"Jeff");

val l7 = similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],{first="Fred", middle="W", last="Smith"});

val color = card_color(Spades, Jack);

val cv1 = card_value(Diamonds, Ace);
val cv2 = card_value(Diamonds, King);

val rc = remove_card([(Spades,Jack), (Clubs,King), (Hearts,Num 3), (Clubs,King)], (Clubs,King), IllegalMove);

val b1 = all_same_color([(Spades,Ace), (Clubs,Jack), (Spades,Num 7)]);
val b2 = all_same_color([(Spades,Ace), (Clubs,Jack), (Diamonds,Num 7)]);

val sum = sum_cards([(Spades,Ace), (Diamonds,King), (Clubs,Num 5)]);

val score = score([(Hearts,Jack), (Diamonds,Num 4)], 10);

val game = officiate([(Hearts,Jack),(Clubs,Num 3),(Spades,King)], [Draw,Draw,Discard (Hearts,Jack)], 36);

(* These are just two tests for problem 2; you will want more.

   Naturally these tests and your tests will use bindings defined 
   in your solution, in particular the officiate function, 
   so they will not type-check if officiate is not defined.
 *)

fun provided_test1 () = (* correct behavior: raise IllegalMove *)
    let val cards = [(Clubs,Jack),(Spades,Num(8))]
    val moves = [Draw,Discard(Hearts,Jack)]
    in
    officiate(cards,moves,42)
    end

fun provided_test2 () = (* correct behavior: return 3 *)
    let val cards = [(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)]
    val moves = [Draw,Draw,Draw,Draw,Draw]
    in
    officiate(cards,moves,42)
    end
