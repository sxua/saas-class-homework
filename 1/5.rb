class Class
  def attr_accessor_with_history(attr_name)
    attr_reader attr_name
    class_eval %Q{
      def #{attr_name}_history
        @#{attr_name}_history = [nil] if @#{attr_name}_history.nil?
        @#{attr_name}_history
      end
      
      def #{attr_name}= value
        @#{attr_name}_history = @#{attr_name}_history.nil? ? [nil, value] : (@#{attr_name}_history << value)
        @#{attr_name} = value
      end
    }
  end
end

class Foo
  attr_accessor_with_history :bar
end