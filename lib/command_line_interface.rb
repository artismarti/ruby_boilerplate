require 'rainbow'
require 'artii'
require 'pry'

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
      when 'X'
        goodbye = Artii::Base.new font: 'slant'
        puts goodbye.asciify('Bye!')
        exec("exit\n")
      else
        puts 'These are not the snacks you are looking for. Please input the snack name.'
      end
    end
  end

  # Accept user choice for product
  def select_product
    puts Rainbow(' > ').black.underline.bg(:yellow) + 'Type your choice:'
    choice = ''
    coins = false
    while choice
      choice = gets.chomp
      @machine.check_for_product(choice) == 1 ? buy_product(choice, coins) : [intro, menu_setting]
    end
  end

  # If user selects a product that is available, they can buy the product
  def buy_product(choice, coins)
    print Rainbow(' > ').black.underline.bg(:yellow) + 'Enter coin value in pennies (seperate by spaces):'
    puts '2 20 10'
    coins ||= gets.chomp.split.map(&:to_i)
    change_due = @machine.paid_amount_sufficient?(choice, @machine.inspect_input_coins(coins, @machine.coins[0].class::DENOMINATIONS))
    take_more_money(coins, change_due, choice) if change_due > 0
    puts 'Thanks for your purchase, snacker!'
    [intro, menu_setting]
  end

  def take_more_money(coins, change_due, choice)
    puts "Please pay #{change_due} pennies more:"
    more_coins = gets.chomp.split.map(&:to_i)
    coins << more_coins
    coins = coins.flatten
    change_due -=  more_coins.reduce(0) { |s, n| s += n }
    if change_due > 0
      take_more_money(coins, change_due, choice)
    else
      coins << more_coins
      coins = coins.flatten
      change_due = @machine.paid_amount_sufficient?(choice, @machine.inspect_input_coins(coins, @machine.coins[0].class::DENOMINATIONS))
      take_more_money(coins, change_due, choice) if change_due > 0
    end
  end
end
