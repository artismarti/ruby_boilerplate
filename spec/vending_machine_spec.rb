# require_all '../lib'
require 'yaml'
require_relative 'spec_helper'
require_relative '../lib/vending_machine'

describe VendingMachine do
  before :each do
    @all_products = [Product.new(1, 'Apple', 12),
                    Product.new(2, 'Carrot', 23),
                    Product.new(3, 'Pineapple', 44),
                    Product.new(4, 'Twix', 329),
                    Product.new(5, 'Banana', 21)]
    coins = [2, 1, 1, 1, 1, 10, 2, 20, 200]
    @all_coins = []
    coins.each do |c|
      @all_coins << Coin.new(c)
    end
    @vending_machine = VendingMachine.new(@all_products, @all_coins)
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

  describe 'reload_machine' do
    it 'reloads machine with more products & coins' do
      prev_coin_count = @vending_machine.coins.count
      prev_product_count = @vending_machine.products.count
      @vending_machine.reload_machine(@all_products, @all_coins)
      @vending_machine.coins.count.should eql prev_coin_count + @all_coins.count
      @vending_machine.products.count.should eql prev_product_count + @all_products.count

    end
  end

  describe 'accept_coins' do
    coins_hash = {:valid=>{:coins=>{10=>2, 2=>3, 50=>2, 100=>1}, :total_value=>226}, :invalid=>{3=>2, 49=>1, 9=>1}}
    it 'accepts all valid coins' do
      prev_coin_count = @vending_machine.coins.count
      @vending_machine.accept_coins(coins_hash)
      @vending_machine.coins.count.should eql prev_coin_count + 8
    end
  end

  describe 'dispense_product' do
    it 'dispenses the product' do
      prev_product_count = @vending_machine.products.count
      @vending_machine.dispense_product('Apple')
      @vending_machine.products.count.should eql prev_product_count - 1
    end
  end

  describe 'paid_amount_sufficient?' do
    it 'should return the correct amount due for insufficient payment' do
      coins_hash = {:valid=>{:coins=>{10=>2, 2=>3, 50=>2, 100=>1}, :total_value=>226}, :invalid=>{3=>2, 49=>1, 9=>1}}
      @vending_machine.paid_amount_sufficient?('Twix', coins_hash).should eql 103
    end
  end

  describe 'dispense_change' do
    it 'should dispense the right change' do
      @vending_machine.dispense_change(11, 'Apple').should eql [10, 1]
    end
  end

  describe 'show right coins held' do
    it 'show right coins held' do
      @vending_machine.coins.map{|c| c.value}. should eql [2, 1, 1, 1, 1, 10, 2, 20, 200]
    end
  end
end
