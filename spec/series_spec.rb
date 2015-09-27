require 'spec_helper'

describe Series do
  it 'has a version number' do
    expect(Series::VERSION).not_to be nil
  end

  it 'accepts an expression as a block' do
    a_block = -> (n) { n + 1 }
    expect(Series.new(&a_block)).to be_a Series
  end

  it "tracks the index and solves the equation" do
    a_block = -> (n) { 2 * n }
    series = Series.new(upper_bound: 3, &a_block)
    expect { |b| series.each(&b) }.to yield_successive_args(2, 4, 6)
  end

  context "when a lower bound is specified" do
    it "uses that as the first value" do
      a_block = -> (n) { n }
      expect(Series.new(lower_bound: 3, &a_block).first).to eq 3
    end
  end

  context "when an upper bound is specified" do
    it "stops at the value" do
      upper_bound = 3
      a_block = -> (n) { n }
      series = Series.new(upper_bound: upper_bound, &a_block)
      expect(series.take(upper_bound + 1).length).to eq 3
    end
  end
end
