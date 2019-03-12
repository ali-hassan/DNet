class PinVerify
  include ActiveModel::Model
  attr_accessor :user, :pin
  validates :pin, presence: true
  validate do |resource|
    resource.try(:pin) == user.pin || self.errors.add(:pin, "Invalid Pin")
  end
  def initialize(user, params={})
    self.user=user; params.each { |k, v| send("#{k}=", v) }
  end

end
