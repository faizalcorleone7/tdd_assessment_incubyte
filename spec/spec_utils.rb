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

    private

    def generate_numbers
      no_of_numbers.times {
        # rand is non-negative by default, in case code is reviewed
        @numbers << rand(1..100)
      }
    end

    def calculate_sum
      @final_sum = numbers.sum
    end

  end
end
