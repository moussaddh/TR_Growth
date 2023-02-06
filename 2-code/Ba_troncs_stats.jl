begin
    using DataFrames
    using XLSX
    using Statistics
end

using Revise # for tacking into account orther changements 
includet("../2-code/Functions.jl") # for tacking into acount Functions.jl file  
using .Growth_functions # caling the Growth_functions module 

######## B9 
df = DataFrame(XLSX.readtable("./1-data/Dahra_Compil_tronc.xlsx", "Balanites"))
Df_B9 = filter(:ID => x -> x .== "B9", df)

growth_setp = growth(Df_B9[!, :Dendro_Plast])
cumul_growth_setp = cumulated_growth(growth_setp)

col_dates = Df_B9[!, :Date] # taking the date column
selected = col_dates[1:end-1] # selected rows acording  to the growth applied function 
length(selected) # cheking for the length


df_B9 = DataFrame(Dates=selected, Growth_mm=growth_setp, cumul_mm=cumul_growth_setp)
XLSX.writetable("Tronc_B9.xlsx", df_B9)

######## B15 
df = DataFrame(XLSX.readtable("./1-data/Dahra_Compil_tronc.xlsx", "Balanites"))
Df_B15 = filter(:ID => x -> x .== "B15", df)

growth_setp = growth(Df_B15[!, :Dendro_Plast])
cumul_growth_setp = cumulated_growth(growth_setp)

col_dates = Df_B15[!, :Date] # taking the date column
selected = col_dates[1:end-1] # selected rows acording  to the growth applied function 
length(selected) # cheking for the length


df_B15 = DataFrame(Dates=selected, Growth_mm=growth_setp, cumul_mm=cumul_growth_setp)
XLSX.writetable("Tronc_B15.xlsx", df_B15)

######## B11
df = DataFrame(XLSX.readtable("./1-data/Dahra_Compil_tronc.xlsx", "Balanites"))
Df_B11 = filter(:ID => x -> x .== "B11", df)

growth_setp = growth(Df_B11[!, :Dendro_Plast])
cumul_growth_setp = cumulated_growth(growth_setp)

col_dates = Df_B11[!, :Date] # taking the date column
selected = col_dates[1:end-1] # selected rows acording  to the growth applied function 
length(selected) # cheking for the length


df_B11 = DataFrame(Dates=selected, Growth_mm=growth_setp, cumul_mm=cumul_growth_setp)
XLSX.writetable("Tronc_B11.xlsx", df_B11)