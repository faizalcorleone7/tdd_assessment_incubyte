class Calculator

  attr_reader :delimiter, :numbers

  def initialize
    @numbers = []
  end

  def add(input_string)
    parse(input_string)
    sum = 0
    numbers.each { |number|
      sum = sum + number
    }
    sum
  end

  private

  def parse(numbers_string)
    derive_delimiter(numbers_string)
    derive_numbers(numbers_string)
  end

  def derive_delimiter(numbers_string)
    parsed_delimiter = nil
    if numbers_string.include?("//")
      segments = numbers_string.split("//")
      parsed_delimiter = segments[1].split("\n").first
    end
    @delimiter = parsed_delimiter || ","
  end

  def derive_numbers(numbers_string)
    @numbers = numbers_string.split(delimiter).map(&:to_i)
  end

end
