class Route
  def initialize(first_s, last_s)
    @stations = [first_s, last_s]
    puts "First station - #{first_s}, and Last station is - #{last_s}"
  end

  def stations
    @stations.each do |station|
      puts "Station - #{station}"
      
    end
    puts @stations
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end
end

route = Route.new('almaty', 'astana')

route.add_station('karaganda')

route.stations