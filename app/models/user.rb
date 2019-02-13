class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  has_many :children, foreign_key: :parent_id, class_name: "User"
  belongs_to :parent, class_name: "User"
  def generate_token
    token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.exists?(sponsor_id: random_token)
    end
  end
end
