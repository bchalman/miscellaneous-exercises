def merge(a,b)
  return a + b if a[0].nil? || b[0].nil?
  [(a[0] <= b[0] ? a.shift : b.shift)] + merge(a,b)
end

 puts merge([1,5,8] , [2,3,6] ).inspect

def merge_sort(a)
  length = a.length
  return a if length == 1
  merge(merge_sort(a[0...length/2]),merge_sort(a[length/2..-1]))
end

puts merge_sort([5,31,8,6,7,2,32,15,4,3,21,56,6,32,1,6,3,75,]).inspect


array = Array.new(20) { rand(100) }
puts merge_sort(array).inspect
