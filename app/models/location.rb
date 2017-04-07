class Location < ActiveRecord::Base
  validates_presence_of :name
  belongs_to :user
  belongs_to :scheme

  geocoded_by :address        # can also be an IP address
  after_validation :geocode   # auto-fetch coordinates

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode  # auto-fetch address

  def as_json(opts={})
    {
      :id => self.id,
      :item_string => self.address,
      :class_name => self.class.name
    }
  end
end
