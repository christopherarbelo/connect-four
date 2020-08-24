# frozen_string_literal: true

require './lib/connect_four'
require './lib/player'
require './lib/slot'

game = ConnectFour.new(Player.new('Chris', 'x'), Player.new('Ali', 'o'))
describe ConnectFour do
  it 'has specific number of slots' do
    expect(game.slots.length).to eql(7)
  end
end

describe '#by_row?' do
  it 'doesn\'t find a winner' do
    expect(game.by_row?).to eql(false)
  end
  it 'finds a winner in row 0' do
    game.slots.each { |slot| slot << 'x' }
    expect(game.by_row?).to eql(true)
  end
  it 'finds a winner on row 1' do
    game.slots.each(&:empty)
    game.slots.each_with_index { |slot, index| slot << (index.even? ? 'x' : 'o') }
    game.slots.each { |slot| slot << 'o' }
    expect(game.by_row?).to eql(true)
  end
end

describe '#by_column?' do
  game.slots.each(&:empty)
  it 'finds a column match in col 2' do
    %w[o o o].each { |marker| game.slots[2] << marker }
    expect(game.by_column?).to eql(true)
  end
  it 'doesn\'t find a match' do
    game.slots.each(&:empty)
    game.slots.each { |slot| 6.times { |i| slot << (i.even? ? 'x' : 'o') } }
    expect(game.by_column?).to eql(false)
  end
end

describe '#out_of_bounds?' do
  it 'returns true for out of bounds coordinates' do
    expect(game.out_of_bounds?({ x: 7, y: 5 })).to eql(true)
  end
  it 'returns false for valid coordinates' do
    expect(game.out_of_bounds?({ x: 6, y: 5 })).to eql(false)
  end
end

describe '#by_diagonial?' do
  it 'doesn\'t find a match' do
    game.slots.each(&:empty)
    expect(game.by_diagonial?).to eql(false)
  end
  it 'finds a match' do
    [%w[x], %w[o x], %w[o o x], %w[o o o x]].each_with_index { |set, i| set.each { |marker| game.slots[i] << marker } }
    expect(game.by_diagonial?).to eql(true)
  end
end

describe '#available?' do
  it 'returns false for negative slot' do
    expect(game.available?(-1)).to eql(false)
  end
  it 'returns true if legal slot' do
    game.slots.each(&:empty)
    expect(game.available?(5)).to eql(true)
  end
  it 'returns false for full slots' do
    6.times { |i| game.slots.first << i }
    expect(game.available?(0)).to eql(false)
  end
end

describe '#match?' do
  it 'finds a match' do
    expect(game.match?(%w[x o o x x x x])).to eql(true)
  end
  it 'doesn\'t find a match do' do
    expect(game.match?(%w[x o o x o x x])).to eql(false)
  end
end

describe '#show_grid' do
  it 'it outputs an empty grid' do
    game.slots.each(&:empty)
    expect(game.show_grid).to eql("5 [ ][ ][ ][ ][ ][ ][ ]\n4 [ ][ ][ ][ ][ ][ ][ ]\n3 [ ][ ][ ][ ][ ][ ][ ]\n"\
                                  "2 [ ][ ][ ][ ][ ][ ][ ]\n1 [ ][ ][ ][ ][ ][ ][ ]\n0 [ ][ ][ ][ ][ ][ ][ ]\n"\
                                  '   0  1  2  3  4  5  6')
  end
end

describe '#tie?' do
  it 'determines if there isn\'t a tie' do
    expect(game.tie?).to eql(false)
  end
  it 'determines if there is a tie' do
    game.slots.each { |slot| 7.times { |i| slot << (i.even? ? 'x' : 'o') } }
    expect(game.tie?).to eql(true)
  end
end
