require 'rspec'
require_relative '../lib/calculator'
require_relative "./spec_utils.rb"

RSpec.describe Calculator do

  include SpecUtils
  describe 'add numbers successfully' do
    context "when adding numbers which are comma seperated" do
      it 'simple addition of two numbers which have only comma between them' do
        calculator = Calculator.new
        data_generator = SpecUtils::NumberAndSumGenerator.new(2)
        data_generator.generate_test_data
        expect(calculator.add("#{data_generator.numbers[0]},#{data_generator.numbers[1]}")).to eq(data_generator.final_sum)
      end

      it 'adds any number of numbers which have only comma between them' do
        calculator = Calculator.new
        data_generator = SpecUtils::NumberAndSumGenerator.new(rand(10))
        data_generator.generate_test_data
        expect(calculator.add("#{data_generator.numbers.join(',')}")).to eq(data_generator.final_sum)
      end

      it 'adds numbers which have comma and spaces between them' do
        calculator = Calculator.new
        data_generator = SpecUtils::NumberAndSumGenerator.new(2)
        data_generator.generate_test_data
        spaces = SpecUtils::WhiteSpaceStringGenerator.generate(rand(100), " ")
        expect(calculator.add("#{data_generator.numbers[0]}," + spaces +  "#{data_generator.numbers[1]}")).to eq(data_generator.final_sum)
      end

    end
  end
end
