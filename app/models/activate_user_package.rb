class ActivateUserPackage < ApplicationRecord
  belongs_to :user
  after_create { |aup| ChargeAmountAtA.new(aup.user, aup.package_id, false, false).charge! }
end
