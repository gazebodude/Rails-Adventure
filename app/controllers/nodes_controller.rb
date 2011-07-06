class NodesController < ApplicationController
  ROOT_NODE_ID = 1

  # GET /nodes
  # GET /nodes.xml
  def index
    @nodes = Node.all
    @title = "Nodes"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @nodes }
    end
  end

  # GET /nodes/1
  # GET /nodes/1.xml
  def show
    @node = Node.find_by_id(params[:id])
    @title = @node.title if @node

    respond_to do |format|
      if !@node.nil?
        format.html # show.html.erb
        format.xml  { render :xml => @node }
      else
        flash[:warning] = "Node ##{params[:id]} doesn't exist."
        format.html { redirect_to(root_path) }
      end
    end
  end

  # GET /nodes/new
  # GET /nodes/new.xml
  def new
    @node = Node.new
    @parent_id = params[:parent_id]
    @title = "New Node"

    respond_to do |format|
      if !@parent_id.nil? && !Node.find_by_id(@parent_id).nil?
        format.html # new.html.erb
        format.xml  { render :xml => @node }
      else
        flash[:warning] = "Node ##{@parent_id} doesn't exist."
        format.html { redirect_to(root_path) }
      end
    end
  end

  # GET /nodes/1/edit
  def edit
    @title = "Edit Node"
    @node = Node.find(params[:id])
  end

  # POST /nodes
  # POST /nodes.xml
  def create
    begin
      @parent_id = params[:node][:parent_id]
      @parent = Node.find(@parent_id)
      @node = @parent.children.new(params[:node])

      respond_to do |format|
        if @node.save
          format.html { redirect_to(@node, :notice => 'Node was successfully created.') }
          format.xml  { render :xml => @node, :status => :created, :location => @node }
        else
          format.html { render :action => "new"}
          format.xml  { render :xml => @node.errors, :status => :unprocessable_entity }
        end
      end
    rescue ActiveRecord::RecordNotFound
      @node = Node.new
      flash[:warning] = "Parent node id #{@parent_id} invalid."
      render :action => :new
    end
  end

  # PUT /nodes/1
  # PUT /nodes/1.xml
  def update
    @node = Node.find(params[:id])

    respond_to do |format|
      if @node.update_attributes(params[:node])
        format.html { redirect_to(@node, :notice => 'Node was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @node.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /nodes/1
  # DELETE /nodes/1.xml
  def destroy
    @node = Node.find(params[:id])
    @node.destroy

    respond_to do |format|
      format.html { redirect_to(nodes_url) }
      format.xml  { head :ok }
    end
  end
end
