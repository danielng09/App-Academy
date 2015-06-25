def my_uniq(arr)
  uniq = []
  arr.each do |num|
    uniq << num if !uniq.include?(num)
  end
  uniq
end

p my_uniq([1,2,1,3,3])


def two_sum(arr)
 output = []
 i=0
 while i < arr.length - 1
   j = i+1
   while j < arr.length
     if arr[i] + arr[j] == 0
       output << [i, j]
     end
     j += 1
   end
   i += 1
 end
 output
end

def my_transpose(matrix)
  row = 0
  column = 0
  output = []
  while column < matrix.length
    transfer = []
    while row < matrix.length
      transfer << matrix[row][column]
      row += 1
    end
    row = 0
    output << transfer
    column += 1
  end
  output
end

# def stock_picker(stocks)
#   buy_idx = 0
#   max_profit = 0
#   best_days = []
#   while buy_idx < stocks.length - 1
#     sell_idx = buy_idx + 1
#     while sell_idx < stocks.length
#       profit = stocks[sell_idx] - stocks[buy_idx]
#       if profit > max_profit
#         max_profit = profit
#         best_days = [buy_idx,sell_idx]
#       end
#       sell_idx += 1
#     end
#     buy_idx += 1
#   end
#   best_days
# end

def stock_picker(stocks)
  profit = 0
  best_days = []
  stocks.each_with_index do |price,buy|
    stocks.each_with_index do |price2,sell|
      if (buy < sell) && (price2 - price > profit)
        profit = price2 - price
        best_days = [buy,sell]
      end
    end
  end
  best_days
end

def towers_of_hanoi
  tower = [[1,2,3],[],[]]
  until tower == [[],[],[1,2,3]]
    p tower
    puts "Choose which tower to move disc from"
    input = gets.chomp.to_i-1
    disc = tower[input].shift
    puts "Choose which tower to move disc to"
    input2 = gets.chomp.to_i-1
    if tower[input2][0].nil? || tower[input2][0] > disc
      tower[input2].unshift(disc)
    else
      p "That is not a valid move"
      tower[input].unshift(disc)
    end
  end
  puts "Well Done!!"
end
