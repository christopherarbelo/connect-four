# frozen_string_literal: true

# Class for players
class Player
  attr_reader :name, :marker
  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end
