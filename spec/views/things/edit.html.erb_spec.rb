require 'spec_helper'

describe "things/edit" do
  before(:each) do
    @thing = assign(:thing, stub_model(Thing,
      :some_id => 1,
      :name => "MyText"
    ))
  end

  it "renders the edit thing form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", thing_path(@thing), "post" do
      assert_select "input#thing_some_id[name=?]", "thing[some_id]"
      assert_select "textarea#thing_name[name=?]", "thing[name]"
    end
  end
end
