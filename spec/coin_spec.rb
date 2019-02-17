require 'yaml'
require_relative 'spec_helper'
require_relative '../lib/coin'

describe Coin do
  describe 'value ' do
    it 'returns the value of the Coin' do
      @coin = Coin.new(10)
      @coin.value.should eql 10
    end
  end

  describe 'DENOMINATIONS ' do
    it 'does not create coins that are not accepted DENOMINATIONS' do
      expect { Coin.new(12) }.to raise_error(RuntimeError)
    end
  end
end
