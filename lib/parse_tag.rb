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
  Tag.new(type, classes, id, name)
end

# The HTML string version
# You could read it in from a file instead if so inclined,
#   which would give you newline characters too
html_string = "<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"

# Now pull that string into a simple data structure
class ScriptParser

  def initialize(html_string)
    @html = html_string
  end

  def html_split
    tags = html.match(//)
    < <
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
  <p>
    p text
  </p>
  <div>
    more div text
  </div>
  div text after
</div>



#parent has child if new tag opens before parent closes
#parent's inside is when parent is the only opened tag and there is text
# 

# print parse_tag(P_TAG)