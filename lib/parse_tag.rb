P_TAG = "<p class='foo bar' id='baz' name='fozzie'>"
DIV_TAG = "<div id = 'bim'>"
IMG_TAG = "<img src='http://www.example.com' title='funny things'>"

Tag = Struct.new(:type, :classes, :id, :name, :inside, :parent, :children, :depth)


html_string = "<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"


# <(div)>(.+)<\/\1>


class ScriptParser

  def initialize(html_string)
    @html = html_string
  end

  def parse_tag(tag)
    # goal: capture any alphanumeric characters of any length between "<" " " 
    type = tag.match(/<\w+( |>)/).to_a[0][1..-2]
    classes = tag.match(/(class=('|"))(.+?)(("|'))/).to_a[3]
    classes = classes.split(' ') if classes
    id = tag.match(/(id=('|"))(\w+?)(("|'))/).to_a[3]
    name = tag.match(/(name=('|"))(\w+?)(("|'))/).to_a[3]
    inside = # for tags that require, any content 
    Tag.new(type, classes, id, name, nil, nil, [], 0)
  end

  def html_split
    # begin
    #loop through every character in html string
    # if < , create a child tag, connect it to current tag, set current tag to child tag 
    # fill the current tag tag object's data before >
    # any text found here is added to "inside" data of current tag
      # if </ set current tag to current tag's parent
      # end until current tag. parent is nil


# "<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"

    current_tag = parse_tag(html_string)
    
    html_string.each_char.with_index do |char, i|
      
      if char == "<" && current_tag.depth > 0
        child_tag = parse_tag(html_string[i..-1])
        current_tag.children << child_tag

        child_tag.parent = current_tag
        current_tag = child_tag 
        current_tag.depth = current_tag.parent.depth + 1

      elsif char == "<" && html_string[i+1] = "/"
        current_tag = current_tag.parent
      end

    end
    current_tag
  end

  def parse_script
    @root = parse_tag()
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

# as we iterate, keep track of:
#tag we are inside of
#parent tag


#parent has child if new tag opens before parent closes
#parent's inside is when parent is the only opened tag and there is text
# 
sp = ScriptParser.new(html_string)
print sp.parse_tag(html_string)

