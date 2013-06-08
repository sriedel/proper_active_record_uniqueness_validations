require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ThingsController do

  # This should return the minimal set of attributes required to create a valid
  # Thing. As you add validations to Thing, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "some_id" => "1" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ThingsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all things as @things" do
      thing = Thing.create! valid_attributes
      get :index, {}, valid_session
      assigns(:things).should eq([thing])
    end
  end

  describe "GET show" do
    it "assigns the requested thing as @thing" do
      thing = Thing.create! valid_attributes
      get :show, {:id => thing.to_param}, valid_session
      assigns(:thing).should eq(thing)
    end
  end

  describe "GET new" do
    it "assigns a new thing as @thing" do
      get :new, {}, valid_session
      assigns(:thing).should be_a_new(Thing)
    end
  end

  describe "GET edit" do
    it "assigns the requested thing as @thing" do
      thing = Thing.create! valid_attributes
      get :edit, {:id => thing.to_param}, valid_session
      assigns(:thing).should eq(thing)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Thing" do
        expect {
          post :create, {:thing => valid_attributes}, valid_session
        }.to change(Thing, :count).by(1)
      end

      it "assigns a newly created thing as @thing" do
        post :create, {:thing => valid_attributes}, valid_session
        assigns(:thing).should be_a(Thing)
        assigns(:thing).should be_persisted
      end

      it "redirects to the created thing" do
        post :create, {:thing => valid_attributes}, valid_session
        response.should redirect_to(Thing.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved thing as @thing" do
        # Trigger the behavior that occurs when invalid params are submitted
        Thing.any_instance.stub(:save).and_return(false)
        post :create, {:thing => { "some_id" => "invalid value" }}, valid_session
        assigns(:thing).should be_a_new(Thing)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Thing.any_instance.stub(:save).and_return(false)
        post :create, {:thing => { "some_id" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested thing" do
        thing = Thing.create! valid_attributes
        # Assuming there are no other things in the database, this
        # specifies that the Thing created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Thing.any_instance.should_receive(:update_attributes).with({ "some_id" => "1" })
        put :update, {:id => thing.to_param, :thing => { "some_id" => "1" }}, valid_session
      end

      it "assigns the requested thing as @thing" do
        thing = Thing.create! valid_attributes
        put :update, {:id => thing.to_param, :thing => valid_attributes}, valid_session
        assigns(:thing).should eq(thing)
      end

      it "redirects to the thing" do
        thing = Thing.create! valid_attributes
        put :update, {:id => thing.to_param, :thing => valid_attributes}, valid_session
        response.should redirect_to(thing)
      end
    end

    describe "with invalid params" do
      it "assigns the thing as @thing" do
        thing = Thing.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Thing.any_instance.stub(:save).and_return(false)
        put :update, {:id => thing.to_param, :thing => { "some_id" => "invalid value" }}, valid_session
        assigns(:thing).should eq(thing)
      end

      it "re-renders the 'edit' template" do
        thing = Thing.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Thing.any_instance.stub(:save).and_return(false)
        put :update, {:id => thing.to_param, :thing => { "some_id" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested thing" do
      thing = Thing.create! valid_attributes
      expect {
        delete :destroy, {:id => thing.to_param}, valid_session
      }.to change(Thing, :count).by(-1)
    end

    it "redirects to the things list" do
      thing = Thing.create! valid_attributes
      delete :destroy, {:id => thing.to_param}, valid_session
      response.should redirect_to(things_url)
    end
  end

end
