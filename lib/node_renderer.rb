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
    display_attributes
    node_types
    count_descendants(node)
  end

  def display_attributes(node = nil)
    node ||= @root.children[0]
    puts "Node type: #{node.type}"
    puts "Node classes: #{node.classes}"
    puts "Node ID: #{node.id}"
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

  def node_types(node = nil)
    node ||= @root.children[0]
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