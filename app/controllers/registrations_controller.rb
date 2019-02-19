class RegistrationsController < Devise::RegistrationsController
  after_action :update_node, only: [:create]
  private
  def update_node
    if resource.persisted?
      parent_user = resource.referred_by || User.admin_user
      right_user_id = (parent_user.try(:find_last_right_node) || parent_user).try(:id)
      resource.referred_by_id ||= User.admin_user.try(:id)
      resource.update(parent_id: right_user_id, parent_position: "right")
    end
  end
end
