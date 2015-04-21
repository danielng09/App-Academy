# 1. Write a MyHashSet#initialize method which sets an empty hash object to @store.
# 2. Next, write a #insert(el) method that stores el as a key in @store, storing true as the value.
# 3. Write an #include?(el) method that sees if el has previously been inserted by checking the @store; return true or false.
# 4. Next, write a #delete(el) method to remove an item from the set. Return true if the item had been in the set, else return false.
# 5. Add a method #to_a which returns an array of the items in the set.
# 6. Next, write a method set1#union(set2) which returns a new set which includes all the elements in EITHER set1 or set2.
# 7. Write a set1#intersect(set2) method that returns a new set which includes only those elements that are in BOTH set1 and set2.
# 8. Write a set1#minus(set2) method which returns a new set which includes all the items of set1 that aren't in set2.

class MyHashSet
  def initialize
    @store = {}
  end

  def insert(el)
    @store[el] = true
  end

  def include?(el)
    @store.keys.each do |key|
      return true if key == el
    end
    false
  end

  def delete(el)
    if @store.include?(el)
      @store.delete(el)
      return true
    else
      return false
    end
  end

  def to_a
    output = []
    @store.each do |key, value|
        output << [key, value]
    end
    output
  end

  def union(set2)
    output = @store
    set2.each do |key, value|
      if !@store.include?(key)
        output[key] = value
      end
    end
    output
  end

  def intersect(set2)
    output = {}
    set2.each do |key, value|
      if @store.include?(key)
        output[key] = value
      end
    end
    output
  end

  def minus(set2)
    output = @store
    set2.each do |key, value|
      if @store.include?(key)
        output.delete(key)
      end
    end
    output
  end
end
