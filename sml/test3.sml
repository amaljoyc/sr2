(* This is the test file for hw3.sml *)

use "hw3.sml";

val oc = only_capitals(["Hello", "world", "How", "are", "U"]);

val ls1 = longest_string1 ["Hello", "This is the longest1", "Tiger", "Lisp"];

val ls2 = longest_string2 ["Hello", "This is the longest1", "Tiger", "This is the longest2", "Lisp"];

val ls3 = longest_string3 ["Hello", "Longest3", "HI", "#123"];

val ls4 = longest_string4 ["Hello", "Longest3", "HI", "Longest4", "#123"];

val lc = longest_capitalized ["Hello", "How", "are", "longest_small", "Longest", "Hi"];

val rs = rev_string "Reverse";

val fa1 = first_answer (fn x => if x=1 then NONE else SOME x) [1,1,4,3,1]
(* val fa2 = first_answer (fn x => if x=1 then NONE else SOME x) [1,1,1,1] *)

val aa1 = all_answers (fn x => if x=1 then NONE else SOME [x,x,x]) [2,3,4]
val aa2 = all_answers (fn x => if x=1 then NONE else SOME [x,x,x]) [2,3,1,4]
val aa3 = all_answers (fn x => if x=1 then NONE else SOME [x,x,x]) []

val cw = count_wildcards (TupleP [Variable "batman", Wildcard, Wildcard, Variable "Hi"]);
val cwavl = count_wild_and_variable_lengths (TupleP [Variable "batman", Wildcard, Wildcard, Variable "Hi"]);
val csv1 = count_some_var ("Hello", (TupleP [Variable "Hello", Variable "Hi", Variable "Hello", Variable "Hello"]))
val csv2 = count_some_var ("Hi", (TupleP [Variable "Hello", Variable "Hi", Variable "Hello", Variable "Hello"]))
