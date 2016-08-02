class Coupon < ActiveRecord::Base
  has_many :charges
  validates_presence_of :code
  validates_uniqueness_of :code

  def self.get(code)
    where(code: normalize_code(code)).
    where('expires_at > ? OR expires_at IS NULL', Time.now).
    take
  end

  def apply_percentage_discount(amount)
    discount = amount * (self.discount_percent * 0.01)
    (amount - discount.to_i)
  end

  def apply_amount_discount(amount)
    amount - self.discount_amount
  end

  def discount_percent_human
    if discount_percent.present?
      discount_percent.to_s + '%'
    end
  end

  private

  def self.normalize_code(code)
    code.gsub(/ +/, '').upcase
  end
end
