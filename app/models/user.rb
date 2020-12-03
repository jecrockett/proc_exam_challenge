class User < ApplicationRecord
  has_many :exam_sessions
  has_many :exams, through: :exam_sessions

  validates :last_name, presence: true
  validates :phone_number,
    presence: true,
    phone: { possible: true },
    uniqueness: { scope: [:last_name, :first_name] }

  before_save :format_phone

  private

  def format_phone
    self.phone_number = Phonelib.parse(phone_number).full_e164.presence
  end
end
