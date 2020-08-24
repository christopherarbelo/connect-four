# frozen_string_literal: true

require_relative 'slot'

# Connect Four class
class ConnectFour
  attr_reader :height, :width, :slots, :current
  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
    @current = nil
    @height = 6
    @width = 7
    @slots = Array.new(width) { Slot.new(height) }
  end

  def play
    show_grid
    loop do
      @current = @current == @player_one ? @player_two : @player_one
      slot = ask_slot
      slots[slot] << current.marker
      show_grid
      return "#{current.name} wins" if four_in_a_row?
      return 'TIE!' if tie?
    end
  end

  def tie?
    slots.all?(&:full?)
  end

  def ask_slot
    loop do
      print "#{current.name}(#{current.marker}) enter an available slot:  "
      input = gets.chomp.to_i
      return input if available?(input)
    end
  end

  def available?(slot_index)
    slot_index >= 0 && !slots[slot_index].nil? && !slots[slot_index].full?
  end

  def four_in_a_row?
    by_row? || by_column? || by_diagonial?
  end

  def by_diagonial?
    width.times do |x|
      height.times { |y| return true if check_diagonial_row({ x: x, y: y }, { x: +1, y: +1 }) }
    end
    width.downto(0) do |x|
      height.times { |y| return true if check_diagonial_row({ x: x, y: y }, { x: -1, y: +1 }) }
    end
    false
  end

  def check_diagonial_row(coordinates, moves)
    row = []
    until out_of_bounds?(coordinates)
      row << slots[coordinates[:x]].cells[coordinates[:y]]
      coordinates[:x] += moves[:x]
      coordinates[:y] += moves[:y]
    end
    match?(row)
  end

  def out_of_bounds?(coordinates)
    coordinates[:x] >= width or coordinates[:y] >= height
  end

  def by_column?
    slots.each do |slot|
      return true if match?(slot.cells)
    end
    false
  end

  def by_row?
    height.times do |i|
      row = []
      slots.each { |slot| row << slot.cells[i] }
      return true if match?(row)
    end
    false
  end

  def match?(array)
    current = array.first
    count = 0
    array.each do |cell|
      count += 1 if cell == current
      count = 1 and current = cell if cell != current
      return true if count >= 4 && !current.nil?
    end
    false
  end

  def show_grid
    all_cells = slots.reduce([]) { |array, slot| array << slot.cells.reverse }.transpose
    index = height
    output = all_cells.reduce('') do |string, row|
      index -= 1
      string + "#{index} #{row.map { |marker| "[#{marker || ' '}]" }.join}\n"
    end
    puts output += '   0  1  2  3  4  5  6'
    output
  end
end
