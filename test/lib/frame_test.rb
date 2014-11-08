require_relative '../test_helper'
require_relative '../../lib/frame.rb'
require_relative '../../lib/snake.rb'

describe Frame do
  describe 'display' do

    def expected_display
      [
        # 0123456
        'xxxxxxx', # 0
        'x     x', # 1
        'x x   x', # 2
        'x x   x', # 3
        'x     x', # 4
        'x   x x', # 5
        'xxxxxxx'  # 6
      ]
    end

    it 'build a display' do
      border = OpenStruct.new(max_long: 6, max_lat: 6)
      snake = Snake.new(state: [[2,2],[2,3]], direction: :south)
      rodent_location = [4,5]
      frame = Frame.new(
        snake: snake,
        border: border,
        rodent_location: rodent_location )
      frame.build_display
      assert_equal expected_display, frame.display
    end

  end
end
