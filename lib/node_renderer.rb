# This function outputs simple statistics for a particular node, including:

#     How many total nodes there are in the sub-tree below this node
#     A count of each node type in the sub-tree below this node
#     All of the node's data attributes

# ...output...
require 'pry'
require_relative './parse_tag'

class NodeRenderer

  attr_reader :root

  def initialize(tree)
    @tree = tree
    @root = tree.root
    render
  end

  def render(node = nil)
    node ||= @root.children[0] 
    node_types(node)
    count_descendants(node)
    #     A count of each node type in the sub-tree below this node
      # create a hash
      # trawl through nodes
      # for each node that's a tag, add 1 to its value in the hash
      # find a way to print the value
  end

  def count_descendants(node)
    counter = 0
    stack = [node]
    while node = stack.pop
      if node.is_a?(Tag)
        counter += 1
        node.children.each do |child|
          stack.push(child)
        end
      end
    end
    counter
  end

  def node_types(node)
    hash = {}
    stack = [node]
    while node = stack.pop
      if node.is_a?(Tag)
        hash[node.type] ||= 0
        hash[node.type] += 1
        node.children.each do |child|
          stack.push(child)
        end
      end
    end 
    render_node_types(hash)
    hash
  end

  def render_node_types(hash)
    hash.each do |key, value|
      puts "There is #{value} #{key} tag." if value == 1
      puts "There are #{value} #{key} tags." if value > 1 
    end
  end

end