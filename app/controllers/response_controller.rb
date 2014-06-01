class ResponseController < ApplicationController

  def index
    render json: ["MetroSTL API for 'Make the Train'"]
  end

  def v1_calculate
    @stop1 = find_station(params[:stop1])
    @stop2 = find_station(params[:stop2])
    @delay = params[:delay].to_i

    @result = StopTime.find_next_departure(@stop1, @stop2, @delay)

    render json: [@result]
  end

  private

  def find_station(stop_name)
    Stop.where(:stop_name => stop_name.upcase + " METROLINK STATION").first
  end

end


# Before Scoping:
# >> Benchmark.realtime { StopTime.find_next_departure(@stop1, @stop2, @delay) }
# => 0.882647

# After Scoping:
