require 'ostruct'

class Frame

  attr_reader :snake_state, :border, :display, :rodent_location

  def initialize(args)
    @snake_state ||= args.fetch(:snake_state)
    @border = args.fetch(:border)
    @rodent_location = args.fetch(:rodent_location)
    @display = []
  end

  def build_display
    display << score_display
    display << lat_size_wall
    1.upto(max_long) do |long|
      display << line(long)
    end
    display << lat_size_wall
  end

  private

  def line(long)
    str  = 'x'
    1.upto(max_lat) do |lat|
      if snake_state.include?([lat,long]) || [lat,long] == rodent_location
        str << 'x'
      else
        str << ' '
      end
    end
    str << 'x'
  end

  def lat_size_wall
    0.upto(border.max_lat).map { |x| 'x' }.join
  end

  def max_long
    border.max_long - 1
  end

  def max_lat
    border.max_lat - 1
  end

  def score_display
    size = max_lat - score.size + 2
    size.times.map { ' ' }.join + score
  end

  def score
    "SCORE: " << ((snake_state.size - 3) * 10).to_s
  end

end
