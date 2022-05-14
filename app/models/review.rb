class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"

  validates :rating, presence: true
  validates :description, presence: true
  validate :check


  def check 
    unless reservation && reservation.status == "accepted" && reservation.checkout.past?
      errors.add(:reservation, "Blah")
    end
  end
end
