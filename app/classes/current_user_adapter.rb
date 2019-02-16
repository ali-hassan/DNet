class CurrentUserAdapter
  attr_accessor :user
  def initialize(user)
    self.user = user
  end

  def find_last_node(usr, position)
    ( _ = current_child(usr, position)) && find_last_node(_, position) || usr
  end
  def current_child(u, po)
    u.children.find_by parent_position: po
  end
  class_eval do
    %w(right left).each do |pstn|
      define_method "find_last_#{pstn}_node" do
        find_last_node(user, pstn)
      end
    end
  end
  def parent_lists
    fetch_parent_list(user, [])
  end
  def fetch_parent_list(usr, result=[])
    (_=find_parent(usr)).present? && (result.push(_); fetch_parent_list(_, result)) || result
  end
  def find_parent(usr)
    User.find_by id: usr.parent_id
  end
end
