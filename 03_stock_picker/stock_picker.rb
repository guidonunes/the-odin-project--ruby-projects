def stock_picker(arr)
    best_day_buy = 0
    best_day_sell = 0
    max_profit = 0

    arr.each_index do |buy_day|
        #start the iteration from the day after the current buy_day
        (buy_day + 1...arr.length).each do |sell_day|
            current_profit = arr[sell_day] - arr[buy_day]
        
            #Update best day to buy, best day to sell, and max profit if the current profit is greater
            if current_profit > max_profit
                best_day_buy = buy_day
                best_day_sell = sell_day
                max_profit = current_profit
            end     
        end
    end
    [best_day_buy, best_day_sell]
end


puts stock_picker([17,3,6,9,15,8,6,1,10]).inspect # for a profit of $15 - $3 == $12
