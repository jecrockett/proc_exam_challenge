class User < ApplicationRecord
  before_save :format_phone

  validates :last_name, presence: true
  validates :phone_number, presence: true, uniqueness: true, phone: { possible: true }

  private

  def format_phone
    self.phone_number = Phonelib.parse(phone_number).full_e164.presence
  end
end
