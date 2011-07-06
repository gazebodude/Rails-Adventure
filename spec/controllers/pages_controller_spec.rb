require 'spec_helper'

describe PagesController do
  render_views

  def valid_attributes
    { :title => "Title",
      :body => "Body",
      :action_desc => "Action",
      :parent_id => 1}
  end

  before(:each) do
    begin
      Node.find(1)
    rescue ActiveRecord::RecordNotFound
      # root node has a parent_id of nil
      Node.create! valid_attributes.merge(:parent_id => nil)
    end
  end

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it "should have the right title" do
      get :home
      response.should have_selector("title", :content => "Welcome")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get :about
      response.should have_selector("title", :content => "About")
    end
  end

end
