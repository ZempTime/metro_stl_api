require "csv"

namespace :data do
  desc "import data from files to database"
  task :import => :environment do

    puts "clearing current data"
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:schema:load'].invoke

    puts "importing calendar"
    filename = 'lib/import/v1/calendar.txt'
    routes = SmarterCSV.process(filename, {:key_mapping => {}}) do |array|
      Calendar.create(array.first)
    end

    puts "importing calendar_dates"
    filename = 'lib/import/v1/calendar_dates.txt'
    routes = SmarterCSV.process(filename, {:key_mapping => {}}) do |array|
        CalendarDate.create(array.first)
    end

    puts "importing routes"
    filename = 'lib/import/v1/routes.txt'
    routes = SmarterCSV.process(filename, {:key_mapping => {:route_text_color => nil}}) do |array|
      Route.create(array.first)
    end

    puts "importing trips"
    filename = 'lib/import/v1/trips.txt'
    routes = SmarterCSV.process(filename, {:chunk_size => 100, :key_mapping => {}}) do |chunk|
      Trip.create(chunk)
    end

    puts "importing stops"
    filename = 'lib/import/v1/stops.txt'
    routes = SmarterCSV.process(filename, {:key_mapping => {:stop_code => nil}}) do |array|
      Stop.create(array.first)
    end

    puts "importing stop_times"
    my_sql = <<-END
      load data local infile '/Users/chris/code/metro_stl_api/lib/import/v1/stop_times.txt' 
      into table stop_times character set utf8 fields terminated by ',' enclosed by '"' lines 
      terminated by '\r\n' (trip_id, arrival_time, departure_time, stop_id, stop_sequence, 
                                    stop_headsign, pickup_type, drop_off_type, shape_dist_traveled);
      END

   ActiveRecord::Base.connection.execute(my_sql)

   puts "cleaning up data"

   StopTime.first.delete
   Route.where.not(:route_type => "2").delete_all
   routes = Route.pluck(:route_id)
   Trip.where.not(:route_id => routes).delete_all
   trips = Trip.pluck(:trip_id)
   StopTime.where.not(:trip_id => trips).delete_all
   stops = StopTime.pluck(:stop_id)
   Stop.where.not(:stop_id => stops).delete_all

   puts "calculating time_difference for stop_times"

   StopTime.all.each do |st|
     puts st.id
     st.calc_time_difference
   end

   puts "done importing"

  end
end
