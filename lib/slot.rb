# frozen_string_literal: true

# Slot class for the overall grid
class Slot
  attr_reader :height, :cells
  def initialize(height = 6)
    @height = height
    @cells = Array.new(height) { nil }
  end

  def <<(item)
    @cells[cells.find_index(nil)] = item and @cells unless full?
  end

  def empty
    @cells = Array.new(height) { nil }
  end

  def full?
    cells.none?(&:nil?)
  end
end
