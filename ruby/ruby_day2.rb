require "enumerator"

a = Array(1..18)

# Variant 1 : times
(a.length / 4.0).ceil.times do |i| 
    puts a.slice(i*4, 4).join(",") 
end

# Variant 2 : each with state
chunk = []
a.each do |i|
    chunk.push(i)
    if chunk.length == 4
        puts chunk.join(", ")
        chunk = []
    end
end
puts chunk.join(", ")

# Variant 3 : each_slice
a.each_slice(4) { |i,j,k,l| puts "#{i} #{j} #{k} #{l}" }
