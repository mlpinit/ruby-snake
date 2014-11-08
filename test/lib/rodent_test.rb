require_relative '../test_helper'
require_relative '../../lib/rodent.rb'
require 'ostruct'

describe Rodent do

  describe 'initialized with' do
    it 'a snake state' do
      assert_raises KeyError do
        Rodent.new(border: [4,4])
      end
    end

    it 'a border' do
      assert_raises KeyError do
        Rodent.new(snake_state: [[1,2],[2,1]])
      end
    end
  end

  # The rodent moves revealing it's location in the process.
  it 'location' do
    snake_state = [[1,1],[1,2],[1,3]]
    border = OpenStruct.new(max_lat: 10, max_long: 6)
    rodent = Rodent.new(snake_state: snake_state, border: border)
    refute snake_state.include?(rodent.location)
  end

end
