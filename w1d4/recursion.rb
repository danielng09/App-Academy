require 'byebug'

def range(start, ending)
  return [] if start > ending
  range(start, ending - 1) << ending
end

def exp1(base, power)
  return 1 if power <= 0
  base * exp(base, power-1)
end

def exp2(base, power)
  return 1 if power <= 0
  if power % 2 == 0
    exp2(base, power / 2) * exp2(base, power / 2)
  else
    base * (exp2(base, (power - 1) / 2) * exp2(base, (power - 1) / 2) )
  end
end


class Array

  def deep_dup
    self.map do |ele|
      if ele.is_a?(Array)
        ele.deep_dup
      else
        ele
      end
    end
  end

  def shallow_dup
    self.map do |ele|
      ele
    end
  end
end

def fibbonacci(n)
  return [0] if n == 1
  return [0,1] if n == 2
  fibbonacci(n-1) << fibbonacci(n-1)[-2] + fibbonacci(n-1)[-1]
end

def bsearch(array, target)
  midpoint = array.length / 2
  if array[midpoint] == target
    return midpoint
  elsif array[midpoint] < target
    next_result = bsearch(array[(midpoint + 1)..-1], target)
    midpoint + 1 + next_result
  elsif array[midpoint] > target
    next_result = bsearch(array[0...midpoint], target)
    next_result
  end
end

# make_change(14, [10, 7, 1])
# def make_change(total, array_of_coins)
#   combination = []
#
#     array_of_coins.each_with_index do |coin, index|
#       if total == 0
#         return combination
#       elsif total > 0
#         #make a combination
#
#       end
#       combination << make_change(total, array_of_coins[index..-1])
#     end
#
#   end
#     # count = array_of_coins.length
#     # while array_of_coins[count-1] < total && count > 0
#     #   count -= 1
#     # end
#     # coin = array_of_coins[count]
#     # total -= coin
#     #
#     # array_of_coins.reject! {|coin| coin > total }
#     #
#     # combination << coin
#     # combination + make_change(total, array_of_coins)
#
# end

def merge_sort(array)
  return array if array.length <= 1

end

def merge_helper(arr1, arr2)
  combine_arr = []
  idx1, idx2 = 0, 0
  while idx1 < arr1.length || idx2 < arr2.length
    if idx1 >= arr1.length
      combine_arr << arr2[idx2]
      idx2 += 1
    elsif idx2 >= arr2.length
      combine_arr << arr1[idx1]
      idx1 += 1
    elsif arr1[idx1] <= arr2[idx2]
      combine_arr << arr1[idx1]
      idx1 += 1
    else
      combine_arr << arr2[idx2]
      idx2 += 1
    end
  end
  combine_arr
end
