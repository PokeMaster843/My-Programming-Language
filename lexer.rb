class Lexer
  
  KEYWORDS = ["def", "class", "if", "true", "false", "null"]
  
  def tokenize(code)
    
    code.chomp!
    tokens= []
    current_indent = 0
    indent_stack = []
    i = 0
    
    while i < code.size
      
      chunk = code[i..-1]
      
      if identifier = chunk[/\A([a-z]\w*)/, 1]
        
        if KEYWORDS.include?(identifier)
          tokens << [identifier.upcase.to_sym, identifier]
          
        else
          tokens << [:IDENTIFIER, identifier]
        end
        i += identifier.size
      
      elsif constant = chunk[/\A([A-Z]\w*)/, 1]
        tokens << [:CONSTANT, constant]
        i += constant.size
      
      elsif number = chunk[/\A([0-9]+)/, 1]
        tokens << [:NUMBER, number.to_i]
        i += number.size
      
      elsif string = chunk[/\A"([^"]*)"/, 1]
        tokens << [:STRING, string]
        i += string.size
      
      elsif indent = chunk[/\A\:\n( +)/m, 1]
        if indent.size <= current_indent
          raise "Bad indent level, got #{indent.size} indents, expected > #{current_indent}"
        end
        current_indent = indent.size
        indent_stack.push(current_indent)
        tokens << [:INDENT, indent.size]
        i += indent.size + 2
      elsif indent = chunk[/\A\n( *)/m, 1]
        if indent.size == current_indent
          tokens << [:NEWLINE, "\n"]
        
        elsif indent.size < current_indent
          while indent.size < current_indent
            indent_stack.pop
    
    
  
