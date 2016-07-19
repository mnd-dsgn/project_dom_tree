require 'pry'

P_TAG = "<p class='foo bar' id='baz' name='fozzie'>"
DIV_TAG = "<div id = 'bim'>"
IMG_TAG = "<img src='http://www.example.com' title='funny things'>"

Tag = Struct.new(:type, :classes, :id, :name, :inside, :parent, :children, :depth)
TagContent = Struct.new(:parent, :text)



# <(div)>(.+)<\/\1>


class ScriptParser
  attr_reader :root, :html
  def initialize(html_string)
    @html = html_string
    @root = Tag.new('document', [], nil, nil, '', nil, [], 0)
    chop_off_doctype(@html)
    parse_script
    # strip_insides
  end

  def parse_tag(tag)
    type = tag.match(/<\w+( |>)/).to_a[0][1..-2] if tag.match(/<\w+( |>)/).to_a[0]
    classes = tag.match(/(class=('|"))(.+?)(("|'))/).to_a[3]
    classes = classes.split(' ') if classes
    classes ||= []
    id = tag.match(/(id=('|"))(.+?)(("|'))/).to_a[3]
    name = tag.match(/(name=('|"))(\w+?)(("|'))/).to_a[3]
    # inside = # for tags that require, any content 
    Tag.new(type, classes, id, name, '', nil, [], 0)
  end

  def parse_tag_content(parent, html) 
    # capture everything until next "<"
    tag_content = html.match(/(.+?)</)[1].strip # >(.+?)<  # ((\w+)(\s)*[^<>])+
    TagContent.new(parent, tag_content)
  end

  def parse_script

# "<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"


  
    current_tag = @root
    inside_opening_tag = true
    inside_closing_tag = false
    in_content = false  

    @html.each_char.with_index do |char, i|
      if char == "<" && @html[i+1] != '/'
        child_tag = parse_tag(@html[i..-1])

        current_tag.children << child_tag
        child_tag.parent = current_tag
        child_tag.depth = current_tag.depth + 1

        current_tag = child_tag 
        inside_opening_tag = true
        in_content = false

      elsif inside_opening_tag && char == '>'
        inside_opening_tag = false

      elsif inside_closing_tag && char == '>'
        inside_closing_tag = false

      elsif char == "/" && @html[i-1] == '<'
        current_tag = current_tag.parent
        inside_closing_tag = true
        
        in_content = false

      elsif inside_closing_tag == false && 
            inside_opening_tag == false && 
            char != '>' && char != '<' && 
            in_content == false &&
            char =~ /\S/

         # problem: this will also capture any content that's just whitespace
         # => solution: change conditional to only be met once non-whitespace is found   
        # DONE: change conditional to only call this once text appears outside of tags
        # DONE: call a parse_content method 
        # that creates a TagContent object with #text of all @html that follows until a "<" char  
        content = parse_tag_content(current_tag, @html[i..-1])
        current_tag.children << content
        in_content = true 
      end

    end
    @root
  end

  def strip_insides(child)

    @root.children.each do |child|
      return if child.children == []
      child.inside.strip
      strip_insides(child)
    end
  end

  def chop_off_doctype(html)
    first_tag = /<([^<>]+)>/.match(html)[0]
    if first_tag.downcase =~ /<\!doctype.+>/
      @html = html[first_tag.length..-1]
    end
    html
  end


end

# Finally, output the string again.
# It doesn't have to have pretty spacing like it does here...
# outputter( data_structure )

# <div>
#   div text before
#   <p>  # < signifies begin child tag creation
#       # </ signifies end child tag creation
#     p text
#   </p>
#   <div>
#     more div text
#   </div>
#   div text after # if not in a child tag, any text is added to :inside
# </div>



# "<div class='main-content' id='main-content'>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"
