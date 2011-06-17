class Node < ActiveRecord::Base
  attr_accessible :title, :body

  validates_presence_of :title, :body
  validates_length_of :title, :maximum => 40
  validates_length_of :body,  :maximum => 1000
end
