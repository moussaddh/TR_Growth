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

df = DataFrame(XLSX.readtable("./1-data/Dahra_Raw_SI_racines.xlsx", "Racines")) # reading data
df[!, "Dates "] = string.(df[!, "Dates "]) # convert type any array to string 
df_begening = filter("Dates " => x -> x .== "2021-05-18", df)
df_begening_R11 = filter("Arbre " => x -> x .== "R11", df)
df_begening_R11.grp = cut(df_begening_R11[!, :"Trait_cm"], 3)

df_begening_R11_Q3 = filter(:grp => x -> x .== "Q3: [39.99999999999999, 78.0]", df_begening_R11)
df_begening_R11_Q2 = filter(:grp => x -> x .== "Q2: [30.0, 39.99999999999999)", df_begening_R11)
df_begening_R11_Q1 = filter(:grp => x -> x .== "Q1: [22.0, 30.0)", df_begening_R11)

df_begening_R11_Q3
df_begening_R11_Q2
df_begening_R11_Q1
