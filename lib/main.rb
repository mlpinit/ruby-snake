require_relative 'snake'
require_relative 'frame'
require_relative 'rodent'
require 'timeout'
require 'ostruct'
require 'io/console'

Directions = { "\e[A" => :north, "\e[B" => :south,
               "\e[C" => :east, "\e[D" => :west }.freeze

def read_key
  STDIN.echo = false
  STDIN.raw!
  input = STDIN.getc.chr
  input << STDIN.read_nonblock(2) if input == "\e"
  input
rescue
  puts "Can't press that ta na na na na!"

ensure
  STDIN.echo = true
  STDIN.cooked!
end

def start_game
  border = OpenStruct.new(max_long: 20, max_lat: 30)
  state = [
    [14,9],
    [15,9],
    [16,9]]

  direction = :east

  rodent = Rodent.new(snake_state: state, border: border)
  rodent_location = rodent.location

  snake = Snake.new(
    state: state,
    border: border,
    direction: direction,
    rodent_location: rodent_location)

  while snake.alive? do
    previous_snake = snake
    snake = Snake.new(
      state:            snake.next_snake,
      direction:        direction,
      border:           border,
      rodent_location:  rodent_location )

    frame = Frame.new(
      snake_state:      snake.state,
      border:           border,
      rodent_location:  rodent_location )
    frame.build_display
    puts ' '
    frame.display.each { |line| puts line }

    if previous_snake.will_eat_rodent?
      rodent_location = Rodent.new(
        snake_state:  previous_snake.next_snake,
        border:       border).location
    end

    begin
      Timeout::timeout(0.3) do
        direction = Directions[read_key]
        sleep 0.2
      end
    rescue Timeout::Error
    end

    direction = snake.direction unless direction
    system('clear')
  end
end

def play
  action = 'play'
  while action != 'q' do
    start_game
    # or You Won if all spaces filled
    puts ''
    puts "GAME OVER"
    puts ''
    puts "Press q to quit or any key to restart"
    action = read_key
  end
end

play
