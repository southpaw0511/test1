class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train_name)
    @trains << train_name
  end

  def delete_train(train_name)
    @trains.delete(train_name)
  end

  def all_trains
    @trains.each do |train|
      puts "Name: #{train}"
    end
  end

  def list_train_type(type)
    @trains.select do |train|
      train.type == type
    end
  end

  def push_train(train_name)
    if @trains.include?(train_name)
      puts "Push train - #{train_name} to Next station"
    end
    delete_train(train_name)
  end
end

