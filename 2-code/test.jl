begin
    using DataFrames
    using Statistics
    using XLSX
    using DataFramesMeta
    using CSV
end

using Revise # for tacking into account orther changements 
includet("../2-code/Functions.jl") # for tacking into acount Functions.jl file  
using .Growth_functions # caling the Growth_functions module 

df = DataFrame(XLSX.readtable("./1-data/Niakhar_Compil_tronc.xlsx", "tri_Dendrometre")) # reading data

length(df[!, :arbres])

# Short function to do a subset on ficelles F1

function ficelle_F1(Dframe)
    @subset!(Dframe, :ficelles .== "F1")
    return Dframe
end

ficelle_F1(df)
length(df[!, :arbres]) # checking 

"""
a function that takes a DataFrame and compute the growth 
and cumulated growth of each tree in :arbres column 
"""

function compute_tree_growth_files(Dframe::DataFrame)
    growth_setp_list = []
    cumul_growth_setp_list = []
    col_dates = Dframe[!, :date] # indicated date column
    selected = col_dates[1:end-1] # selected rows 
    tree_list = unique(Dframe[!, :arbres])
    for i in 1:length(tree_list)
        let
            @subset!(Dframe, :arbres .== tree_list[i])
            growth_setp = growth(Dframe[!, :dendrometre]) # ok 
            cumul_growth_setp = cumulated_growth(growth_setp) # ok
            append!(growth_setp_list, growth_setp) # ok 
            append!(cumul_growth_setp_list, cumul_growth_setp) # ok 
            #DataFrame(Dates=selected, Growth_mm=growth_setp, cumul_mm=cumul_growth_setp)
            #XLSX.writetable("table.xlsx", table)
        end
        break
    end
    return DataFrame(Dates=selected, Growth_mm=growth_setp, cumul_mm=cumul_growth_setp)
end

#Dates = selected,
compute_tree_growth_files(df)


"""
# first coding test 

function tree_growth_files_computing(Dframe::DataFrame)
    growth_setp_list = []
    cumul_growth_setp_list = []
    #col_dates = Dframe[!, :date] # indicated date column
    #selected = col_dates[1:end-1] # selected rows 
    tree_list = unique(Dframe[!, :arbres])
    for i in 1:length(tree_list)
        @subset!(Dframe, :arbres .== tree_list[i])
        growth_setp = growth(Dframe[!, :dendrometre]) # ok 
        cumul_growth_setp = cumulated_growth(growth_setp) # ok
        append!(growth_setp_list, growth_setp) # ok 
        append!(cumul_growth_setp_list, cumul_growth_setp) # ok 
        #table = DataFrame(Growth_mm=growth_setp, cumul_mm=cumul_growth_setp)
        #XLSX.writetable("table.xlsx", table)
        break
    end
    return length(growth_setp_list)
end
"""


"""
# short function to visualize tree unique names 

function tree_growth_files(Dframe)
    for i in unique(Dframe[!, :arbres])
        println(i)
    end
end
"""