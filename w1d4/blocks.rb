class Array

  def my_each(&blk)
    self.length.times do |index|
        #run the blk on each element in the array object
        blk.call(self[index])
    end
  end

  def my_map(&blk)
    output = []
    self.my_each do |ele|
      output << blk.call(ele)
    end
    output
  end

  def my_select(&blk)
    output = []
    self.my_each do |ele|
      output << ele if blk.call(ele)
    end
    output
  end

  def my_inject(accumulator, &blk)
    self.my_each do |ele|
      accumulator = blk.call(accumulator, ele)
    end
    accumulator
  end

  def my_sort!(&blk)
    is_sorted = false
    blk ||= Proc.new { |x , y| x <=> y }
    until is_sorted
      is_sorted = true
      (self.length - 1).times do |index|
        if blk.call(self[index], self[index + 1]) == 1
          self[index], self[index + 1] = self[index + 1], self[index]
          is_sorted = false
        end
      end
    end
    self
  end

  def my_sort
    self.dup.my_sort!
  end

end

def eval_block(*arg, &prc)
  return "no block given" if prc.nil?
  prc.call(*arg)
end
