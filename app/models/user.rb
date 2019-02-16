class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, :last_name, presence: true
  has_many :children, foreign_key: :parent_id, class_name: "User"
  belongs_to :parent, class_name: "User", optional: true
  belongs_to :created_by, class_name: "User", optional: true

  def full_name
    [first_name, last_name].join(" ")
  end
  def name_or_id
    full_name.present? && full_name || sponsor_id
  end
  def generate_token
    token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.exists?(sponsor_id: random_token)
    end
  end
  def adapter
    @adapter ||= CurrentUserAdapter.new(self)
  end
  delegate :find_last_right_node, :find_last_left_node, to: :adapter
end
