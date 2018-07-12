def stock_picker(stock_array)
  stock_array_max_return = stock_array.map.with_index do |current_value , i|
    maximum = stock_array[i..-1].to_a.max
    [(maximum - current_value).to_f/current_value , stock_array[i..-1].index(maximum)+i]
  end
  result = stock_array_max_return.max
  if result[0] > 0
    puts "=> [#{stock_array_max_return.index(result)} , #{result[1]}] # for a profit of #{result[0] * 100}%"
  else
    puts "Do not buy"
  end
end

stock_picker([17,3,6,9,15,8,6,1,10,1,8,1,7,1,6,1,9])
stock_picker([9,8,7,6,5,4,3,2,1])
