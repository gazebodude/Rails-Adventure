module NodesHelper
  def add_action_link_text(number_of_children)
    if number_of_children>0
      "Or do something else"
    else
      "Do something"
    end
  end
end
