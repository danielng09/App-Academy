# power_of_ten = 1
# num_in_words = ''
# while power_of_ten < num
#   current_set_of_three = 765_123 / power_of_ten
#   num_in_words = this_set_of_three.in_words + "m" + num_in_words
#   power_of_ten *= 1000
# end


class Fixnum
  @@powers = {1 => "", 1000 => " thousand", 1_000_000 => " million", 1_000_000_000 => " billion",
              1_000_000_000_000 => " trillion"}
  @@words = {  0 => 'zero',
    1 =>  'one',
    2 =>  'two',
    3 =>  'three',
    4 =>  'four',
    5 =>  'five',
    6 =>  'six',
    7 =>  'seven',
    8 =>  'eight',
    9 =>  'nine',
    10 =>  'ten',
    11 =>  'eleven',
    12 =>  'twelve',
    13 =>  'thirteen',
    14 =>  'fourteen',
    15 =>  'fifteen',
    16 =>  'sixteen',
    17 =>  'seventeen',
    18 =>  'eighteen',
    19 =>  'nineteen',
    20 =>  'twenty',
    30 =>  'thirty',
    40 =>  'forty',
    50 =>  'fifty',
    60 =>  'sixty',
    70 =>  'seventy',
    80 =>  'eighty',
    90 =>  'ninety'
    }

  def in_words
    power = 1
    output = []
    return "zero" if self == 0
    while power <= self
      number = self
      number /= power
      set_of_three = number % (1000)
      output << zero_to_999(set_of_three) + @@powers[power] if set_of_three != 0
      power *= 1000
    end
    output.delete("")
    output.reverse.join(" ")
  end

  def zero_to_999(num)
    output = []
    while num > 0
      if @@words.has_key?(num)
        output << @@words[num]
        break
      elsif num > 20 && num < 100
        output << @@words[(num/10)*10]
        num %= 10
      else
        output << @@words[num.to_s[0].to_i] + " hundred"
        num %= 100
      end
    end
    output.join(" ")
  end


end
