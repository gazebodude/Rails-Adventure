class CreateNodes < ActiveRecord::Migration
  def self.up
    create_table :nodes do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :nodes
  end
end
