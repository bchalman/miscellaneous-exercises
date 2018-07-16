def fibs(n)
  fib = [1]
    while fib.length < n
      fib << fib[-1] + (fib[-2].nil? ? 0 : fib[-2])
    end
  fib
end

def fibs_rec(n)
  fib =  n > 1 ? fibs_rec(n-1)  : [1]
  fib << fib[-1] + ( fib[-2].nil? ? 0 : fib[-2] )
end

puts fibs(8).inspect
puts fibs_rec(10).inspect
