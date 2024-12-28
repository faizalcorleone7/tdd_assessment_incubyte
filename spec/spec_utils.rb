module SpecUtils
  class NumberAndSumGenerator

    attr_reader :no_of_numbers, :final_sum, :numbers
    def initialize(no_of_numbers)
      @no_of_numbers = no_of_numbers
      @final_sum = 0
      @numbers = []
    end

    def generate_test_data
      @final_sum = 0
      generate_numbers
      calculate_sum
    end

    def generate_negative_numbers_data
      generate_numbers(true)
    end

    private

    def generate_numbers(negative=false)
      no_of_numbers.times {
        # rand is non-negative by default, in case code is reviewed
        number = rand(1..100)
        number = number * (-1) if negative
        @numbers << number
      }
    end

    def calculate_sum
      @final_sum = numbers.sum
    end

  end

  class RandomStringGenerator

    def self.generate(no_of_times, whitespace=nil)
      final_string = ""
      no_of_times.times {
        if whitespace.nil?
          whitespace = character_set[rand(character_set.length)]
        end
        final_string = final_string + whitespace
      }
      final_string
    end
  end

  class WhiteSpaceStringGenerator < RandomStringGenerator
    def self.character_set
      [" ", "\t", "\n", "\r", "\f", "\v"]
    end
  end

  class AlphabetStringGenerator < RandomStringGenerator
    def self.character_set
      ('a'..'z').to_a
    end
  end

  class AlphaNumberStringGenerator < RandomStringGenerator
    def self.character_set
      ['!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '-', '_', '=', '+', '{', '}', '|', '\\', ':', ';', '"', "'", '<', '>', ',', '.', '?', '/']
    end
  end

  class MultipleDelimiterGenerator
    def self.generate(no_of_delimiters)
      delimiter_chars = []
      no_of_delimiters.times{ delimiter_chars << AlphaNumberStringGenerator.generate(1) }
      MultipleDelimiter.new(delimiter_chars)
    end
  end

  class MultipleDelimiter

    attr_reader :delimiters
    def initialize(delimiters)
      @delimiters = delimiters
    end

    def definition
      return delimiters.first if delimiters.length == 1
      "[#{delimiters.join("][]")}]"
    end

    def apply_random_delimiter
      index = rand(0..delimiters.length - 1) rescue 0
      delimiters[index]
    end
  end

end
