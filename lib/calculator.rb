class Calculator
  def add(input_string)
    numbers = input_string.split(",").map(&:to_i)
    numbers[0] + numbers[1]
  end
end
