class LinkedList

  def initialize(head = nil)
    @head = head
  end

  def append(value = nil)
    node = Node.new(value)
    tail.next_node = node unless @head.nil?
    @head = node if @head.nil?
  end

  def prepend(value = nil)
    node = Node.new(value)
    node.next_node = @head unless @head.nil?
    @head = node
  end

  def size
    counter = 0
    each { counter += 1}
    counter
  end

  def head
    @head
  end

  def tail
    each { |node| node }
  end

  def at(index)
    counter = 0
    index = size + index if index < 0
    each { |node| return node if counter == index ; counter += 1 }
    nil
  end

  def pop
    last = tail
    at(-2).next_node = nil
    last
  end

  def contains?( value )
    each { |node| return true if value == node.value}
    false
  end

  def find(data)
    counter = 0
    each { |node| return counter if data == node.value ; counter += 1 }
    nil
  end

  def to_s
    each do |node|
      print "( #{node.value.nil? ? "nil" : node.value} ) -> "
    end
    puts "nil"
    # ( data ) -> ( data ) -> ( data ) -> nil
  end

  def insert_at(index , value = nil)
    node = Node.new(value , at(index))
    append while index > size
    index == 0 ? @head = node : at(index-1).next_node = node
  end

  def remove_at(index)
    return if index > size
    # node = at(index)
    index == 0 ? @head = at(1) : at(index-1).next_node =  at(index+1)
  end

  def each(node = @head)
    while !node.nil?
      result = yield(node)
      node = node.next_node
    end
    result
  end


end

class Node
  attr_accessor :value
  attr_accessor :next_node

  def initialize(value = nil , next_node = nil)
    @value = value
    @next_node = next_node
  end

  def to_s
    @value.to_s
  end

end

list = LinkedList.new
list.append
list.append("cat")
list.append("dog")
list.prepend("fish")
list.append("dragon")
list.to_s
puts list
puts list.size
puts list.head
puts list.tail
puts list.at(2)
puts list.at(-3)
puts list.pop
puts list.size
puts list.contains?("cat")
puts list.contains?("bird")
puts list.find("dog")
list.insert_at(3,"bird")
list.to_s
list.insert_at(0,"tree")
list.to_s
list.remove_at(2)
list.to_s
list.insert_at(10,"unicorn")
list.to_s
