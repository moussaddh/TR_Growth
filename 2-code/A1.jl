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

df = DataFrame(XLSX.readtable("./1-data/Compil_tronc.xlsx", "tri_Dendrometre")) # reading data

"""
 in Let ... end function , we aggregate two actions on data: 
 1. only taking the F1 ficelles measurements 
 2. only considering the A1 tree 
"""

let
    @subset!(df, :ficelles .== "F1")
    @subset!(df, :arbres .== "A1")
end

"""
1. calculating the growth of A trunk 
2. calculating the cumulated growth 
"""


growth_setp = growth(df[!, :dendrometre])
cumul_growth_setp = cumulated_growth(growth_setp)


"""
1. making a dataframe 
2. exporting calculations as an excel file 
"""

df_A1 = DataFrame(Growth=growth_setp, cumul=cumul_growth_setp)
XLSX.writetable("arbre_A1.xlsx", df_A1)

