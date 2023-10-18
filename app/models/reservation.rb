class Reservation < ApplicationRecord
  belongs_to :schedule
  belongs_to :sheet

  # カスタムのメールアドレスの正規表現
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true, format: { with: EMAIL_REGEX }
  validates :name, presence: true
  validates :sheet_id, uniqueness: { scope: :schedule_id, message: "is already reserved for this schedule" }
end
