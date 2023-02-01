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

df = DataFrame(XLSX.readtable("./1-data/Dahra_Raw_SI_tronc.xlsx", "Balanites")) # reading data
df[!, "Dates "] = string.(df[!, "Dates "]) # convert type any array to string 
df.grp = cut(df[!, :"C_130Trait (cm)"], 3)

# XLSX.writetable("grp.xlsx", df_bigening) # not working cause of :date column to string transformation in 17 

df_Q3 = filter(:grp => x -> x .== "Q3: [109.0, 157.5]", df)
df_Q2 = filter(:grp => x -> x .== "Q2: [93.5, 109.0)", df)
df_Q1 = filter(:grp => x -> x .== "Q1: [53.0, 93.5)", df)

df_Q3
df_Q2
df_Q1
