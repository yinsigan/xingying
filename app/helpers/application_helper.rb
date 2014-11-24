module ApplicationHelper
  def generate_number
    ('0'..'9').to_a.shuffle[0..7].join
  end
  def generate_random(number)
    SecureRandom.hex(number)
  end

  def is_admin?(user)
    user.admin? || user.super_admin?
  end
end
