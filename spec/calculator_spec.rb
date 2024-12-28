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

      it 'should add numbers even if newlines are present between commas' do
        calculator = Calculator.new
        data_generator = SpecUtils::NumberAndSumGenerator.new(rand(100))
        data_generator.generate_test_data
        input_string = ""
        data_generator.numbers.each_with_index do |number, index|
          input_string = input_string + number.to_s + SpecUtils::WhiteSpaceStringGenerator.generate(rand(10), "\n")
          input_string = input_string + "," if index < data_generator.numbers.length - 1
        end
        expect(calculator.add(input_string)).to  eq(data_generator.final_sum)
      end

      it 'should give 0 if no number in input, with or without any whitelines' do
        calculator = Calculator.new
        spaces = SpecUtils::WhiteSpaceStringGenerator.generate(rand(100))
        expect(calculator.add(spaces)).to  eq(0)
        expect(calculator.add("")).to  eq(0)
      end

      it 'should give same number as input if only one number in input, without whitespaces in prefix and suffix' do
        calculator = Calculator.new
        number = rand(100)
        expect(calculator.add(number.to_s)).to  eq(number)
      end

      it 'should give same number as input if only one number in input, with whitespaces in prefix, not in suffix' do
        calculator = Calculator.new
        number = rand(100)
        prefix_spaces = SpecUtils::WhiteSpaceStringGenerator.generate(rand(100))
        expect(calculator.add("#{prefix_spaces}#{number}")).to  eq(number)
      end

      it 'should give same number as input if only one number in input, with whitespaces not in prefix, but present in suffix' do
        calculator = Calculator.new
        number = rand(100)
        suffix_spaces = SpecUtils::WhiteSpaceStringGenerator.generate(rand(100))
        expect(calculator.add("#{number}#{suffix_spaces}")).to  eq(number)
      end

      it 'should give same number as input if only one number in input, with prefix and suffix spaces' do
        calculator = Calculator.new
        number = rand(100)
        prefix_spaces = SpecUtils::WhiteSpaceStringGenerator.generate(rand(100))
        suffix_spaces = SpecUtils::WhiteSpaceStringGenerator.generate(rand(100))
        expect(calculator.add("#{prefix_spaces}#{number}#{suffix_spaces}")).to  eq(number)
      end

    end

    context "when adding number which have a different delimiter" do
      def random_non_alphanumeric_character(delimiter_length=1)
        non_alphanumeric_characters = ['!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '-', '_', '=', '+', '[', ']', '{', '}', '|', '\\', ':', ';', '"', "'", '<', '>', ',', '.', '?', '/']
        delimiter_string = ""
        delimiter_length.times { delimiter_string << non_alphanumeric_characters[rand(non_alphanumeric_characters.length)] }
        delimiter_string
      end

      let(:delimiter) { random_non_alphanumeric_character }
      let(:multiple_length_delimtier) { random_non_alphanumeric_character(rand(100)) }

      it 'performs simple addition of two numbers which have only custom delimiter between them' do
        calculator = Calculator.new
        data_generator = SpecUtils::NumberAndSumGenerator.new(2)
        data_generator.generate_test_data
        expect(calculator.add("//#{delimiter}\n#{data_generator.numbers[0]}#{delimiter}#{data_generator.numbers[1]}")).to eq(data_generator.final_sum)
      end

      it 'performs simple addition of two numbers which have only multi-character custom delimiter between them' do
        calculator = Calculator.new
        data_generator = SpecUtils::NumberAndSumGenerator.new(2)
        data_generator.generate_test_data
        expect(calculator.add("//#{multiple_length_delimtier}\n#{data_generator.numbers[0]}#{multiple_length_delimtier}#{data_generator.numbers[1]}")).to eq(data_generator.final_sum)
      end

      it 'adds any number of numbers which have only custom delimiter between them' do
        calculator = Calculator.new
        data_generator = SpecUtils::NumberAndSumGenerator.new(rand(10))
        data_generator.generate_test_data
        expect(calculator.add("//#{delimiter}\n#{data_generator.numbers.join(delimiter)}")).to eq(data_generator.final_sum)
      end

      it 'adds any number of numbers which have only multi-character custom delimiter between them' do
        calculator = Calculator.new
        data_generator = SpecUtils::NumberAndSumGenerator.new(rand(10))
        data_generator.generate_test_data
        expect(calculator.add("//#{multiple_length_delimtier}\n#{data_generator.numbers.join(multiple_length_delimtier)}")).to eq(data_generator.final_sum)
      end

      it 'adds numbers even if newlines are present between custom delimiters' do
        calculator = Calculator.new
        data_generator = SpecUtils::NumberAndSumGenerator.new(rand(100))
        data_generator.generate_test_data
        input_string = "//#{delimiter}\n"
        data_generator.numbers.each_with_index do |number, index|
          input_string = input_string + number.to_s + SpecUtils::WhiteSpaceStringGenerator.generate(rand(10), "\n")
          input_string = input_string + "#{delimiter}" if index < data_generator.numbers.length - 1
        end
        expect(calculator.add(input_string)).to  eq(data_generator.final_sum)
      end

      it 'adds numbers even if newlines are present between multiple character custom delimiters' do
        calculator = Calculator.new
        data_generator = SpecUtils::NumberAndSumGenerator.new(rand(100))
        data_generator.generate_test_data
        input_string = "//#{multiple_length_delimtier}\n"
        data_generator.numbers.each_with_index do |number, index|
          input_string = input_string + number.to_s + SpecUtils::WhiteSpaceStringGenerator.generate(rand(10), "\n")
          input_string = input_string + "#{multiple_length_delimtier}" if index < data_generator.numbers.length - 1
        end
        expect(calculator.add(input_string)).to  eq(data_generator.final_sum)
      end

      it 'should give 0 if no number in input, with or without any whitelines' do
        calculator = Calculator.new
        spaces = SpecUtils::WhiteSpaceStringGenerator.generate(rand(100))
        expect(calculator.add("//#{delimiter}\n")).to  eq(0)
        expect(calculator.add("//#{delimiter}\n#{spaces}")).to eq(0)
      end

      it 'should give same number as input if only one number in input, without whitespaces in prefix and suffix' do
        calculator = Calculator.new
        number = rand(100)
        input_string = "//#{delimiter}\n#{number}"
        expect(calculator.add(input_string)).to  eq(number)
      end

      it 'should give same number as input if only one number in input, with whitespaces in prefix, not in suffix' do
        calculator = Calculator.new
        number = rand(100)
        prefix_spaces = SpecUtils::WhiteSpaceStringGenerator.generate(rand(100))
        expect(calculator.add("//#{delimiter}\n#{prefix_spaces}#{number}")).to  eq(number)
      end

      it 'should give same number as input if only one number in input, with only suffix spaces' do
        calculator = Calculator.new
        number = rand(100)
        suffix_spaces = SpecUtils::WhiteSpaceStringGenerator.generate(rand(100))
        expect(calculator.add("//#{delimiter}\n#{number}#{suffix_spaces}")).to  eq(number)
      end

      it 'should give same number as input if only one number in input, with prefix and suffix spaces' do
        calculator = Calculator.new
        number = rand(100)
        prefix_spaces = SpecUtils::WhiteSpaceStringGenerator.generate(rand(100))
        suffix_spaces = SpecUtils::WhiteSpaceStringGenerator.generate(rand(100))
        expect(calculator.add("//#{delimiter}\n#{prefix_spaces}#{number}#{suffix_spaces}")).to  eq(number)
      end

    end
  end

  describe "Restricted cases" do
    context "Incorrect characters" do
      it "should have no alphabet in number string" do
        calculator = Calculator.new
        input_string = SpecUtils::AlphabetStringGenerator.generate(rand(100))
        expect {calculator.add(input_string) }.to raise_error ArgumentError
      end

      it "should have no negative number" do
        calculator = Calculator.new
        data_generator = SpecUtils::NumberAndSumGenerator.new(rand(1...10))
        data_generator.generate_test_data
        data_generator.numbers[0] = (-1) * data_generator.numbers[0]
        expect {calculator.add("#{data_generator.numbers.join(',')}") }.to raise_error ArgumentError, "negatives not allowed - #{data_generator.numbers[0]}"
      end

      it "should list all negative numbers in error message" do
        calculator = Calculator.new
        data_generator = SpecUtils::NumberAndSumGenerator.new(rand(1...10))
        data_generator.generate_negative_numbers_data
        expect {calculator.add("#{data_generator.numbers.join(',')}") }.to raise_error ArgumentError, "negatives not allowed - #{data_generator.numbers.join(",")}"
      end

      it "should not have any whitespace as suffix after comma" do
        calculator = Calculator.new
        number = rand(1..100)
        suffix_spaces = SpecUtils::WhiteSpaceStringGenerator.generate(rand(1..100))
        expect{ calculator.add("#{number},#{suffix_spaces}") }.to  raise_error StandardError
      end

    end

    context "Semantic restrictions" do
      it "should ignore values above 1000" do
        calculator = Calculator.new
        below_thousand_data_generator = SpecUtils::NumberAndSumGenerator.new(rand(10))
        above_thousand_data_generator = SpecUtils::NumberAndSumGenerator.new(rand(10))
        below_thousand_data_generator.generate_test_data
        above_thousand_data_generator.generate_test_data
        above_1000_numbers = []
        above_thousand_data_generator.numbers.each { |number|
          above_1000_numbers.push(number * 1000)
        }
        expect(calculator.add("#{below_thousand_data_generator.numbers.join(",")},#{above_1000_numbers.join(",")}")).to eq(below_thousand_data_generator.final_sum)
      end
    end
  end

end
