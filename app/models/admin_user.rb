class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable,
    :rememberable, :trackable, :validatable

  has_many :user_pair_keys, dependent: :destroy
  monetize :balance_cents
  def self.deduct_amount(amount)
    first.update(balance: first.balance.to_f - amount.try(:to_f))
  end
  def self.add_amount(amount)
    first.update(balance: first.balance.to_f + amount.try(:to_f))
  end
  def bit_pay
    @bit_pay ||= BitPayAdminUserAdapter.new(self)
  end
end
