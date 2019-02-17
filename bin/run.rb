require_relative "../config/environment"

all_products = [Product.new(1, 'Apple', 12),
                Product.new(2, 'Carrot', 23),
                Product.new(3, 'Pineapple', 44),
                Product.new(4, 'Twix', 329),
                Product.new(5, 'Banana', 21)]


coins = [2, 1, 1, 1, 1, 10, 2, 20, 200]
all_coins = []
coins.each do |c|
  all_coins << Coin.new(c)
end

vending_machine = VendingMachine.new(all_products, all_coins)
