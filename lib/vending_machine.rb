require 'pry'

class VendingMachine
  attr_accessor :products, :coins

  def initialize(products = [], coins = [])
    @coins = coins
    @products = products
  end

  # show product list to user
  def list_products
    @products.map { |p| "#{p.name} costs £#{p.price / 100.round(2)}" }
  end

  # check for stock and return price
  def check_for_product(product)
    if @products.map(&:name).include?(product.capitalize)
      price = @products.select { |p| p.name == product.capitalize }.map(&:price)[0]
      puts "Please pay #{price} pennies for the #{product.upcase}"
      1
    else
      puts 'Product is unavailable'
      0
    end
  end

  # Create a hash with valid and invalid coins.
  # TBD Refactor
  def inspect_input_coins(coins, valid_denominations)
    return_hash = {
      valid: {
        coins: {},
        total_value: 0
      },
      invalid: {}
    }
    coins.each do |coin|
      unless valid_denominations.include? coin
        if return_hash[:invalid].key? coin
          return_hash[:invalid][coin] += 1
        else
          return_hash[:invalid][coin] = 1
        end
        next
      end
      if return_hash[:valid][:coins].key? coin
        return_hash[:valid][:coins][coin] += 1
      else
        return_hash[:valid][:coins][coin] = 1
      end
    end
    return_hash[:valid][:coins].each do |k, v|
      return_hash[:valid][:total_value] += k.to_i * v.to_i
    end
    return_hash
  end

  # Accept all valid coins from user
  def accept_coins(coins_hash)
    coins_hash[:valid][:coins].each do |k, v|
      while v > 0
        @coins << Coin.new(k)
        v -= 1
      end
    end
  end

  # Dispense product to User
  def dispense_product(product)
    if @products.map(&:name).include?(product)
      @products.delete(@products.find{|p| p.name == product.capitalize})
      puts "Enjoy your #{product}"
      1
    else
      puts "Sorry the #{product} is no longer available."
      0
    end
  end

  # Return any change due to user
  # This greedy algorithm was taken from here: http://rubyquiz.com/quiz154.html
  def dispense_change(change_due, product)
    coins = @coins.map(&:value)
    change = coins.sort
                  .reverse
                  .map do |coin|
      number_of_coins = change_due / coin
      change_due %= coin
      Array.new(number_of_coins) { coin }
    end
    change.flatten.each do |ch|
      @coins.delete(@coins.find { |c| c.value == ch })
    end
    puts "Here are the coins due to you: #{change.flatten} pennies"
    dispense_product(product)
    change.flatten
  end

  # check if price paid is sufficient
  def paid_amount_sufficient?(product, coins_hash)
    expected_price = @products.select { |p| p.name == product.capitalize }.map(&:price)[0]
    change_due = coins_hash[:valid][:total_value] - expected_price
    if change_due > 0
      accept_coins(coins_hash)
      dispense_change(change_due, product)
    elsif change_due.zero?
      accept_coins(coins_hash)
      dispense_product(product)
    else
      return -change_due
    end
  end

  def reload_machine(products, coins)
    @products += products
    @coins += coins
  end

  # see how much cash is left in the machine
  def current_coin_total
    @coins.map(&:value).reduce { |sum, num| sum += num }
  end
end
