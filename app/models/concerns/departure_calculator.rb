module DepartureCalculator
  extend ActiveSupport::Concern

  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
      include LineConstants
    end
  end

  module ClassMethods
    def find_next_departure(stop1, stop2, delay)
      direction = self.calculate_direction(stop1, stop2)
      self.calculate_time(stop1, direction, delay)
    end

    def calculate_direction(stop1, stop2)
      if determine_line_portion(stop1) == determine_line_portion(stop2)
        line_string = determine_line_portion(stop1)
        line = line_string.upcase.to_s

        if line.index(stop1.stop_name) > line.index(stop2.stop_name) 
          LineConstants::EASTBOUND
          else
          LineConstants::WESTBOUND
        end

      elsif determine_line_portion(stop1) == "purple_line"
        case
        when determine_line_portion(stop2) == "red_line_west"
          LineConstants::WESTBOUND
        when determine_line_portion(stop2) == "blue_line_west"
          LineConstants::WESTBOUND
        when determine_line_portion(stop2) == "red_line_east"
          LineConstants::EASTBOUND
        end
      else
        case
        when determine_line_portion(stop1) == "red_line_west"
          LineConstants::EASTBOUND
        when determine_line_portion(stop1) == "blue_line_west"
          LineConstants::EASTBOUND
        when determine_line_portion(stop1) == "red_line_east"
          LineConstants::WESTBOUND
        end
      end
    end

    def determine_line_portion(stop)
      if LineConstants::BLUE_LINE_WEST.include?(stop.stop_name)
        "blue_line_west"
      elsif LineConstants::RED_LINE_WEST.include?(stop.stop_name)
        "red_line_west"
      elsif LineConstants::RED_LINE_EAST.include?(stop.stop_name)
        "red_line_east"
      elsif LineConstants::PURPLE_LINE.include?(stop.stop_name)
        "purple_line"
      end
    end

    def calculate_time(stop1, direction, delay)
      @trips = stop1.trips.where(:direction_id => direction)
      day_name = Time.now.strftime('%A').downcase

      @stop_times = stop1.stop_times.order(time_difference: :asc)

      calendar_dates = Calendar.all.select do |c|
        c.send(day_name.to_sym)
      end

      service_ids = []

      calendar_dates.each do |cd|
        service_ids << cd.service_id
      end

      @stop_times = @stop_times.select do |st| 
        service_ids.include?(st.trip.service_id)
      end

      seconds = current_time_difference(delay)

      @stop_times = @stop_times.reject { |st| st.time_difference < seconds }

      stop = @stop_times.first

      return "no stops" unless stop

      (stop.time_difference - Time.now.seconds_since_midnight).to_i
    end

    def current_time_difference(delay)
      time = (Time.now + delay.minutes)
      time.seconds_since_midnight
    end
  end #ClassMethods
end 
