fun is_older(date1 : int*int*int, date2 : int*int*int) =
    if #1 date1 < #1 date2
    then true
    else if #1 date1 = #1 date2 andalso #2 date1 < #2 date2
    then true
    else if #1 date1 = #1 date2 andalso #2 date1 = #2 date2 andalso #3 date1 < #3 date2
    then true
    else false

fun number_in_month(dates : (int*int*int) list, month : int) = 
    let 
	val c = 0
	fun getCount(dates : (int*int*int) list, c : int) =
	    if null dates
	    then c
	    else if #2(hd dates) = month
	    then getCount(tl dates, c+1)
	    else getCount(tl dates, c)
    in
	getCount(dates, c)
    end

fun number_in_months(dates : (int*int*int) list, months : int list) = 
    let 
	val count = 0
	fun getCount(months : int list, count : int) =
	    if null months
	    then count
	    else getCount(tl months, count + number_in_month(dates, hd months))
    in
	getCount(months, count)
    end

fun dates_in_month(dates : (int*int*int) list, month : int) = 
     let 
	 val new_dates = []
	 fun getNewDates(dates : (int*int*int) list, new_dates : (int*int*int) list) =
	     if null dates
	     then new_dates
	     else if #2(hd dates) = month
	     then getNewDates(tl dates, new_dates @ [hd(dates)])
	     else getNewDates(tl dates, new_dates)
     in
	 getNewDates(dates, new_dates)
     end

fun dates_in_months(dates : (int*int*int) list, months : int list) =
    let
	val new_dates = []
	fun getNewDates(months : int list, new_dates : (int*int*int) list) =
	    if null months
	    then new_dates
	    else getNewDates(tl months, new_dates @ dates_in_month(dates, hd(months)))
    in 
	getNewDates(months, new_dates)
    end

fun get_nth(strings : string list, n : int) =
    let
	val i = 1
	fun iterate(strings : string list, i : int) = 
	    if i = n
	    then hd strings
	    else iterate(tl strings, i+1)
    in
	iterate(strings, i)
    end

fun date_to_string(date : (int*int*int)) =
    let
	val months = ["January", "February", "March", "April", "May", "June", "July", 
		      "August", "September", "October", "November", "December"]
    in
	get_nth(months, #2 date)^" "^Int.toString(#3 date)^", "^Int.toString(#1 date)
    end

fun number_before_reaching_sum(sum : int, numbers : int list) =
    let
	val n = ~1
	val new_sum = 0
	fun findSum(numbers : int list, n : int, new_sum : int) = 
	    if new_sum >= sum
	    then n
	    else findSum(tl numbers, n+1, new_sum + hd(numbers))
    in
	findSum(numbers, n, new_sum)
    end

fun what_month(day_of_year : int) = 
    let
	val months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
	number_before_reaching_sum(day_of_year, months) + 1
    end
    
fun oldest(dates : (int*int*int) list) = 
    let
	val old_date = (9999,9999,9999)
	fun older(date1 : int*int*int, date2 : int*int*int) =
	    if #1 date1 < #1 date2
	    then date1
	    else if #1 date1 = #1 date2 andalso #2 date1 < #2 date2
	    then date1
	    else if #1 date1 = #1 date2 andalso #2 date1 = #2 date2 andalso #3 date1 < #3 date2
	    then date1
	    else date2
	fun getOldest(dates : (int*int*int) list, old_date : int*int*int) = 
	    if null dates
	    then old_date
	    else getOldest(tl dates, older(old_date, hd dates))
    in
	if null dates
	then NONE
	else SOME(getOldest(dates, old_date))
    end

fun month_range(day1 : int, day2 : int) = 
    let
	val month1 = what_month(day1)
	val month2 = what_month(day2)
	val range = []
	fun getMonthRange(day2, range) = 
	    if day1 = day2
	    then what_month(day2)::range
	    else getMonthRange(day2 - 1, what_month(day2)::range)  
    in
	if day1 > day2
	then []
	else getMonthRange(day2, range)
    end
