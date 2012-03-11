def palindrome? string
  unless string.nil?
    string = string.gsub(/[^a-z]/i, '').downcase
    string == string.reverse
  end
end

def count_words string
  unless string.nil?
    words = string.downcase.gsub(/[^a-z\s]/i, '').split
    words.group_by {|word| word}.inject({}) {|hash, key| hash[key.first] = key.last.size; hash}
  end
end