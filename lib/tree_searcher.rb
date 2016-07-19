require_relative './parse_tag'
require_relative './node_renderer'



# Search for and return a collection with all nodes exactly matching the name, text, id, or class provided, e.g:

# searcher = TreeSearcher.new(tree)
# sidebars = searcher.search_by(:class, "sidebar")
# sidebars.each { |node| renderer.render(node) }
# # ...output for all nodes...

# Don't forget that a node can have multiple classes!

class TreeSearcher

  def initialize(tree)
    @tree = tree
    @root = tree.root
  end

  def search_by(attr_type, attr_name)
    results = []
    node = @root
    stack = [node]
    while node = stack.pop
      binding.pry
      if node.is_a?(Tag) 
        if attr_type == "class" && node.classes.include?(attr_name)
          results << node
        elsif node.send(attr_type.to_sym) == attr_name
          results << node
        end
        node.children.each do |child|
          stack.push(child)
        end
      end
    end
    render_results(results, attr_type)
    results
  end

  def render_results(results, attr_type)
    puts "Your search returned the following results:"
    results.each do |result|
      puts "#{result}, #{attr_type}: #{result.send(attr_type.to_sym)}"
    end
  end


end