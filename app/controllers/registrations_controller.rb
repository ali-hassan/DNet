class RegistrationsController < Devise::RegistrationsController
  layout "registration"
  after_action :update_node, only: [:create]
  private
  def update_node
    if resource.persisted?
      parent_user = resource.referred_by || User.admin_user
      right_user_id = parent_user.id
      resource.referred_by_id ||= User.admin_user.try(:id)
      resource.created_by_id = resource.referred_by_id
      resource.update(parent_id: right_user_id, parent_position: params[:position] || Setting.find_value('tree_node').try(:value))
    end
  end
  def find_node(parent_user)
    # hash = { left: :find_last_left_node, right: :find_last_right_node }.with_indifferent_access
    # parent_user.try(hash[params[:position] || Setting.find_value('tree_node').try(:value).try(:downcase) || "left"])
  end
end
