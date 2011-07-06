# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
Node.create(
  :title => "It Begins",
  :body => "It was a dark and stormy night.",
  :action_desc => "Join the story",
  :parent_id => nil
)
