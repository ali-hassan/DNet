class RegistrationsController < Devise::RegistrationsController
  after_action :update_node, only: [:create]
  private
  def update_node
    if resource.persisted?
      debugger
      puts "its here", "\n" * 5
      dummy_user.children.update(parent_id: resource.id)
      resource.update(parent_id: dummy_user.parent_id, parent_position: dummy_user.parent_position, created_by_id: dummy_user.created_by_id)
      dummy_user.destroy
    end
  end
  def dummy_user
    @dummy_user ||= User.find_by sponsor_id: resource.sponsor_id, is_dummy: true
  end
end
