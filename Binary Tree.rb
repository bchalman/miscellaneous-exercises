class Node
  attr_accessor :value
  attr_reader :parent
  attr_reader :left_child
  attr_reader :right_child

  def initialize(value = nil , node_parent = nil, left_child = nil , right_child = nil)
    @value = value
    self.parent= node_parent
    @left_child = left_child
    @right_child = right_child


  end

  def parent= (node = nil)
    if node.nil?
      @parent = nil
    else
      @parent = node
      node.child = self unless node.left_child == self || node.right_child == self
    end
  end

  def child= (node)
    if @left_child.nil?     # if left child is empty set node to be left_child
      @left_child = node
      @left_child.parent = self unless @left_child.parent == self
    else                    # will over write the right child if self is full
      @right_child.parent = nil unless @right_child.nil?
      @right_child = node
      @right_child.parent = self unless @left_child.parent == self
    end
  end

  def left_child= (node)
    @left_child.parent = nil unless @left_child.nil? # clear the parent of the current child
    @left_child = node
    @left_child.parent = self unless @left_child.parent == self
  end

  def right_child= (node)
    @right_child.parent = nil unless @right_child.nil? # clear the parent of the current child
    @right_child = node
    @right_child.parent = self unless @right_child.parent == self
  end


  def add_node (node)
    return if node.value.nil?
    if node.value < value
      if @left_child.nil?
         self.left_child = node
      else
         @left_child.add_node (node)
      end
    else
      if @right_child.nil?
         self.right_child = node
      else
         @right_child.add_node (node)
      end
    end
  end

  def breadth_first_search(value)
    queue = [self]
    loop do
      node = queue.shift
      return node if node.value == value
      queue << node.left_child unless node.left_child.nil?
      queue << node.right_child unless node.right_child.nil?
      break if queue.length == 0
    end
    nil
  end

  def depth_first_search(value)
    return self if @value == value
    node = @left_child.depth_first_search(value) unless @left_child.nil?
    return node unless node.nil?
    node = @right_child.depth_first_search(value) unless @right_child.nil?
    return node unless node.nil?
    nil
  end


end

def build_tree_presorted(data_array , parent = nil)
  mid = data_array.size / 2
  node = Node.new(data_array[mid] , parent)
  left = data_array[0...mid]
  right = data_array[mid + 1..-1]
  build_tree_presorted(left ,node) if left.length > 0
  build_tree_presorted(right,node) if right.length > 0
  return node
end

def build_tree(array, head = nil)
  value = array.shift
  # puts head.value unless head.nil?
  node = Node.new(value)
  head = node if head.nil?
  head.add_node(node) unless node == head
  # visualize_tree(head)
  build_tree(array, head) if array.length > 1
  return head

end

def visualize_tree(head)
  array_curent = [head]

  loop do
    array_children = []
    print "["
    array_curent.each do |node|
      print " #{ node.nil? ? "." : node.value } "
      array_children << (node.nil? ? nil : node.left_child)
      array_children << (node.nil? ? nil : node.right_child)
    end
    puts "]"
    array_curent = array_children.dup
    break if array_curent.all? { |node| node.nil?  }
    # break if array_curent.size > 32
  end
end






data_array =[1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
puts (data_array_sorted = data_array.sort).inspect

tree =  build_tree_presorted(data_array_sorted)
tree.add_node(Node.new)
visualize_tree(tree)
puts""
visualize_tree(tree.depth_first_search(9))

# manual_tree = Node.new(10)
# manual_tree.right_child = Node.new(20)
# manual_tree.left_child = Node.new(5)
# manual_tree.add_node(Node.new(8))
# visualize_tree(manual_tree)
# puts""
#
# puts data_array.inspect
# unsorted_tree = build_tree(data_array)
# visualize_tree(unsorted_tree)
