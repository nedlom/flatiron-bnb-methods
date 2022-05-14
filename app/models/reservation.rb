class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  validates :checkin, presence: true
  validates :checkout, presence: true
  validate :guest_not_host

  def duration
    (checkout - checkin).to_i
  end

  def total_price
    (listing.price * duration).to_i
  end

  private

  def guest_not_host
    if guest == listing.host
      errors.add(:guest, "Can't book own apartment")
    end
  end

end
