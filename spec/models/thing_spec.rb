require 'spec_helper'

describe Thing do
  let( :a_valid_unsaved_thing ) do
    Thing.new( :some_id     => 1,
               :name        => "foo",
               :description => "bar" )
  end

  let( :another_valid_unsaved_thing ) do
    Thing.new( :some_id     => 10,
               :name        => "foo_2000",
               :description => "binford_9000" )
  end

  let( :a_thing_violating_a_single_column_constraint ) do
    Thing.new( :some_id     => 1,
               :name        => "baz",
               :description => "quux" )
  end

  let( :a_thing_violating_a_multi_column_constraint ) do
    Thing.new( :some_id     => 2,
               :name        => "foo",
               :description => "bar" )
  end

  let( :a_widget_with_a_uniqueness_violation ) do
    Widget.create( :some_id => 1, :name => "foo", :description => "bar" )
    w = Widget.new( :some_id => 1, :name => "baz", :description => "quux"  )
    w.save
    w
  end

  let( :a_widget_with_a_multi_column_uniqueness_violation ) do
    Widget.create( :some_id => 1, :name => "foo", :description => "bar" )
    w = Widget.new( :some_id => 2, :name => "foo", :description => "bar"  )
    w.save
    w
  end

  describe "creating with #save" do
    context "without violating a uniqueness constraint" do
      subject { a_valid_unsaved_thing }

      it "should not raise an exception" do
        expect { subject.save }.to_not raise_error
      end

      it "should return true" do
        subject.save.should be_true
      end

      it "should have stored the value in the database" do
        expect { subject.save }.to change { Thing.count }.by(1)
      end

      it "should not have inserted anything to the errors" do
        subject.save
        subject.errors.should be_empty
      end
    end

    context "when violating a single column uniqueness constraint" do
      subject { a_thing_violating_a_single_column_constraint }

      before( :each ) do
        a_valid_unsaved_thing.save
      end

      it "should not raise an exception" do
        expect { subject.save }.to_not raise_error
      end

      it "should return false" do
        subject.save.should be_false
      end

      it "should not have stored the value in the database" do
        expect { subject.save }.to_not change { Thing.count }
      end

      it "should have added an errors entry for the attribute" do
        subject.save
        subject.errors.messages.should eq( a_widget_with_a_uniqueness_violation.errors.messages )
      end
    end

    context "when violating a multi-column uniqueness constraint" do
      subject { a_thing_violating_a_multi_column_constraint }

      before( :each ) do
        a_valid_unsaved_thing.save
      end

      it "should not raise an exception" do
        expect { subject.save }.to_not raise_error
      end

      it "should return false" do
        subject.save.should be_false
      end

      it "should not have stored the value in the database" do
        expect { subject.save }.to_not change { Thing.count }
      end

      it "should have added an errors entry for the scoped attributes" do
        subject.save
        subject.errors.messages.should eq( a_widget_with_a_multi_column_uniqueness_violation.errors.messages )
      end
    end
  end

  describe "updating with #save" do
    context "without violating a uniqueness constraint" do
      subject { a_valid_unsaved_thing }

      before( :each ) do
        subject.save 
        subject.some_id = 3
      end

      it "should not raise an exception" do
        expect { subject.save }.to_not raise_error
      end

      it "should return true" do
        subject.save.should be_true
      end

      it "should have stored the value in the database" do
        expect do
          subject.save 
          subject.reload
        end.to change { subject.updated_at }
      end

      it "should not have inserted anything to the errors" do
        subject.save
        subject.errors.should be_empty
      end
    end

    context "when violating a single column uniqueness constraint" do
      subject { another_valid_unsaved_thing }

      before( :each ) do
        a_valid_unsaved_thing.save
        subject.save
        subject.reload # grab new updated_at
        subject.some_id = a_valid_unsaved_thing.some_id
      end

      it "should not raise an exception" do
        expect { subject.save }.to_not raise_error
      end

      it "should return false" do
        subject.save.should be_false
      end

      it "should not have stored the value in the database" do
        expect do
          subject.save
          subject.reload
        end.to_not change { subject.updated_at }
      end

      it "should have added an errors entry for the attribute" do
        subject.save
        subject.errors.messages.should eq( a_widget_with_a_uniqueness_violation.errors.messages )
      end
    end

    context "when violating a multi-column uniqueness constraint" do
      subject { another_valid_unsaved_thing }

      before( :each ) do
        a_valid_unsaved_thing.save
        subject.save
        subject.reload # grab new updated_at
        subject.name = a_valid_unsaved_thing.name
        subject.description = a_valid_unsaved_thing.description
      end

      it "should not raise an exception" do
        expect { subject.save }.to_not raise_error
      end

      it "should return false" do
        subject.save.should be_false
      end

      it "should not have stored the value in the database" do
        expect do
          subject.save
          subject.reload
        end.to_not change { subject.updated_at }
      end

      it "should have added an errors entry for the scoped attributes" do
        subject.save
        subject.errors.messages.should eq( a_widget_with_a_multi_column_uniqueness_violation.errors.messages )
      end
    end

  end

end
