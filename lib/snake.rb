require 'ostruct'

class Snake
  class DirectionError < StandardError; end
  class CoruptState < StandardError; end

  DIRECTIONS = %i(north south west east).freeze

  attr_reader :direction, :state, :border, :rodent_location

  def initialize(args)
    @state       = args.fetch(:state)
    @direction ||= args.fetch(:direction)
    @border    ||= args.fetch(:border, default_border)
    @rodent_location = args.fetch(:rodent_location)
    validate_args
  end

  def next_snake
    new_state = state.dup
    if trying_reverse_move?
      new_state.reverse
    else
      new_state.shift unless will_eat_rodent?
      new_state << next_head
      new_state
    end
  end

  def alive?
    !(self_crash? || wall_crash?)
  end

  def will_eat_rodent?
    next_head == rodent_location
  end

  private

  def wall_crash?
    # check if it crashed in any of the walls
    [0, border.max_lat].include?(next_head.first) ||
      [0, border.max_long].include?(next_head.last)
  end

  def self_crash?
    (state - [state[-2]]).include?(next_head)
  end

  def head
    state.last
  end

  def next_head
    @next_head ||= [head.first + lat, head.last + long]
  end

  def lat
    return -1 if direction == :west
    return 1 if direction == :east
    0
  end

  def long
    return 1 if direction == :south
    return -1 if direction == :north
    0
  end

  def validate_args
    raise DirectionError unless DIRECTIONS.include?(direction)
    # raise CoruptState if corupt?(state)
  end

  # def corupt?(state)
  # end
  
  def default_border
    OpenStruct.new(max_long: 20, max_lat: 30)
  end

  def trying_reverse_move?
    state[-2] == next_head
  end

end
