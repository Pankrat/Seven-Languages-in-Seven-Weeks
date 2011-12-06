fib := method(n,
    a := 1
    b := 1
    c := 0
    for(i, 3, n, 
        c = a
        a = a + b
        b = c)
    a
)

for(i, 1, 20, fib(i) println)
