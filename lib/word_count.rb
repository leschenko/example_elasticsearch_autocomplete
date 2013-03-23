class Array
  def word_count
    each_with_object({}) do |word, h|
      h[word] ||= 0
      h[word] += 1
    end
  end
end
