begin
    using DataFrames
    using XLSX
    using CSV
    using Statistics
end

# read all interested files 

B3 = DataFrame(XLSX.readtable("./4-output_files/Compil_df_balanites_B3.xlsx", "Feuil1"))
B4 = DataFrame(XLSX.readtable("./4-output_files/Compil_df_balanites_B4.xlsx", "Feuil1"))
B9 = DataFrame(XLSX.readtable("./4-output_files/Compil_df_balanites_B9.xlsx", "Feuil1"))
B11 = DataFrame(XLSX.readtable("./4-output_files/Compil_df_balanites_B11.xlsx", "Feuil1"))
B16 = DataFrame(XLSX.readtable("./4-output_files/Compil_df_balanites_B16.xlsx", "Feuil1"))

# print files names for column selection 
names(B3)
names(B4)
names(B9)
names(B11)
names(B16)

## print Q3 groups for every tree 

Q3_B3 = select(B3, [:Dates, :B3_1v, :B3_2h, :B3_5v])
Q2_B3 = select(B3, [:Dates, :B3_2v, :B3_6v, :B3_3h])
Q1_B3 = select(B3, [:Dates, :B3_1h, :B3_3v, :B3_4v])

Q3_B9 = select(B9, [:Dates, :B9_1v, :B9_2v, :B9_1h, :B9_3h])
Q2_B9 = select(B9, [:Dates, :B9_2h, :B9_4h, :B9_5h])
Q1_B9 = select(B9, [:Dates, :B9_3v, :B9_4v, :B9_5v])

Q3_B4 = select(B4, [:Dates, :B4_1v, :B4_2v, :B4_4v, :B4_1h])
Q2_B4 = select(B4, [:Dates, :B4_3v, :B4_5v, :B4_5h])
Q1_B4 = select(B4, [:Dates, :B4_2h, :B4_3h, :B4_4h]) # 4v missing 

Q3_B11 = select(B11, [:Dates, :B11_1v, :B11_3v, :B11_4v, :B11_5v])
Q2_B11 = select(B11, [:Dates, :B11_1h, :B11_2h, :B11_4h, :B11_5h])
Q1_B11 = select(B11, [:Dates, :B11_2v, :B11_3h])

Q3_B16 = select(B16, [:Dates, :B16_1v, :B16_2v, :B16_1h, :B16_4h])
Q2_B16 = select(B16, [:Dates, :B16_4v, :B16_5v, :B16_2h])
Q1_B16 = select(B16, [:Dates, :B16_3h, :B16_3v, :B16_5h])

## Dataframes for everey group 

Q3_Ba = leftjoin(Q3_B3, Q3_B9, on=:Dates)
Q3_Ba = leftjoin(Q3_Ba, Q3_B4, on=:Dates)
Q3_Ba = leftjoin(Q3_Ba, Q3_B11, on=:Dates)
Q3_Ba = leftjoin(Q3_Ba, Q3_B16, on=:Dates)
XLSX.writetable("Q3_Ba.xlsx", Q3_Ba)

describe(Q3_Ba)


Q2_Ba = leftjoin(Q2_B3, Q2_B9, on=:Dates)
Q2_Ba = leftjoin(Q2_Ba, Q2_B4, on=:Dates)
Q2_Ba = leftjoin(Q2_Ba, Q2_B11, on=:Dates)
Q2_Ba = leftjoin(Q2_Ba, Q2_B16, on=:Dates)
XLSX.writetable("Q2_Ba.xlsx", Q2_Ba)

describe(Q2_Ba)


Q1_Ba = leftjoin(Q1_B3, Q1_B9, on=:Dates)
Q1_Ba = leftjoin(Q1_Ba, Q1_B4, on=:Dates)
Q1_Ba = leftjoin(Q1_Ba, Q1_B11, on=:Dates)
Q1_Ba = leftjoin(Q1_Ba, Q1_B16, on=:Dates)
XLSX.writetable("Q1_Ba.xlsx", Q1_Ba)

describe(Q1_Ba)


# define funtionc to compute mean , min and max of growth for every root

function Moyenne(col)
    return mean(col)
end


function Minim(col)
    return minimum(col)
end


function Maxim(col)
    return maximum(col)
end

# deleting :Dates column from data

Q3_Ba_data = select(Q3_Ba, Not(:Dates))
Q2_Ba_data = select(Q2_Ba, Not(:Dates))
Q1_Ba_data = select(Q1_Ba, Not(:Dates))

# define functions to calculate mean from each root 

roots_mean = []
for i in eachcol(Q2_Ba_data)
    i
    moy = Moyenne(i)
    append!(roots_mean, moy)
end

roots_min = []
for i in eachcol(Q2_Ba_data)
    i
    moy = Minim(i)
    append!(roots_min, moy)
end

roots_maxim = []
for i in eachcol(Q2_Ba_data)
    i
    moy = Maxim(i)
    append!(roots_maxim, moy)
end

## print Q2 dataframe with calculated values Mean, Min and Max 

Q2_Ba_data_describe = DataFrame(roots=names(Q2_Ba_data), max_growth=roots_maxim, mean_growth=roots_mean) # delete roots growth min values 
XLSX.writetable("Q2_Ba_data_describe.xlsx", Q2_Ba_data_describe)

## print Q3 dataframe with calculated values Mean, Min and Max 

roots_mean = []
for i in eachcol(Q3_Ba_data)
    i
    moy = Moyenne(i)
    append!(roots_mean, moy)
end

roots_min = []
for i in eachcol(Q3_Ba_data)
    i
    moy = Minim(i)
    append!(roots_min, moy)
end

roots_maxim = []
for i in eachcol(Q3_Ba_data)
    i
    moy = Maxim(i)
    append!(roots_maxim, moy)
end

## print Q2 dataframe with calculated values Mean, Min and Max 

Q3_Ba_data_describe = DataFrame(roots=names(Q3_Ba_data), max_growth=roots_maxim, mean_growth=roots_mean) # delete roots growth min values 
XLSX.writetable("Q3_Ba_data_describe.xlsx", Q3_Ba_data_describe)

## print Q1 dataframe with calculated values Mean, Min and Max 


roots_mean = []
for i in eachcol(Q1_Ba_data)
    i
    moy = Moyenne(i)
    append!(roots_mean, moy)
end

roots_min = []
for i in eachcol(Q2_Ba_data)
    i
    moy = Minim(i)
    append!(roots_min, moy)
end

roots_maxim = []
for i in eachcol(Q1_Ba_data)
    i
    moy = Maxim(i)
    append!(roots_maxim, moy)
end

## print Q2 dataframe with calculated values Mean, Min and Max 

Q1_Ba_data_describe = DataFrame(roots=names(Q1_Ba_data), max_growth=roots_maxim, mean_growth=roots_mean) # delete roots growth min values 
XLSX.writetable("Q1_Ba_data_describe.xlsx", Q1_Ba_data_describe)