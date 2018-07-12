def substrings(string, dictionary)
  string.downcase!
  result = Hash.new(0)
  dictionary.each do |substring|
    i = 0
    while string.index(substring, i)
      i = string.index(substring, i) + 1
      result[substring] += 1
    end

  end
puts result

end


dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

substrings("below", dictionary)
substrings("Howdy partner, sit down! How's it going?", dictionary)
