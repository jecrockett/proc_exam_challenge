class ExamSession < ApplicationRecord
  belongs_to :exam
  belongs_to :user

  validates :start_time, presence: true
  validate :start_time_is_within_an_exam_window?

  private

  def start_time_is_within_an_exam_window?
    windows = exam&.exam_windows || []
    ranges = windows.map { |window| window.start_time..window.end_time }

    if ranges.none? { |range| range.cover? start_time }
      errors.add(:start_time, "is not a valid time to take this exam")
    end
  end
end
