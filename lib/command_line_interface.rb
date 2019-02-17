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

  def intro
    options = { '1' => ' Choose a snack', '2' => ' View cash', 'X' => ' To Exit' }
    puts 'Welcome to Snacker'
    puts '---------------------------'
    options.each do |k, v|
      puts Rainbow(k).black.underline.bg(:yellow) + " #{v}"
    end
  end
end
