def to_rpn(expression)
  precedence = { '+' => 1, '-' => 1, '*' => 2, '/' => 2 }
  output = []
  stack = []

  expression.split.each do |token|
    if token.match(/^\d+$/) 
      output.push(token)
    elsif precedence.key?(token) 
      while !stack.empty? && precedence[stack.last] && precedence[stack.last] >= precedence[token]
        output.push(stack.pop)
      end
      stack.push(token)
    elsif token == '(' 
      stack.push(token)
    elsif token == ')' 
      while stack.last != '('
        raise "несбалансированные скобки" if stack.empty?
        output.push(stack.pop)
      end
      stack.pop
    else
      raise "недопустимый ввод `#{token}`"
    end
  end

  while !stack.empty?
    raise "несбалансированные скобки" if stack.last == '('
    output.push(stack.pop)
  end

  output.join(' ')
end

input = "6 - 7 + 9 + 10"
output = to_rpn(input)
puts "input --> #{input}"
puts "output --> #{output}"
