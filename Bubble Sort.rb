def bubble_sort(array_to_sort)
  array_to_sort.each_index do |i|
    if i < array_to_sort.length - 1
      if array_to_sort[i] > array_to_sort[i+1]
        array_to_sort[i], array_to_sort[i+1] = array_to_sort[i+1], array_to_sort[i]
      end
    end
  end
  if array_to_sort.length > 2
     array_to_sort = bubble_sort(array_to_sort[0..-2]).push(array_to_sort[-1])
   else
     array_to_sort
  end
end

def bubble_sort_by(array_to_sort)
  # block messed up my recursion :-(
  array_to_sort.each_index do |j|
    array_to_sort[0..-(j+2)].each_index do |i|
      if i < array_to_sort.length
        if (yield(array_to_sort[i].to_s, array_to_sort[i+1].to_s) > 0)
          array_to_sort[i], array_to_sort[i+1] = array_to_sort[i+1], array_to_sort[i]
        end
      end
    end
  end
end

puts (test_array = [1,2,3,4,5,6,7].shuffle).inspect
puts bubble_sort(test_array).inspect
puts bubble_sort_by(["Monster","Hunt This dude","hi","hello","hey","poop","Lonnnng"]) {|left,right| left.length - right.length}.inspect
