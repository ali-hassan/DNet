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
  validates :pin, presence: true, if: :pin?
  has_many :children, foreign_key: :parent_id, class_name: "User"
  has_many :created_users, foreign_key: :created_by_id, class_name: "User"
  has_many :user_transactions, dependent: :destroy
  has_many :user_pair_keys, dependent: :destroy
  has_many :bit_pay_transactions, dependent: :destroy
  has_many :user_weekly_bonus_cycles, dependent: :destroy
  has_many :indirect_referred_users, -> { where("users.referred_by_id <> users.created_by_id") }, class_name: "User", foreign_key: :referred_by_id
  has_many :user_log_histories, class_name: 'LogHistory', as: :logable
  belongs_to :parent, class_name: "User", optional: true
  belongs_to :created_by, class_name: "User", optional: true
  belongs_to :referred_by, class_name: "User", optional: true
  has_many :log_histories, dependent: :destroy
  accepts_nested_attributes_for :user_transactions, reject_if: :all_blank, allow_destroy: true
  attr_accessor :current_pin
  validate :current_pin_verify, if: :current_pin?
  monetize :smart_wallet_balance_cents
  monetize :bonus_wallet_cents
  monetize :admin_balance_cents
  monetize :total_weekly_percentage_amount_cents
  monetize :current_week_roi_amount_cents
  monetize :current_total_weekly_roi_amount_cents
  monetize :indirect_bonus_amount_cents
  monetize :indirect_total_bonus_amount_cents
  monetize :pin_capacity_cents
  monetize :current_x_factor_income_cents
  monetize :binary_bonus_cents
  monetize :total_income_cents
  monetize :left_bonus_cents
  monetize :right_bonus_cents
  monetize :cash_wallet_minus_cents
  attr_encrypted :pin, key: Rails.application.secrets.secret_key,
    allow_empty_value: true, salt: Rails.application.secrets.secret_salt
  def current_pin_verify
    (current_pin.to_s != pin_was.to_s) && errors.add(:current_pin, "invalid pin") || true
  end
  def current_pin?
    !current_pin.nil?
  end
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
  def self.add_amount(amount)
    admin_user.update(smart_wallet_balance: admin_user.smart_wallet_balance.to_f + amount.try(:to_f))
  end
  def fit_user
    @fit_user ||= self.created_by
  end
  def fit_user=(usr_id)
    self.created_by_id = @fit_user = usr_id
    self.parent_position ||= Setting.find_value("tree_node").try(:value)
    self.parent = created_by.send("find_last_#{parent_position}_node") || self.created_by
  end
  delegate :find_last_right_node, :find_last_left_node, :parent_lists, :package_price, :direct_bonus_users_count,
   :direct_bonus_users_count_left, :direct_bonus_users_count_right, :indirect_bonus_users_count, :earn_weekly_point,
   :left_team_members_count, :right_team_members_count, :current_package, :children_list, :binary_bonus, :cash_wallet_total, to: :adapter
end
