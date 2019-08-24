class Place < ApplicationRecord
  validates_presence_of :name, :google_id, :address, :coordinate, :price
  scope :all_by_access_level, -> (access_level){ where( access_level: [0..access_level] )}

  has_many :claims
end
