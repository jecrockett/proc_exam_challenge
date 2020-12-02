class College < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
