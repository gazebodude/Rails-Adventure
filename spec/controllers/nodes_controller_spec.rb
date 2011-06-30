require 'spec_helper'

describe NodesController do
  render_views

  # This should return the minimal set of attributes required to create a valid
  # Node. As you add validations to Node, be sure to
  # update the return value of this method accordingly.
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

  describe "GET index" do
    it "assigns all nodes as @nodes" do
      node = Node.create! valid_attributes
      get :index
      assigns(:nodes).should eq(Node.all)
    end

    it "shows all the nodes" do
      Node.create! valid_attributes.merge(:title => "Title1")
      Node.create! valid_attributes.merge(:title => "Title2")
      get :index
      Node.all.each do |n|
        response.should have_selector("span.node_title", :content => n.title)
      end
    end

    it "has the right title" do
      get :index
      response.should have_selector("title", :content => "Nodes")
    end
  end

  describe "GET show" do
    before(:each) do
      @node = Node.create! valid_attributes
    end

    it "has the right title" do
      get :show, :id => @node.id.to_s
      response.should have_selector("title", :content => @node.title)
    end

    it "assigns the requested node as @node" do
      get :show, :id => @node.id.to_s
      assigns(:node).should eq(@node)
    end

    it "shows the requested node" do
      get :show, :id => @node.id.to_s
      response.should have_selector("span.node_title", :content => @node.title)
    end

    it "has links to all the child nodes" do
      # create a node with three children
      1.upto(3) do |i|
        @node.children.create!( :title  => "Child #{i}",
                                    :body   => "You see #{i} little stones.",
                                    :action_desc => "Jump #{i} times." )
      end
      get :show, :id => @node.id.to_s
        @node.children.each do |child|
        response.should have_selector("a", :href => node_path(child),
                                      :class => "child_link",
                                      :content => child.action_desc)
      end
    end

    it "should have a new action link" do
      get :show, :id => @node.id.to_s
      response.should have_selector("a",
                              :href => new_node_path(:parent_id => @node.id))
    end
  end

  describe "GET new" do
    it "has the right title" do
      get :new
      response.should have_selector("title", :content => "New Node")
    end

    it "assigns a new node as @node" do
      get :new
      assigns(:node).should be_a_new(Node)
    end
  end

  describe "GET edit" do
    it "assigns the requested node as @node" do
      node = Node.create! valid_attributes
      get :edit, :id => node.id.to_s
      assigns(:node).should eq(node)
    end
  end

  describe "POST create" do
    before(:each) do
      @root_node = Node.find(1)
      valid_attributes.merge(:parent_id => 1)
    end

    describe "with valid params" do
      it "creates a new Node" do
        expect {
          post :create, :node => valid_attributes.merge(:parent_id => 1)
        }.to change(Node, :count).by(1)
      end

      it "assigns a newly created node as @node" do
        post :create, :node => valid_attributes.merge(:parent_id => 1)
        assigns(:node).should be_a(Node)
        assigns(:node).should be_persisted
      end

      it "redirects to the created node" do
        post :create, :node => valid_attributes.merge(:parent_id => 1)
        response.should redirect_to(Node.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved node as @node" do
        # Trigger the behavior that occurs when invalid params are submitted
        Node.any_instance.stub(:save).and_return(false)
        post :create, :node => {}
        assigns(:node).should be_a_new(Node)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Node.any_instance.stub(:save).and_return(false)
        post :create, :node => {}
        response.should render_template("new")
      end

      it "should re-render with the correct parent_id" do
        # Trigger the behavior that occurs when invalid params are submitted
        Node.any_instance.stub(:save).and_return(false)
        post :create, :node => {:parent_id => 2}
        response.should have_selector("input", :type => "hidden",
                                      :name => "node[parent_id]",
                                      :value => "2")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested node" do
        node = Node.create! valid_attributes
        # Assuming there are no other nodes in the database, this
        # specifies that the Node created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Node.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => node.id, :node => {'these' => 'params'}
      end

      it "assigns the requested node as @node" do
        node = Node.create! valid_attributes
        put :update, :id => node.id, :node => valid_attributes
        assigns(:node).should eq(node)
      end

      it "redirects to the node" do
        node = Node.create! valid_attributes
        put :update, :id => node.id, :node => valid_attributes
        response.should redirect_to(node)
      end
    end

    describe "with invalid params" do
      it "assigns the node as @node" do
        node = Node.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Node.any_instance.stub(:save).and_return(false)
        put :update, :id => node.id.to_s, :node => {}
        assigns(:node).should eq(node)
      end

      it "re-renders the 'edit' template" do
        node = Node.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Node.any_instance.stub(:save).and_return(false)
        put :update, :id => node.id.to_s, :node => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested node" do
      node = Node.create! valid_attributes
      expect {
        delete :destroy, :id => node.id.to_s
      }.to change(Node, :count).by(-1)
    end

    it "redirects to the nodes list" do
      node = Node.create! valid_attributes
      delete :destroy, :id => node.id.to_s
      response.should redirect_to(nodes_url)
    end
  end

end
