class Numeric
  @@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019, 'dollar' => 1.0}
  
  def method_missing(method, *args)
    singular_currency = (method == :in ? args.first : method).to_s.gsub(/s$/, '')
    if @@currencies.has_key?(singular_currency)
      self.send(method == :in ? :/ : :*, @@currencies[singular_currency])
    else
      super
    end
  end
  
end

class String
  def palindrome?
    self.gsub(/[^a-z]/i, '').downcase == self.gsub(/[^a-z]/i, '').downcase.reverse
  end
end

module Enumerable
  def palindrome?
    self.to_a == self.to_a.reverse
  end
end