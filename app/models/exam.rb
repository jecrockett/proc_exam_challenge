class Exam < ApplicationRecord
  belongs_to :college
  has_many :exam_windows

  validates :name, presence: true
end
