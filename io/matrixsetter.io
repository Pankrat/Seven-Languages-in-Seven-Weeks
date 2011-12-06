Matrix := List clone
Matrix dim := method(x, y,
    self dimension := list(x, y)
    self dimension join("x") println
    for(i, 1, y, self append(List clone setSize(x)))
)
Matrix set := method(x, y, v,
    self at(y) atPut(x, v)
)
Matrix get := method(x, y,
    self at(y) at(x)
)
Matrix show := method(
    foreach(elem, elem join("  ") println)
)
Matrix transpose := method(
    transposed := Matrix clone
    cols := self dimension at(0)
    rows := self dimension at(1) 
    transposed dim(rows, cols)
    for(x, 0, rows - 1,
        for(y, 0, cols - 1,
            transposed set(x, y, self get(y, x))
        )
    )
    transposed
)
Matrix writeToFile := method(filename,
    f := File with(filename)
    f open
    foreach(elem, f write(elem join(";") .. "\n"))
    f close    
)
Matrix readFromFile := method(filename,
    self removeAll
    f := File with(filename)
    f openForReading
    rows := f readLines
    rows foreach(row, 
        fields := List clone
        row split(";") foreach(value, 
            v := value asNumber
            if(v isNan, v = nil)
            fields append(v))
        self append(fields))
    self
)


m := Matrix clone
m dim(4,2)
m set(1, 1, 42)
m set(3, 0, 17)
m set(3, 1, 53)
m println
m show

assert := method(cond,
    if(cond, "OK" println, Exception raise("Assertion failed!"))
)

assert(m get(1, 1) == 42)
assert(m get(3, 0) == 17)
assert(m get(3, 1) == 53)

"Now transpose the matrix:" println
t := m transpose
t show

assert(t get(1, 1) == 42)
assert(t get(0, 3) == 17)
assert(t get(1, 3) == 53)

"Save and load matrix from file:" println
m writeToFile("matrix.txt")
c := Matrix clone 
c readFromFile("matrix.txt") show

assert(c get(0, 0) == nil)
assert(c get(1, 1) == 42)
assert(c get(3, 0) == 17)
assert(c get(3, 1) == 53)
