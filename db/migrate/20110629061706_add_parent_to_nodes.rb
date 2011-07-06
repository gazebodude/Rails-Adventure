class AddParentToNodes < ActiveRecord::Migration
  def self.up
    add_column :nodes, :parent_id, :integer
    add_column :nodes, :action_desc, :string
  end

  def self.down
    remove_column :nodes, :action_desc
    remove_column :nodes, :parent_id
  end
end
