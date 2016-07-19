require 'node_renderer'
require 'parse_tag'
require 'tree_searcher'

describe TreeSearcher do 

  let(:tree1){ScriptParser.new("<div class='main-content' id='main-content'>  div text before  <p id='paragraph1'>    p text <a> some link </a>  </p>  <div class='main-content'>    more div text  </div>  div text after</div>")}
  let(:searcher){TreeSearcher.new(tree1)}

  describe "#search_by" do 

    it "returns an array of results when passed an attribute type and attribute name" do 
      expect(searcher.search_by("class", "main-content")[0]).to be_a(Tag)
      expect(searcher.search_by("class", "main-content").length).to eq(2)
    end

  end


end
