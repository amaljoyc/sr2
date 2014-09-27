val older_bool1 = is_older((2010,2,4),(2013,11,1));
val older_bool2 = is_older((2010,2,4),(2004,3,23));

val count1 = number_in_month([(2010,2,4),(2013,11,1),(2012,1,1)], 11);
val count2 = number_in_month([(2010,5,4),(2013,11,1),(2012,5,1)], 5);

val count3 = number_in_months([(2010,2,4),(2013,11,16),(2012,1,22)], [1,12,3,2]);

val new_dates = dates_in_month([(2010,2,4),(2013,11,1),(2012,11,1)], 11);

val new_dates = dates_in_months([(2010,2,4),(2013,9,1),(2012,11,1)], [11,5,2,4]);

val nth_string = get_nth(["hello", "how", "are", "you"], 2);

val date_string = date_to_string((2012,5,23));

val n = number_before_reaching_sum(10, [3,1,4,1,5,7]);

val month = what_month(100);

val old = oldest([(2013,2,3),(2012,12,30),(2012,1,23),(2012,4,7)]);

val range = month_range(34, 90);
