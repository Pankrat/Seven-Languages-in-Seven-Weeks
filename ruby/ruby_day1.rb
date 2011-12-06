puts "Hello, world"

"Hello, Ruby".index("Ruby")

10.times { puts "Anon" }

for i in 1..10
    puts "This is sentence number #{i}" 
end

secret = rand(10)

puts "Guess the secret number between 0 and 9:"
begin
    guess = gets().to_i
    puts "Too low, try again:" if guess < secret
    puts "Too high, try again:" if guess > secret
end until guess == secret

puts "You guessed the secret number #{secret}!"

