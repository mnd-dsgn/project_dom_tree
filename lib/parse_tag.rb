P_TAG = "<p class='foo bar' id='baz' name='fozzie'>"
DIV_TAG = "<div id = 'bim'>"
IMG_TAG = "<img src='http://www.example.com' title='funny things'>"

def parse_tag(tag)
  # goal: capture any alphanumeric characters of any length between "<" " " 
  type = tag.match(/<\w+ /).to_a[0][1..-1]
  classes = tag.match(/(class=('|"))(.+?)(("|'))/).to_a[3]
  classes = classes.split(' ')
  id = tag.match(/(id=('|"))(\w+?)(("|'))/).to_a[3]
end

print parse_tag(P_TAG)