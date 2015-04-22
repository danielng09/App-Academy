def factors(num)
  num_factors = [1, num]
  index = 2
  while index <= num / 2
    if num % index == 0
      num_factors << index
    end
    index += 1
  end
  num_factors.sort
end

def bubble_sort(array)
  loop do
    swapped = false
    index = 1
    while index < array.length
      if array[index-1] > array[index]
        array[index-1], array[index] = array[index], array[index-1]
        swapped = true
      end
      index += 1
    end
    break if swapped == false
  end
  array
end

def substrings(string)
  output = []
  index1 = 0
  while index1 < string.size
    index2 = index1
    while index2 < string.size
      output << string[index1..index2]
      index2 += 1
    end
    index1 += 1
  end
  output
end

def subwords(string)
  output = substrings(string)
  #filters output
  dictionary = File.readlines("dictionary.txt")
  dictionary.map! { |x| x.chomp }
  output.select {|combo| dictionary.include?(combo) }
end
