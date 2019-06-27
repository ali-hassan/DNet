class AddPinCapacity < ActiveRecord::Migration[5.1]
  def change
    add_monetize :users, :pin_capacity
  end
end
