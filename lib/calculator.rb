class Calculator

  attr_reader :delimiter, :numbers, :negative_numbers, :numbers_string

  def initialize
    @numbers = []
    @negative_numbers = []
  end

  def add(input_string)
    @numbers_string = input_string
    validate_input_characters
    parse
    validate_derived_numbers
    calculate_sum
  end

  private

  def parse
    derive_delimiter
    derive_numbers
  end

  def validate_post_delimiter_derivation(validation_string)
    return unless validation_string.include?(delimiter)
    last_segment = validation_string.split(delimiter).reverse.first
    raise ArgumentError if all_whitespace?(last_segment)
  end

  def all_whitespace?(string)
    string.each_char.all? { |char| char.match?(/\s/) }
  end

  def derive_delimiter
    parsed_delimiters = []
    if numbers_string.include?("//")
      segments = numbers_string.split("//")
      lines = segments[1].split("\n")
      parsed_delimiters = parse_delimiters(lines.first)
      remaining_lines = lines[1..-1].join("\n")
      @number_string = remaining_lines
    end

    parsed_delimiters.each { |delimiter|
      numbers_string.gsub!(delimiter, ",")
    }

    @delimiter = ","
    if parsed_delimiters.length.zero?
      validate_post_delimiter_derivation(numbers_string)
    else
      validate_post_delimiter_derivation(remaining_lines) if !remaining_lines.nil? && remaining_lines.length > 0
    end
  end

  def parse_delimiters(delimiter_line)
    return [delimiter_line] unless delimiter_line.include?("][")
    delimiter_line[1..-2].split("][") rescue []
  end

  def derive_numbers
    @numbers = numbers_string.split(delimiter).map(&:to_i)
  end

  def validate_input_characters
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
