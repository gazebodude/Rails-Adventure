require 'spec_helper'

describe Node do
  before(:each) do
    @attr = { :title => "Node title",
              :body => "Funny story",
              :action_desc => "woke up on the wrong side of the bed" }
  end

  it "should create a new node given valid attributes" do
    Node.create!(@attr)
  end

  describe "associations" do
    before(:each) do
      @root_node = Node.create(@attr)
    end

    it "should respond to children associations" do
      @root_node.should respond_to :children
    end

    it "should respond to parent associations" do
      @root_node.should respond_to :parent
    end

    it "shouldn't have any children if we don't create them" do
      @root_node.children.should be_empty
    end

    it "shouldn't have a parent, since it's the root node" do
      @root_node.parent.should be_nil
    end

    it "creating a valid child should alter the node count by one" do
      lambda do
        @root_node.children.create!(@attr)
      end.should change(Node, :count).by(1)
    end

    it "creating an invalid child node should not work" do
      lambda do
        @root_node.children.create(@attr.merge(:body => ''))
      end.should_not change(Node, :count)
    end

    it "should correctly fetch parent & child associations" do
      @child = @root_node.children.create!( :title => "Child",
                                            :body => "Yellow bulldozer",
                                            :action_desc => "brush teeth" )
      @child.parent.should == @root_node
      @root_node.children[0].should == @child
    end
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

    it "should require an action description" do
      test_node = Node.new(@attr.merge(:action_desc => ''))
      test_node.should_not be_valid
    end
  end
end

# == Schema Information
#
# Table name: nodes
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  body        :text
#  created_at  :datetime
#  updated_at  :datetime
#  parent_id   :integer
#  action_desc :string(255)
#

