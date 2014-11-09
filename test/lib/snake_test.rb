require_relative '../test_helper'
require_relative '../../lib/snake.rb'

describe Snake do

  describe 'initialization' do
    it 'raises DirectionError if it doesn\'t recognize direction' do
      assert_raises Snake::DirectionError do
        Snake.new(
          state: [],
          direction: :unrecognized_direction,
          rodent_location: [5,5] )
      end
    end
  end

  describe 'rodent' do
    it 'is eatean' do
      state = [[1,1],[1,2]]
      snake = Snake.new(rodent_location: [1,3], state: state, direction: :south)
      assert_equal snake.send(:next_head), snake.rodent_location
      assert_equal 3, snake.next_snake.size
    end

    it 'is not eaten' do
      state = [[1,1],[1,2]]
      snake = Snake.new(rodent_location: [1,4], state: state, direction: :south)
      assert_equal 2, snake.next_snake.size
    end
  end

  describe 'direction' do
    describe 'can move' do
      it 'west' do
        state = [[1,1],[1,2]]
        snake = Snake.new(
          state: state,
          rodent_location: [5,5],
          direction: :west )
        assert_equal [[1,2],[0,2]], snake.next_snake,
          "Initial State: #{state.inspect}"
      end

      it 'east' do
        state = [[1,2],[2,2]]
        snake = Snake.new(
          state: state,
          rodent_location: [5,5],
          direction: :east )
        assert_equal [[2,2],[3,2]], snake.next_snake,
          "Initial State: #{state.inspect}"
      end

      it 'south' do
        state = [[1,2],[2,2]]
        snake = Snake.new(
          state: state,
          rodent_location: [5,5],
          direction: :south )
        assert_equal [[2,2],[2,3]], snake.next_snake,
          "Initial State: #{state.inspect}"
      end

      it 'north' do
        state = [[2,1],[3,1]]
        snake = Snake.new(
          state: state,
          rodent_location: [5,5],
          direction: :north )
        assert_equal [[3,1],[3,0]], snake.next_snake,
          "Initial State: #{state.inspect}"
      end
    end

    describe 'can reverse move' do
      it 'west' do
        state = [[1,1],[2,1]]
        snake = Snake.new(
          state: state,
          rodent_location: [5,5],
          direction: :west )
        assert snake.alive?
        assert snake.next_snake.last == [1,1]
      end

      it 'east' do
        state = [[2,1],[1,1]]
        snake = Snake.new(
          state: state,
          rodent_location: [5,5],
          direction: :east)
        assert snake.alive?
        assert snake.next_snake.last == [2,1]
      end

      it 'south' do
        state = [[2,1],[2,0]]
        snake = Snake.new(
          state: state,
          rodent_location: [5,5],
          direction: :south )
        assert snake.alive?
        assert snake.next_snake.last == [2,1]
      end

      it 'north' do
        state = [[1,1],[1,2]]
        snake = Snake.new(
          state: state,
          rodent_location: [5,5],
          direction: :north )
        assert snake.alive?
        assert snake.next_snake.last == [1,1]
      end
    end

    describe 'dies when it hits' do
      it 'top wall' do
        state = [[1,1],[2,1]]
        snake = Snake.new(
          state: state,
          rodent_location: [5,5],
          direction: :north )
        refute snake.alive?
      end

      it 'left wall' do
        state = [[1,1],[1,2]]
        snake = Snake.new(
          state: state,
          rodent_location: [5,5],
          direction: :west )
        refute snake.alive?
      end

      it 'itself' do
        state = [[1,1],[1,2],[1,3],[2,3],[2,2]]
        snake = Snake.new(
          state: state,
          rodent_location: [5,5],
          direction: :west )
        refute snake.alive?
      end

      def border
        OpenStruct.new(max_long: 20, max_lat: 30)        
      end

      it 'right wall' do
        state = [[29,18],[29,17]]
        snake = Snake.new(
          state: state,
          direction: :east,
          rodent_location: [5,5],
          border: border )
        refute snake.alive?
      end

      it 'bottom wall' do
        state = [[1,19],[2,19]]
        snake = Snake.new(
          state: state,
          direction: :south,
          rodent_location: [5,5],
          border: border )
        refute snake.alive?
      end
    end
  end

end
