class Support
  include ActiveModel::Model
  attr_accessor :requester, :username, :subject, :type, :description, :user, :email
  validates :requester, :username, :subject, :type, :description, presence: true

  def initialize(user, params={})
    self.user=user;params.each { |k, v| send("#{k}=", v) }
  end
  def commit!
    valid? && UserMailer.support(self).deliver_now
  end
end
