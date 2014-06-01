# == Schema Information
#
# Table name: trips
#
#  block_id      :string(255)
#  route_id      :integer
#  direction_id  :integer
#  trip_headsign :string(255)
#  shape_id      :integer
#  service_id    :string(255)
#  id            :integer          not null, primary key
#

class Trip < ActiveRecord::Base
  belongs_to :route
  has_many :stop_times
  has_many :stops, through: :stop_times

  self.primary_key = :trip_id

  def self.going_direction(direction)
    where(:direction_id => direction)
  end
end

