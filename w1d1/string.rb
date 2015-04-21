def num_to_s(num, base)
  characters = {0 => "0", 1 => "1", 2 => "2", 3 => "3", 4 => "4",
                5 => "5", 6 => "6", 7 => "7", 8 => "8",
                9 => "9", 10 => "A", 11 => "B", 12 => "C",
                13 => "D", 14 => "E", 15 => "F"}
  string = ''
  base_multiples = [1]
  while base_multiples[-1] < num
    base_multiples << base_multiples[-1] * base
  end
  base_multiples.pop
  base_multiples.each do |mult|
    string << characters[(num/mult) % base]
  end
  string.reverse
end

def caesar_cipher(string, shift)
  shift %= 26
  shifted_string = ''
  string.each_char do |char|
    if char.ord.between?(97,122)
      new_char = (char.ord + shift)
      new_char -= 26 if new_char > 122
      shifted_string << new_char.chr
    elsif char.ord.between?(65,90)
      new_char = (char.ord + shift)
      new_char -= 26 if new_char > 90
      shifted_string << new_char.chr
    else
      shifted_string << char
    end
  end
  shifted_string
end
