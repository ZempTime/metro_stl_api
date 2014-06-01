# == Schema Information
#
# Table name: stop_times
#
#  trip_id             :integer
#  arrival_time        :text
#  departure_time      :text
#  stop_id             :integer
#  stop_sequence       :integer
#  stop_headsign       :string(255)
#  pickup_type         :string(255)
#  drop_off_type       :string(255)
#  shape_dist_traveled :string(255)
#  id                  :integer          not null, primary key
#  time_difference     :integer
#

class StopTime < ActiveRecord::Base
  include DepartureCalculator

  belongs_to :stop
  belongs_to :trip
  has_one :route, :through => :trip

  def calc_time_difference
    time = self.arrival_time.slice(0,5)
    hours,minutes = time.split(/:/).map(&:to_i)
    difference = hours * 3600 + minutes * 60
    difference + (60 * 60 * 24) if hours < 4
    self.time_difference = difference
    self.save!
  end


end

