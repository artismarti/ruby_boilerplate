# require_all '../lib'
require 'yaml'
require_relative 'spec_helper'
require_relative '../lib/vending_machine'

describe VendingMachine do
  before :each do
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
    @vending_machine = VendingMachine.new(all_products, all_coins)
  end

  describe 'current_coin_total ' do
    it 'returns the total amount of money in the Machine' do
      @vending_machine.current_coin_total.should eql 238
    end
  end

  describe 'check_for_product' do
    it 'returns 0 if Product is not available' do
      @vending_machine.check_for_product('Mangoes').should eql 0
    end
  end

  describe 'check_for_product' do
    it 'returns 1 if Product is not available' do
      @vending_machine.check_for_product('Twix').should eql 1
    end
  end
end
