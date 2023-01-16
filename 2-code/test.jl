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

# Short function to do a subset on ficelles F1

function ficelle_F1(Dframe)
    @subset!(Dframe, :ficelles .== "F1")
    return Dframe
end

# 

function tree_growth_files(Dframe)
    for i in unique(Dframe[!, :arbres])
        println(i)
    end
end

tree_growth_files(df)




function tree_growth_files(Dframe)
    col_dates = Dframe[!, :date]
    selected = col_dates[1:61]

    for i in unique(Dframe[!, :arbres])
        @subset!(Dframe, :arbres .== i)
        growth_setp = growth(Dframe[!, :dendrometre])
        cumul_growth_setp = cumulated_growth(growth_setp)
        i = DataFrame(Dates=selected, Growth_mm=growth_setp, cumul_mm=cumul_growth_setp)
    end
end


