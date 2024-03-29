class User < ApplicationRecord
  mount_uploader :document, DocumentUploader
  mount_uploader :document_front, DocumentUploader
  mount_uploader :document_back, DocumentUploader
  mount_uploader :avatar, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :first_name, :last_name, :username, presence: true
  validates :username, uniqueness: true
  # validates :pin, presence: true, if: :pin?
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
  has_many :withdrawl_requests, dependent: :destroy
  has_many :activate_user_packages, dependent: :destroy
  has_one :kyc_alert
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
  monetize :cash_wallet_amount_cents
  monetize :charge_package_price_cents
  monetize :weekly_roi_to_cash_amount_cents
  monetize :binary_bonus_for_xfactor_cents
  monetize :minus_x_factor_binary_cents
  # after_create { |usr| UserMailer.welcome(usr).deliver_now }
  after_create do |usr|
    usr.created_by.present? && usr.created_by.log_histories.create(logable: self, log_type: :direct_refarral, message: "Direct Referral username #{ usr.username } at position #{ usr.parent_position }")
  end
  # Picture Validations
  # todo: to make it robust and precise
  # validate :picture_size_validation, :if => "document?"
  # validate :document_back_size_validation, :if => "document_back?"
  # validate :document_front_size_validation, :if => "document_front?"
  # def picture_size_validation
  #   errors[:document] << "should be less than 1MB" if document.size > 1.megabytes
  # end
  # def document_back_size_validation
  #   errors[:document_back] << "should be less than 1MB" if document_back.size > 1.megabytes
  # end
  # def document_front_size_validation
  #   errors[:document_front] << "should be less than 1MB" if document_front.size > 1.megabytes
  # end
  attr_encrypted :pin, key: Rails.application.secrets.secret_key,
    allow_empty_value: true, salt: Rails.application.secrets.secret_salt
  attr_accessor :select_package_id
  def select_package_id=(pckg_id)
    @select_package_id, self.is_pin = pckg_id, false
    self.package_id = pckg_id
  end
  def current_pin_verify
    (current_pin.to_s != pin_was.to_s) && errors.add(:current_pin, "invalid pin") || true
  end
  def get_reffered_by(username)
    user = User.find_by(username: username)
    self.referred_by = user
    self
  end
  def current_pin?
    !current_pin.nil?
  end
  def full_name
    [first_name, last_name].join(" ")
  end
  def name_or_id
    username
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
  def reload_adapters
    @adapter = false; self
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
