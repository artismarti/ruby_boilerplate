class VendingMachine
  attr_accessor :products, :coins

  def initialize(products = [], coins = [])
    @coins = coins
    @products = products
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
      @products.delete(product)
      puts "Enjoy your #{product}"
      1
    else
      puts "Sorry the #{product} is no longer available."
      0
    end
  end

  # see how much cash is left in the machine
  def current_coin_total
    @coins.map(&:value).reduce { |sum, num| sum += num }
  end
end
