class Nodes < Struct.new(:nodes)
  def <<(node)
    nodes << node
    self
  end
end

class LiteralNode < Struct.new(:value); end

class StringNode < LiteralNode; end

class NumberNode < LiteralNode; end

class TrueNode < LiteralNode
  def initialize
    super(true)
  end
end

class FalseNode < LiteralNode
  def initialize
    super(false)
  end
end

class NullNode < LiteralNode
  def initialize
    super(nil)
  end
end

class CallNode < Struct.new(:reciever, :method, :arguments); end

class GetConstantNode < Struct.new(:name); end

class SetConstantNode < Struct.new(:name, :value); end

class GetLocalNode < Struct.new(:name); end

class SetLocalNode < Struct.new(:name, :value); end

class DefNode < Struct.new(:name, :params, :body); end

class ClassNode < Struct.new(:name, :body); end

class IfNode < Struct.new(:condition, :body); end
