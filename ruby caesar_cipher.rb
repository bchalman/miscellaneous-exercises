class String
  def caesar_cipher(shift)
    abc = ("a".."z").to_a
    temp = self.split("").map do |i|
      if /[a-zA-Z]/ =~ i #abc.include?(i.downcase)
        if i != i.downcase
          abc[(abc.index(i.downcase).to_i + shift)%26].upcase
        else
          abc[(abc.index(i).to_i + shift)%26]
        end
      else
        i
      end
     end
     temp.join
  end
end

test_string = "Hello wOrd"
puts test_string.caesar_cipher(1)
puts ""
puts "abcxyz!".caesar_cipher(1)
