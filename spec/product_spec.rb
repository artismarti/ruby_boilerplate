require 'yaml'
require_relative 'spec_helper'
require_relative '../lib/product'

describe Product do
  before(:each) do
    @product = Product.new(1, 'Apple', 12)
  end

  describe 'code ' do
    it 'returns the name of the Product' do
      @product.code.should eql 1
    end
  end

  describe 'name ' do
    it 'returns the name of the Product' do
      @product.name.should eql 'Apple'
    end
  end

  describe 'price ' do
    it 'returns the price of the Product' do
      @product.price.should eql 12
    end
  end
end
