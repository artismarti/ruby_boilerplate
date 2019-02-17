class VendingMachine
  attr_accessor :products, :coins

  def initialize(products = [], coins = [])
    @coins = coins
    @products = products
  end

  # see how much cash is left in the machine
  def current_coin_total
    @coins.map(&:value).reduce { |sum, num| sum += num }
  end
end
