class Setting < ApplicationRecord
  class << self
    def find_value(k)
      find_by key: k
    end
  end
end
