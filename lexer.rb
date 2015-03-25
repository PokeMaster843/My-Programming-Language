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
      
      elseif constant = chunk[/\A([A-Z]\w*)/, 1]
        tokens << [:CONSTANT, constant]
        i += constant.size
      
      elseif number = chunk[/\A([0-9]+)/, 1]
        tokens << [:NUMBER, number.to_i]
        i += number.size
      
      elseif string = chunk[/\A"([^"]*)"/, 1]
        tokens << [:STRING, string]
        i += string.size
      
      elseif indent = chunk[/\A\:\n( +)/m, 1]
        if indent.size <= current_indent
          raise "Bad indent level, got #{indent.size} indents, expected > #{current_indent}"
        end
      
    
  
