# == Schema Information
#
# Table name: calendars
#
#  service_id :string(255)
#  start_date :integer
#  end_date   :integer
#  monday     :boolean
#  tuesday    :boolean
#  wednesday  :boolean
#  thursday   :boolean
#  friday     :boolean
#  saturday   :boolean
#  sunday     :boolean
#

class Calendar < ActiveRecord::Base
  
end

