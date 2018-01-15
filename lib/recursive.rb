class Recursive
  include Enumerable

  def initialize(initial_values: {}, &func)
    if initial_values.is_a? Array
      @cached_values = Hash[initial_values.map.with_index { |c, i| [i, c]}]
    else
      @cached_values = initial_values
    end
    @cached_values.default_proc = proc do |hash, key|
      hash[key] = call_function(key)
    end
    @function = func
  end

  def [](value)
    @cached_values[value]
  end

  def call(value)
    return @cached_values[value]
  end

  def call_function(value)
    @function.call(self, value)
  end

  def each
    return to_enum(__callee__) unless block_given?
    index = @cached_values.values.first
    loop do
      yield call(index)
      index += 1
    end
  end
end
