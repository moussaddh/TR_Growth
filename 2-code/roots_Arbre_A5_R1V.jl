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

df = DataFrame(XLSX.readtable("./1-data/Niakhar_Compil_racines.xlsx", "Feuil1")) # reading data

let
    @subset!(df, :arbre .== "A5")
    @subset!(df, :racine .== "R1V")
end


growth_setp = growth(df[!, :dendrometre])
cumul_growth_setp = cumulated_growth(growth_setp)



length(growth_setp) #  cheking for the length
length(cumul_growth_setp) # cheking for the length
length(df[!, :date]) # cheking for the length

col_dates = df[!, :date] # taking the date column
selected = col_dates[1:end-1] # selected rows acording  to the growth applied function 
length(selected) # cheking for the length

df_arbre_A5_R1V = DataFrame(Dates=selected, Growth_mm=growth_setp, cumul_mm=cumul_growth_setp)
XLSX.writetable("arbre_R5_R1V.xlsx", df_arbre_A5_R1V)