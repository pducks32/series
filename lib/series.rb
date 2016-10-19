require "series/version"

class Series
  include Enumerable

  attr_accessor :lower_bound, :upper_bound, :expression

  def initialize(range = 1..Float::INFINITY, lower_bound: range.min, upper_bound: range.max, &expression)
    @expression = expression
    @enumerator = expression_to_enum
    @lower_bound = lower_bound
    @upper_bound = upper_bound
  end

  def [](index)
    expression.call(index)
  end

  def each
    return to_enum(__callee__) unless block_given?
    @enumerator.each { |n| yield n }
  end

  def partial_sum(bound)
    take(bound).reduce(:+)
  end

  def sum
    raise RangeError.new("Cannot sum upto INFINITY") if upper_bound == Float::INFINITY
    reduce(:+)
  end

  private

  def expression_to_enum
    return to_enum(__callee__) unless block_given?
    (lower_bound..upper_bound).each { |n| yield self[n] }
  end
end
