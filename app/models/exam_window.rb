class ExamWindow < ApplicationRecord
  belongs_to :exam

  validates :start_time, presence: true
end
