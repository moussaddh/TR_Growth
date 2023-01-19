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

"""
 in Let ... end function , we aggregate two actions on data: 
 1. only taking the F1 ficelles measurements 
 2. only considering the A1 tree 
"""

let
    @subset!(df, :ficelles .== "F1")
    @subset!(df, :arbres .== "A28")
end

"""
1. calculating the growth of A trunk 
2. calculating the cumulated growth 
"""

growth_setp = growth(df[!, :dendrometre])
cumul_growth_setp = cumulated_growth(growth_setp)


"""
1. add dates column
2. making a dataframe 
3. exporting calculations as an excel file 
"""

length(growth_setp) #  cheking for the length
length(cumul_growth_setp) # cheking for the length
length(df[!, :date]) # cheking for the length

col_dates = df[!, :date] # taking the date column
selected = col_dates[1:end-1] # selected rows acording  to the growth applied function 
length(selected) # cheking for the length


df_A28 = DataFrame(Dates=selected, Growth_mm=growth_setp, cumul_mm=cumul_growth_setp)
XLSX.writetable("arbre_A28.xlsx", df_A28)
