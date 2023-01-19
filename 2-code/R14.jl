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

df = DataFrame(XLSX.readtable("./1-data/Dahra_Compil_tronc.xlsx", "Raddianna")) # reading data

"""
 in Let ... end function , we aggregate two actions on data: 
 1. only taking the F1 ficelles measurements 
 2. only considering the A1 tree 
"""

let
    #@subset!(df, :ficelles .== "F1")
    @subset!(df, :ID .== "R14")
end

"""
1. calculating the growth of A trunk 
2. calculating the cumulated growth 
"""

growth_setp = growth(df[!, :Dendro_Plast])
cumul_growth_setp = cumulated_growth(growth_setp)


"""
1. add dates column
2. making a dataframe 
3. exporting calculations as an excel file 
"""

length(growth_setp) #  cheking for the length
length(cumul_growth_setp) # cheking for the length
length(df[!, :date]) # cheking for the length

col_dates = df[!, :Date] # taking the date column
selected = col_dates[1:end-1] # selected rows acording  to the growth applied function 
length(selected) # cheking for the length

df_R14 = DataFrame(Dates=selected, Growth_cm=growth_setp, cumul_cm=cumul_growth_setp)

function cm_to_mm(x)
    n = x * 10
    return n
end

let
    df_R14.Growth_mm = cm_to_mm.(df_R14[!, :Growth_cm])
    df_R14.cumul_mm = cm_to_mm.(df_R14[!, :cumul_cm])
end

XLSX.writetable("arbre_R14.xlsx", df_R14)






