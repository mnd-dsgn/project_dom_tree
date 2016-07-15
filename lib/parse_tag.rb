P_TAG = "<p class='foo bar' id='baz' name='fozzie'>"
DIV_TAG = "<div id = 'bim'>"
IMG_TAG = "<img src='http://www.example.com' title='funny things'>"

Tag = Struct.new(:type, :classes, :id, :name, :inside, :parent, :children)

def parse_tag(tag)
  # goal: capture any alphanumeric characters of any length between "<" " " 
  type = tag.match(/<\w+ /).to_a[0][1..-2]
  classes = tag.match(/(class=('|"))(.+?)(("|'))/).to_a[3]
  classes = classes.split(' ')
  id = tag.match(/(id=('|"))(\w+?)(("|'))/).to_a[3]
  name = tag.match(/(name=('|"))(\w+?)(("|'))/).to_a[3]
  inside = # for tags that require, any content 
  Tag.new(type, classes, id, name)
end

# The HTML string version
# You could read it in from a file instead if so inclined,
#   which would give you newline characters too
html_string = "<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"


# <(div)>(.+)<\/\1>

# Now pull that string into a simple data structure
class ScriptParser

  def initialize(html_string)
    @html = html_string
  end

  def html_split
    # begin
    #loop through every character in html string
    # if < , create a child tag, connect it to current tag, set current tag to child tag 
    # fill the current tag tag object's data before >
    # any text found here is added to "inside" data of current tag
      # if </ set current tag to current tag's parent
      # end until current tag. parent is nil
  end

  def parse_script
    @root = parse_tag()
  end
end

# Finally, output the string again.
# It doesn't have to have pretty spacing like it does here...
outputter( data_structure )

<div>
  div text before
  <p>  # < signifies begin child tag creation
      # </ signifies end child tag creation
    p text
  </p>
  <div>
    more div text
  </div>
  div text after # if not in a child tag, any text is added to :inside
</div>

# as we iterate, keep track of:
#tag we are inside of
#parent tag


#parent has child if new tag opens before parent closes
#parent's inside is when parent is the only opened tag and there is text
# 

# print parse_tag(P_TAG)