require 'node_renderer'
require 'parse_tag'

describe NodeRenderer do 

  let(:tree1){ScriptParser.new("<div class='main-content' id='main-content'>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>")}
  let(:renderer){NodeRenderer.new(tree1)}

  let(:tree2){ScriptParser.new("<div>  div text before  <p>    p text <a> link </a>  </p> div text after</div>")}
  let(:descendants_renderer){NodeRenderer.new(tree2)}

  let(:p_tag){descendants_renderer.root.children[0].children[1]}

  describe '#count_descendants' do 
    it 'counts the number of nodes in the entire tree upon initialization' do 
      expect(renderer.render).to eq(3)
    end

    it 'counts the number of nodes beneath a certain node when a node is passed' do 
      expect(renderer.render(p_tag.children[1])).to eq(1)
    end

  end

  describe '#node_types' do 
    it 'returns a hash' do 
      expect(renderer.node_types).to be_a(Hash)
    end
  end

end