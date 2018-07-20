module Enumerable

  def my_each
    for x in self do
      yield(x)
    end
    self
  end

  def my_each_with_index
    for x in 0...self.length do
      yield(self[x] , x)
    end
    self
  end

  def my_select
    new_enum = []
    self.my_each do |i|
      if yield(i)
        new_enum.push(i)
      end
    end
    new_enum
  end

  def my_all?
    if block_given?
      self.my_each do |x|
        if yield(x)==false || yield(x).nil?
         return false
        end
      end
      true
    else
      self.my_all? do |i|
         i != false && i.nil? != true
      end
    end
  end

  def my_any?
    if block_given?
      self.my_each do |x|
        if yield(x)==true || yield(x).nil?
         return true
        end
      end
      false

    else
      self.my_any? do |i|
         i != false && i.nil? != true
      end
    end
  end

  def my_none?
    if block_given?
      self.my_each do |x|
        if yield(x)==true
         return false
        end
      end
      true
    else
      self.my_all? do |i|
         i != false && i.nil? != true
      end
    end
  end

  def my_count
    if block_given?
    counter = 0
    self.my_each do |x|
      counter += 1 if yield(x)
    end
    else
      counter = self.length
    end
    counter
  end

  def my_map(&block)
    new_enum = []
    self.my_each do |i|
      new_enum.push(block.call(i))
    end
    new_enum
  end

  def my_inject(result=nil)

    result = self[0] if result.nil?
    self.my_each do |i|
      result = yield(result,i)
    end
    result

  end



end





# puts ""
#
# puts [10,25,34,48,51].inject(1){|product,i| product + i}
# puts ([10,25,34,48,51].my_inject(1){|product,i| product + i})
#
# [10,25,34,48,51].my_each do |i|
#   print i
# end
# puts ""
# [10,25,34,48,51].my_each_with_index do |val, i|
#   puts "val:#{val} : index:#{i}"
# end
#
# puts ([10,25,34,48,51].my_select do |i|
#   i%2==0
# end).inspect
#
# puts ([10,5,3,"8cat"].my_none? do |i|
#   i.to_i > 20
# end)
#
# puts ([nil,7,4,"cat"].my_all?)
#
# puts ([10,25,34,48,51].my_count)
# puts ([10,25,34,48,51].my_count do |i|
#   i == 25
# end)
# test_proc = Proc.new {|i| i + 6}
# puts ([10,25,34,48,51].my_map(&test_proc))
# puts ([10,25,34,48,51].my_map do |i|
#   i / 2.0
# end)
#
# puts ""
