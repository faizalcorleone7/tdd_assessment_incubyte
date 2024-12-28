class Calculator

  attr_reader :delimiter, :numbers

  def initialize
    @numbers = []
  end

  def add(input_string)
    validate_input_characters(input_string)
    parse(input_string)
    calculate_sum
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

  def validate_input_characters(numbers_string)
    alphabetic_pattern = /[a-zA-Z]/
    numbers_string.each_char do |number|
      raise ArgumentError if number =~ alphabetic_pattern
    end
  end

  def calculate_sum
    sum = 0
    numbers.each { |number| sum = sum + number }
    sum
  end

end
