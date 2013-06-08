require 'spec_helper'

describe Widget do
  describe "the validations" do
    it "should validate the uniqueness of some_id" do
      Widget.create( :some_id => 1, :name => "foo", :description => "bar" )

      another_widget = Widget.new( :some_id => 1, :name => "baz", :description => "quux" )
      another_widget.should_not be_valid
      another_widget.should have(1).error_on( :some_id )
    end

    it "should validate the uniqueness of the (name, description) tuple" do
      Widget.create( :some_id => 1, :name => "foo", :description => "bar" )
      another_widget = Widget.new( :some_id => 2, :name => "foo", :description => "bar" )
      another_widget.should_not be_valid
      another_widget.should have(1).error_on( :name )
    end
  end
end
