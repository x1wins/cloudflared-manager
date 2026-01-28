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
    if node.key > key
      if node.left.nil?
        node.left = Node.new(key)
      else
        insert_node(node.left, key)
      end
    else
      if node.right.nil?
        node.right = Node.new(key)
      else
        insert_node(node.right, key)
      end
    end
  end

  def inorder_traverse(node)
    return unless node

    inorder_traverse(node.left)
    print "#{node.key} "
    inorder_traverse(node.right)
  end

  def display
    inorder_traverse(@root)
    puts
  end
end

# Example usage:
btree = BTree.new
btree.insert(50)
btree.insert(30)
btree.insert(20)
btree.insert(40)
btree.insert(70)
btree.insert(60)
btree.insert(80)

btree.display  # Output: 20 30 40 50 60 70 80
