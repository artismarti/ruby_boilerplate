require 'rainbow'
require 'artii'

class CommandLineInterface
  def initialize(vending_machine)
    @machine = vending_machine
  end

  def greet
    hello = Artii::Base.new font: 'slant'
    puts hello.asciify('Eat Something')
  end

end
