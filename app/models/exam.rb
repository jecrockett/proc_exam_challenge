class Exam < ApplicationRecord
  belongs_to :college

  validates :name, presence: true
end
