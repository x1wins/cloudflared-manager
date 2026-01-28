class Node
  attr_accessor :key, :left, :right

  def initialize(key)
     @key = key
     @left = nil
     @right = nil
  end
end

class BTree
  def initialize
    @root = nil
  end

  def insert(key)
    if @root.nil?
       @root = Node.new(key)
    else
      insert_node(@root, key)
    end
  end

  private

  def insert_node(node, key)
    if key < node.key
      unless node.left
        node.left = Node.new(key)
      else
        insert_node(node.left, key)
      end
    else
      unless node.right
        node.right = Node.new(key)
      else
        insert_node(node.right, key)
      end
    end
  end

  def inorder_traverse(node)
    return if node.nil?

    inorder_traverse(node.left)
    print "#{node.key} "
    inorder_traverse(node.right)
  end

  def display
    inorder_traverse(@root)
    puts
  end
end

if __FILE__ == $0
  bt = BTree.new
  bt.insert(50)
  bt.insert(30)
  bt.insert(20)
  bt.insert(40)
  bt.insert(70)
  bt.insert(60)
  bt.insert(80)
  bt.display  # Output: 20 30 40 50 60 70 80
end
