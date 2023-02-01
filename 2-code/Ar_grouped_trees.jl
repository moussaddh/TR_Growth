begin
    using DataFrames
    using Statistics
    using XLSX
    using DataFramesMeta
    using CSV
    using CategoricalArrays
end

using Revise # for tacking into account orther changements 
includet("../2-code/Functions.jl") # for tacking into acount Functions.jl file  
using .Growth_functions # caling the Growth_functions module 

df = DataFrame(XLSX.readtable("./1-data/Dahra_Raw_SI_tronc.xlsx", "radianna")) # reading data
df[!, "Dates "] = string.(df[!, "Dates "]) # convert type any array to string 
df.grp = cut(df[!, :"C_130Trait (cm)"], 3)

# XLSX.writetable("grp.xlsx", df_bigening) # not working cause of :date column to string transformation in 17 

df_Q3 = filter(:grp => x -> x .== "Q3: [125.0, 172.0]", df)
df_Q2 = filter(:grp => x -> x .== "Q2: [101.0, 125.0)", df)
df_Q1 = filter(:grp => x -> x .== "Q1: [46.5, 101.0)", df)

df_Q3
df_Q2
df_Q1
