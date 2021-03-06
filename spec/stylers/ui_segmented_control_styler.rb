class StyleSheetForUIViewStylerTests < RubyMotionQuery::Stylesheet

  def ui_segment_kitchen_sink(st)
    st.init_with_segments = ['Four','Five']
    st.prepend_segments = 'Three'
    st.prepend_segments = ['One', 'Two']
  end

end

describe 'stylers/ui_segmented_control' do
  before do
    @vc = UIViewController.alloc.init
    @vc.rmq.stylesheet = StyleSheetForUIViewStylerTests
    @view_klass = UISegmentedControl
  end

  behaves_like "styler"

  it 'should apply a style with every UISegmentedControlStyler wrapper method' do
    view = @vc.rmq.append(@view_klass, :ui_segment_kitchen_sink).get

    view.tap do |v|
      v.titleForSegmentAtIndex(0).should == "One"
      v.titleForSegmentAtIndex(1).should == "Two"
      v.titleForSegmentAtIndex(2).should == "Three"
      v.titleForSegmentAtIndex(3).should == "Four"
      v.titleForSegmentAtIndex(4).should == "Five"
    end
  end
end
