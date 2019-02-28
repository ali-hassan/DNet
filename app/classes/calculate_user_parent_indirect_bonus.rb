require 'forwardable'

class CalculateUserParentIndirectBonus
  extend Forwardable
  def_delegators :@user, :package_price, :indirect_bonus_amount, :indirect_total_bonus_amount, :adapter
end
