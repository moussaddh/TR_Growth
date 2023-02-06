begin
    using DataFrames
    using XLSX
    using Statistics
end

using Revise # for tacking into account orther changements 
includet("../2-code/Functions.jl") # for tacking into acount Functions.jl file  
using .Growth_functions # caling the Growth_functions module 

######## R1 
df = DataFrame(XLSX.readtable("./1-data/Dahra_Compil_tronc.xlsx", "Raddianna"))
Df_R1 = filter(:ID => x -> x .== "R1", df)

growth_setp = growth(Df_R1[!, :Dendro_Plast])
cumul_growth_setp = cumulated_growth(growth_setp)

col_dates = Df_R1[!, :Date] # taking the date column
selected = col_dates[1:end-1] # selected rows acording  to the growth applied function 
length(selected) # cheking for the length


df_A1 = DataFrame(Dates=selected, Growth_mm=growth_setp, cumul_mm=cumul_growth_setp)
XLSX.writetable("Tronc_R1.xlsx", df_A1)

######## R10 
df = DataFrame(XLSX.readtable("./1-data/Dahra_Compil_tronc.xlsx", "Raddianna"))
Df_R10 = filter(:ID => x -> x .== "R10", df)

growth_setp = growth(Df_R10[!, :Dendro_Plast])
cumul_growth_setp = cumulated_growth(growth_setp)

col_dates = Df_R10[!, :Date] # taking the date column
selected = col_dates[1:end-1] # selected rows acording  to the growth applied function 
length(selected) # cheking for the length


df_R10 = DataFrame(Dates=selected, Growth_mm=growth_setp, cumul_mm=cumul_growth_setp)
XLSX.writetable("Tronc_R10.xlsx", df_R10)

######## R11 
df = DataFrame(XLSX.readtable("./1-data/Dahra_Compil_tronc.xlsx", "Raddianna"))
Df_R11 = filter(:ID => x -> x .== "R11", df)

growth_setp = growth(Df_R11[!, :Dendro_Plast])
cumul_growth_setp = cumulated_growth(growth_setp)

col_dates = Df_R11[!, :Date] # taking the date column
selected = col_dates[1:end-1] # selected rows acording  to the growth applied function 
length(selected) # cheking for the length


df_R11 = DataFrame(Dates=selected, Growth_mm=growth_setp, cumul_mm=cumul_growth_setp)
XLSX.writetable("Tronc_R11.xlsx", df_R10)