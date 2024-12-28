class Calculator

  attr_reader :delimiter, :numbers, :negative_numbers

  def initialize
    @numbers = []
    @negative_numbers = []
  end

  def add(input_string)
    validate_input_characters(input_string)
    parse(input_string)
    validate_derived_numbers
    calculate_sum
  end

  private

  def parse(numbers_string)
    derive_delimiter(numbers_string)
    derive_numbers(numbers_string)
  end

  def validate_post_delimiter_derivation(numbers_string)
    return unless numbers_string.include?(delimiter)
    last_segment = numbers_string.split(delimiter).reverse.first
    raise ArgumentError if all_whitespace?(last_segment)
  end

  def all_whitespace?(string)
    string.each_char.all? { |char| char.match?(/\s/) }
  end

  def derive_delimiter(numbers_string)
    parsed_delimiter = nil
    if numbers_string.include?("//")
      segments = numbers_string.split("//")
      lines = segments[1].split("\n")
      parsed_delimiter = lines.first
      remaining_lines = lines[1..-1].join("\n")
    end
    @delimiter = parsed_delimiter || ","
    if parsed_delimiter.nil?
      validate_post_delimiter_derivation(numbers_string)
    else
      validate_post_delimiter_derivation(remaining_lines) if !remaining_lines.nil? && remaining_lines.length > 0
    end
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
    numbers.each { |number| sum = sum + number if number < 1000 }
    sum
  end

  def validate_derived_numbers
    @numbers.each { |number| @negative_numbers.push(number) if number < 0 }
    raise ArgumentError, "negatives not allowed - #{negative_numbers.join(",")}" if negative_numbers.length > 0
  end

end
