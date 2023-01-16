module Growth_functions

using DataFrames
"""
1. easy and short function to calculate growth between two dates  
"""
function growth(col)
    cumul = []
    for i in 1:length(col)
        res = 0
        if i .!= length(col)
            if i .== 1
                res = 0
            else
                res = col[i] - col[i-1]
            end
            cumul = append!(cumul, res)
        else
            break
        end
    end
    return cumul
end

"""
2. easy and short function to calculate cumulated growth  

"""
function cumulated_growth(col)
    total = 0
    cumul_2 = []
    for i in col
        i
        total = i + total
        append!(cumul_2, total)
    end
    return cumul_2
end

export cumulated_growth, growth
end