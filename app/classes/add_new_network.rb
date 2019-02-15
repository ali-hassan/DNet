class AddNewNetwork
  attr_accessor :current_user
  def initialize(current_user, attrs={})
    self.current_user = current_user
    self.parent_id, self.sponsor_id = current_user.id, generate_token
    # DUMMY EMAIL
    self.email, self.created_by_id, self.is_dummy = "#{self.sponsor_id}@dummy.com", current_user.id, true
    attrs.each { |k, v| send("#{k}=", v) }
  end
  def new_user
    @new_user ||= User.new
  end
  def save
    new_user.save(validate: false)
  end
  delegate :generate_token, :parent_id, :parent_id=, :parent_position,
    :parent_position=, :sponsor_id, :sponsor_id=, :email, :email=,
   :created_by_id, :created_by_id=, :is_dummy, :is_dummy=, to: :new_user
end
