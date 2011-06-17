require 'spec_helper'

describe Node do
  before(:each) do
    @attr = { :title => "Node title", :body => "Funny story" }
  end

  it "should create a new node" do
    Node.create!(@attr)
  end

  describe "validations" do

    it "should require a title" do
      test_node = Node.new(:title => "", :body => @attr[:body])
      test_node.should_not be_valid
    end

    it "should require a body" do
      test_node = Node.new(:title => @attr[:title], :body => "")
      test_node.should_not be_valid
    end

    it "shouldn't allow titles that are too long" do
      test_node = Node.new(:title => "a"*41, :body => @attr[:body])
      test_node.should_not be_valid
    end

    it "shouldn't allow bodies that are too long" do
      test_node = Node.new(:title => @attr[:title], :body => "a"*1001)
      test_node.should_not be_valid
    end
  end
end
