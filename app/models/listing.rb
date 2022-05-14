class Listing < ActiveRecord::Base
  validates :address, presence: true
  validates :listing_type, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :neighborhood, presence: true

  after_create :host_has_listings
  after_destroy :host_has_no_listings

  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations
  
  def host_has_listings
    self.host.update(host: true)
  end

  def host_has_no_listings
    self.host.update(host: false) if self.host.listings.empty?
  end

  def average_review_rating
    reviews.average("rating")
  end
end