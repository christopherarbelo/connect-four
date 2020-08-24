# frozen_string_literal: true

require './lib/slot'

slot_one = Slot.new

describe Slot do
  describe '#<<' do
    it 'can\'t insert if full' do
      [1, 2, 3, 4, 5, 6, 7].each { |marker| slot_one << marker }
      expect(slot_one << 8).to eql(nil)
    end
    it 'can insert if not full' do
      slot_one.empty
      [1, 2, 3, 4].each { |marker| slot_one << marker }
      expect(slot_one << 5).to eql([1, 2, 3, 4, 5, nil])
    end
  end

  describe '#full?' do
    it 'can tell if it\'s not full' do
      slot_one.empty
      [1, 2, 3].each { |marker| slot_one << marker }
      expect(slot_one.full?).to eql(false)
    end
    it 'can tell if it is full' do
      slot_one.empty
      [1, 2, 3, 4, 5, 6, 7].each { |marker| slot_one << marker }
      expect(slot_one.full?).to eql(true)
    end
  end
end
