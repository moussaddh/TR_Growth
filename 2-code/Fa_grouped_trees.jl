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

df = DataFrame(XLSX.readtable("./1-data/Niakhar_Compil_tronc.xlsx", "tri_Dendrometre")) # reading data
filter!(:arbres => x -> x .!= "A18", df)
filter!(:ficelles => x -> x .== "F1", df)
df[!, :date] = string.(df[!, :date]) # convert type any array to string 
df_bigening = filter(:date => x -> x .== "2020-11-16", df)
df_bigening.grp = cut(df_bigening[!, :circonference], 3)

# XLSX.writetable("grp.xlsx", df_bigening) # not working cause of :date column to string transformation in 17 

df_bigening_Q3 = filter(:grp => x -> x .== "Q3: [175.5, 231.5]", df_bigening)
df_bigening_Q2 = filter(:grp => x -> x .== "Q2: [145.9, 175.5)", df_bigening)
df_bigening_Q1 = filter(:grp => x -> x .== "Q1: [102.0, 145.9)", df_bigening)

# avoid the date column 

select!(df_bigening_Q3, Not([:date]))
select!(df_bigening_Q2, Not([:date]))
select!(df_bigening_Q1, Not([:date]))

df_bigening_Q3
df_bigening_Q2
df_bigening_Q1
