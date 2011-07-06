class Node < ActiveRecord::Base
  attr_accessible :title, :body, :action_desc

  has_many :children, :class_name => "Node",
                      :foreign_key => "parent_id"
  belongs_to :parent, :class_name => "Node"

  validates_presence_of :title, :body, :action_desc
  validates_length_of :title, :maximum => 40
  validates_length_of :body,  :maximum => 1000
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

