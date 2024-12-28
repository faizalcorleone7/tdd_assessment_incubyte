class Calculator
  def add(input_string)
    numbers = input_string.split(",").map(&:to_i)
    sum = 0
    numbers.each { |number|
      sum = sum + number
    }
    sum
  end
end
