class User < ApplicationRecord
  mount_uploader :document, DocumentUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :first_name, :last_name, :username, presence: true
  validates :username, uniqueness: true
  has_many :children, foreign_key: :parent_id, class_name: "User"
  has_many :created_users, foreign_key: :created_by_id, class_name: "User"
  has_many :user_transactions, dependent: :destroy
  belongs_to :parent, class_name: "User", optional: true
  belongs_to :created_by, class_name: "User", optional: true
  belongs_to :referred_by, class_name: "User", optional: true
  accepts_nested_attributes_for :user_transactions, reject_if: :all_blank, allow_destroy: true
  monetize :smart_wallet_balance_cents
  monetize :bonus_wallet_cents
  monetize :admin_balance_cents

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
  def self.admin_user
    find_by is_admin: true
  end
  delegate :find_last_right_node, :find_last_left_node, :parent_lists, :package_price, :direct_bonus_users_count,
   :direct_bonus_users_count_left, :direct_bonus_users_count_right, :indirect_bonus_users_count, to: :adapter
end
