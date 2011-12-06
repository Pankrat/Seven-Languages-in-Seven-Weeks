(5 / 2) println
(3 / 0) println

div := Number getSlot("/")
Number / := method(d, if(d == 0, 0, div(d)))

(5 / 2) println
(3 / 0) println
