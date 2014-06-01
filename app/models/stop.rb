# == Schema Information
#
# Table name: stops
#
#  stop_lat      :string(255)
#  zone_id       :string(255)
#  stop_lon      :string(255)
#  id            :integer          not null, primary key
#  stop_desc     :string(255)
#  stop_name     :string(255)
#  location_type :integer
#

class Stop < ActiveRecord::Base
  has_many :stop_times
  has_many :trips, through: :stop_times
  has_many :routes, through: :trips

  self.primary_key = :stop_id
end
