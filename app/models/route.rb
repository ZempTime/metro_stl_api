# == Schema Information
#
# Table name: routes
#
#  route_long_name  :string(255)
#  id               :integer          not null, primary key
#  route_type       :integer
#  agency_id        :string(255)
#  route_color      :string(255)
#  route_short_name :string(255)
#

class Route < ActiveRecord::Base
  has_many :trips
  has_many :stops, through: :trips
  has_many :stop_times, through: :trips

  self.primary_key = :route_id
end
