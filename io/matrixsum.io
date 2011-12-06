matrix := list(1,2,3,list(4,5,5))
matrix println
matrix flatten sum println

AvgException := Exception clone

List myAvg := method(
    try(
        self sum / self size
    ) catch(Exception,
        AvgException raise("Can't build average from anything that's not a number")
    )
)

spam := list(42, "eggs")
spam myAvg println


