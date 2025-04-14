class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :guests, presence: true
  validates :guests, numericality: { greater_than_or_equal_to: 1}
  validate :check_in_rule
  validate :after_check_in

  def stay_days
    return 0 unless check_in && check_out
    (check_out - check_in).to_i
  end

  def total_price
    return 0 unless check_in && check_out && room
    stay_days * guests * room.price
  end

  private

  def check_in_rule
    if check_in.present? && check_in < Date.current
      errors.add(:check_in, "は今日以降の日付を設定してください。")
    end
  end


  def after_check_in
    if check_in && check_out && check_out <= check_in
      errors.add(:check_out, "はチェックイン日より前の日付は指定できません。")
    end
  end
end
