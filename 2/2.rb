class CartesianProduct
  include Enumerable
  
  def initialize(a, b)
    @values = []
    a.map {|av| b.map {|bv| @values << [av, bv]}} unless a.empty? || b.empty?
  end
  
  def each(&block)
    @values.each {|v| yield v}
  end
  
end