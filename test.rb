require 'pry'
time = 5
car_positions = [1, 1, 1]

def move_cars(car_positions, time)
  { cars: car_positions.map { |pos| 
                            if Random.rand > 0.3
                              pos += 1
                            else
                              pos
                            end },
    time: time - 1}
end

def output_car car_position
  puts '-' * car_position
end

def run_step_of_race state
  move_cars(state[:cars], state[:time])
end

def draw car_positions
  car_positions.each { |c| output_car c }
end

def race car_positions, time
  draw car_positions
  state = move_cars car_positions, time
  if state[:time] >= 0
    res = run_step_of_race(state)
    race(res[:cars], res[:time])
  end
end

race car_positions, time
