require 'spec_helper'

describe "things/new" do
  before(:each) do
    assign(:thing, stub_model(Thing,
      :some_id => 1,
      :name => "MyText"
    ).as_new_record)
  end

  it "renders new thing form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", things_path, "post" do
      assert_select "input#thing_some_id[name=?]", "thing[some_id]"
      assert_select "textarea#thing_name[name=?]", "thing[name]"
    end
  end
end
