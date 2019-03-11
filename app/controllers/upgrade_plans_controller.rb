class UpgradePlansController < BuyPlansController
  before_action(only: [:show, :edit, :create]) { current_user.adapter.can_upgrade_url?(params[:id] || params[:plan_id]) || redirect_to(dashboard_index_url(subdomain: "office"), notice: "You can not downgrade") }
  def upgrade_plan
    true
  end
end
