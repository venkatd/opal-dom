describe "Kernel#Element" do
  before do
    @div = DOM <<-HTML
      <div id="element-spec">
        <div id="foo" class="bar"></div>
        <div class="woosh"></div>
        <div class="woosh"></div>
      </div>
    HTML

    @div.append_to_body
  end

  after do
    @div.remove
  end

  describe "when given an element id" do
    it "should return a new Element with found element" do
      DOM('#foo').class_name.should == "bar"
    end

    it "should return nil when no element found" do
      DOM('#bad-id').should be_nil
    end
  end

  describe "when given a generic CSS selector" do
    it "return a new Element with all matching elements" do
      woosh = DOM('.woosh')
      woosh.should be_kind_of(Element)
      woosh.size.should == 2
    end

    it "returns an empty Element collection for no matching elements" do
      empty = DOM '.no-maching-classnames'
      empty.should be_kind_of(Element)
      empty.size.should == 0
    end
  end

  describe "when given a string of HTML content" do
    it "should parse it and make it a member of the Element collection" do
      el = DOM('<div id="foo-bar-baz" class="woosh"></div>')

      el.should be_kind_of(Element)
      el.id.should == "foo-bar-baz"
      el.class_name.should == "woosh"
      el.size.should == 1
    end
  end
end