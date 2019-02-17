class Coin
  attr_reader :value

  DENOMINATIONS = [1, 2, 5, 10, 20, 50, 100, 200].freeze

  def initialize(value)
    @value = value
    raise 'Value is invalid' unless DENOMINATIONS.include?(@value)
  end
end
