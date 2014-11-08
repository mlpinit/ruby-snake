class Rodent

  attr_reader :border, :snake_state

  def initialize(args)
    @snake_state ||= args.fetch(:snake_state)
    @border      ||= args.fetch(:border)
  end

  def location
    loc = [rand(1..max_lat), rand(1..max_long)]
    if !snake_state.include?(loc)
      loc
    else
      location
    end
  end

  private

  def max_lat
    border.max_lat - 1 
  end

  def max_long
    border.max_long - 1
  end

end
