class AddNewNetwork
  include ActiveModel::Model
  attr_accessor :current_user
  def initialize(current_user, attrs={})
    self.current_user = current_user
    self.parent_id, self.sponsor_id = current_user.id, generate_token
    self.created_by_id = current_user.id
    self.referred_by_id = self.parent_id
    attrs.each { |k, v| send("#{k}=", v) }
  end
  def new_user
    @new_user ||= User.new
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, "MyNetwork")
  end
  delegate :generate_token, :parent_id, :parent_id=, :parent_position,
    :first_name, :first_name=, :last_name, :last_name=,
    :parent_position=, :sponsor_id, :sponsor_id=, :email, :email=,
    :contact_number, :contact_number=, :password_confirmation, :password_confirmation=,
    :errors, :city, :city=, :state, :state=, :document_number, :document_number=,
    :country, :country=, :created_by_id, :created_by_id=, :referred_by_id, :referred_by_id=,
    :is_dummy, :password, :password=, :is_dummy=, :parent, :valid?,
    :save, :parent_lists, to: :new_user
end
