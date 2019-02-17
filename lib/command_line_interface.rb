require 'rainbow'
require 'artii'

class CommandLineInterface
  def initialize(vending_machine)
    @machine = vending_machine
  end

  def run
    system('clear')
    greet
    intro
    menu_setting
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

  # CLI menu
  def menu_setting
    input = ' '
    while input
      input = gets.chomp.capitalize
      case input
      when '1'
        puts Rainbow(' > ').black.underline.bg(:yellow) + 'Snack List:'
        puts @machine.list_products
        select_product
      when '2'
        puts Rainbow(' > ').black.underline.bg(:yellow) + 'Cash Available:'
        puts @machine.current_coin_total
      when 'C'
        system('clear')
        intro
      when 'X'
        goodbye = Artii::Base.new font: 'slant'
        puts goodbye.asciify('Bye!')
        break
      else
        puts 'These are not the snacks you are looking for. Please input the name of the snack'
      end
      system('clear')
    end
  end


  # Accept user choice for product
  def select_product
    puts Rainbow(' > ').black.underline.bg(:yellow) + 'Type your choice:'
    choice = ''
    while choice
      choice = gets.chomp
      @machine.check_for_product(choice) == 1 ? buy_product(choice) : [intro, menu_setting]
    end
  end

end
