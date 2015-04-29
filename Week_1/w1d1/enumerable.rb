def times_two(array)
  array.map { |num| num*2 }
end

class Array
  def my_each
    i = 0
    while i < self.length
      yield(self[i])
      i += 1
    end
  end

  def median
    sorted_arr = self.sort
    arr_length = sorted_arr.length
    if arr_length.even?
      (sorted_arr[arr_length/2]+sorted_arr[arr_length/2 - 1])/2
    else
      sorted_arr[arr_length/2]
    end
  end

  def concatenate
    self.inject("",&:+)
  end
end
