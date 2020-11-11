class Interface

  def initialize
    @trains = []
    @routes = []
    @stations = []
  end

  def start
    loop do
      puts '0. Create the station'
      puts '1. Create the train'
      puts '2. Create Route'
      puts '3. Control Route'
      puts '4. Add a route for Train'
      puts '5. Add a wagon to Train'
      puts '6. Delete wagon from the Train'
      puts '7. Control Train'
      puts '8. List stations'
      puts '9. List Trains on Stations'
      puts '10. Exit'
      puts 'Select: '

      input = gets.chomp.to_i

      case input
      when 0
        create_station
      when 1
        create_train
      when 2
        create_route
      when 3
        control_route
      when 4
        add_route_to_train
      when 5
        add_wagon_to_train
      when 6
        delete_wagon_from_train
      when 7
        control_train
      when 8
        list_stations
      when 9
        show_station_trains
      when 10
        break
      else 
        puts 'Wrong!'
      end

      private

      def create_station
          puts 'Write the station name: '
          name = gets.chomp
          @stations << Station.new(name)
      end
      def create_train
          puts 'Is this a Cargo? yes/no '
          name = gets.chomp
          puts 'Write the number of train: '
          number = gets.to_i
          if name == 'yes'
            @trains << CargoTrain.new(number)
          else
            @trains << PassengerTrain.new(number)
          end
      end
      def create_route
          num = 1
          @stations.each do |station|
            puts "#{num} - #{station.name}"
            num += 1 
          end
          puts 'Enter the first station: '
          first = gets.to_i
          puts 'Enter the last station: '
          last = gets.to_i
          route = Route.new(@stations[first], @stations[last])
          @route = route
          puts "Route created #{route.name}"
      end
      def control_route
          puts 'Which route do you want to control: '
          show_routes
          route = @route[gets.to_i - 1]
          puts "Выбран маршрут #{route.name}"
          puts "1. Добавить станцию\n2. Удалить станцию"
          answer = gets.chomp
          if answer ==  '1'
            puts 'Which station do you want added to Route?'
            route.station_list
            route.add_station(@stations[gets.to_i - 1])
            puts 'Station added'
          elsif answer == '2'
            puts 'Which station do you want to delete from Route?'
            route.station_list
            route.delete_station(route.stations[gets.to_i - 1])
            puts 'Station deleted'
          end
      end
      def add_route_to_train
        train = select_train

        puts 'Select route'
        show_routes
        train.set_route(@routes[gets.to_i - 1])
        puts "Route to train #{train.number} successfully specified"
      end
      def add_wagon_to_train
          train = select_train

          puts 'How many wagons do you want to add: '
          num = gets.to_i
          if train.class == PassengerTrain
            num.times do
              train.add_wagons(PassengerWagon.new)
            end
          else
            num.times do
              train.add_wagons(CargoWagon.new)
            end
          end
          puts "To train #{train.number} has been added #{quantity} wagons"
      end
      def delete_wagon_from_train
          train = select_train

          puts 'How many wagons do you want to delete: '
          num = gets.to_i
          num.times do
            train.delete_wagons
          end
          puts "From train #{train.number} has been deleted #{quantity} wagons"
      end
      def control_train
          train = select_train

          puts "Move train #{train.number} To station:\n1. Next\n2. Previous"
          case gets.chomp
          when '1'
            train.move_forward
          when '2'
            train.move_back
          end
          puts "Train on station:  #{train.current_station.name}"
      end
      def list_stations
        @stations.each.with_index(1) do |station, i|
          puts "#{i}. #{station.name} | Trains #{station.trains.size}"
        end
      end
      def show_station_trains
        puts 'Select station'
        list_stations
        station = @stations[gets.to_i - 1]
        station.all_trains
      end
      def show_routes
        @routes.each.with_index(1) do |route, i|
          puts "#{i}. #{route.name}"
        end
      end
      def select_train
        puts 'Select train'
        trains
        train = @trains[gets.to_i - 1]
      end
      def trains
        @trains.each.with_index(1) do  |train, i|
          puts "#{i}. #{train.number} | Number of wagons in the train:  #{train.wagons.size} | class #{train.class}"
        end
      end
    end
  end
end