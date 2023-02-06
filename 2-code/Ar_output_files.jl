begin
    using DataFrames
    using XLSX
    using CSV
    using Statistics
end

# read all interested files 

R1 = DataFrame(XLSX.readtable("./4-output_files/Compil_df_raddianna_R1.xlsx", "Feuil1"))
R4 = DataFrame(XLSX.readtable("./4-output_files/Compil_df_raddianna_R4.xlsx", "Feuil1"))
R5 = DataFrame(XLSX.readtable("./4-output_files/Compil_df_raddianna_R5.xlsx", "Feuil1"))
R10 = DataFrame(XLSX.readtable("./4-output_files/Compil_df_raddianna_R10.xlsx", "Feuil1"))
R11 = DataFrame(XLSX.readtable("./4-output_files/Compil_df_raddianna_R11.xlsx", "Feuil1"))

# print files names for column selection 
names(R1)
names(R4)
names(R5)
names(R10)
names(R11)

## print Q3 groups for every tree 

Q3_R1 = select(R1, [:Dates, :R1_1h, :R1_2h, :R1_5h, :R1_1v])
Q2_R1 = select(R1, [:Dates, :R1_2v, :R1_3v, :R1_3h])
Q1_R1 = select(R1, [:Dates, :R1_4h, :R1_6h, :R1_7h])

Q3_R4 = select(R4, [:Dates, :R4_1v, :R4_2h, :R4_3v])
Q2_R4 = select(R4, [:Dates, :R4_4h, :R4_5h])
Q1_R4 = select(R4, [:Dates, :R4_2v, :R4_1h, :R4_3h])

Q3_R5 = select(R5, [:Dates, :R5_1v, :R5_1h, :R5_3h])
Q2_R5 = select(R5, [:Dates, :R5_2h, :R5_4h, :R5_5h, :R5_6h])
Q1_R5 = select(R5, [:Dates, :R5_7h]) # 4v missing 

Q3_R10 = select(R10, [:Dates, :R10_1v, :R10_1h, :R10_2h])
Q2_R10 = select(R10, [:Dates, :R10_3h, :R10_6h])
Q1_R10 = select(R10, [:Dates, :R10_4h, :R10_5h])

Q3_R11 = select(R11, [:Dates, :R11_2v, :R11_1h, :R11_5h])
Q2_R11 = select(R11, [:Dates, :R11_1v, :R11_2h, :R11_3h])
Q1_R11 = select(R11, [:Dates, :R11_4h, :R11_6h])

## Dataframes for everey group 

Q3_Ar = leftjoin(Q3_R1, Q3_R4, on=:Dates)
Q3_Ar = leftjoin(Q3_Ar, Q3_R5, on=:Dates)
Q3_Ar = leftjoin(Q3_Ar, Q3_R10, on=:Dates)
Q3_Ar = leftjoin(Q3_Ar, Q3_R11, on=:Dates)
XLSX.writetable("Q3_Ar.xlsx", Q3_Ar)

describe(Q3_Ar)


Q2_Ar = leftjoin(Q2_R1, Q2_R4, on=:Dates)
Q2_Ar = leftjoin(Q2_Ar, Q2_R10, on=:Dates)
Q2_Ar = leftjoin(Q2_Ar, Q2_R11, on=:Dates)
Q2_Ar = leftjoin(Q2_Ar, Q2_R5, on=:Dates)
XLSX.writetable("Q2_Ar.xlsx", Q2_Ar)

describe(Q2_Ar)


Q1_Ar = leftjoin(Q1_R1, Q1_R4, on=:Dates)
Q1_Ar = leftjoin(Q1_Ar, Q1_R5, on=:Dates)
Q1_Ar = leftjoin(Q1_Ar, Q1_R10, on=:Dates)
Q1_Ar = leftjoin(Q1_Ar, Q1_R11, on=:Dates)
XLSX.writetable("Q1_Ar.xlsx", Q1_Ar)

describe(Q1_Ar)


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

Q3_Ar_data = select(Q3_Ar, Not(:Dates))
Q2_Ar_data = select(Q2_Ar, Not(:Dates))
Q1_Ar_data = select(Q1_Ar, Not(:Dates))

# define functions to calculate mean from each root 

roots_mean = []
for i in eachcol(Q2_Ar_data)
    i
    moy = Moyenne(i)
    append!(roots_mean, moy)
end

roots_min = []
for i in eachcol(Q2_Ar_data)
    i
    moy = Minim(i)
    append!(roots_min, moy)
end

roots_maxim = []
for i in eachcol(Q2_Ar_data)
    i
    moy = Maxim(i)
    append!(roots_maxim, moy)
end

## print Q2 dataframe with calculated values Mean, Min and Max 

Q2_Ar_data_describe = DataFrame(roots=names(Q2_Ar_data), max_growth=roots_maxim, mean_growth=roots_mean) # delete roots growth min values 
XLSX.writetable("Q2_Ar_data_describe.xlsx", Q2_Ar_data_describe)

## print Q3 dataframe with calculated values Mean, Min and Max 

Q3_Ar_data = DataFrame(XLSX.readtable("./Q3_Ar.xlsx", "Sheet1"))
select!(Q3_Ar_data, Not(:Dates)) # avoid :Dates column 

roots_mean = []
for i in eachcol(Q3_Ar_data)
    i
    moy = Moyenne(i)
    append!(roots_mean, moy)
end

roots_min = []
for i in eachcol(Q3_Ar_data)
    i
    moy = Minim(i)
    append!(roots_min, moy)
end

roots_maxim = []
for i in eachcol(Q3_Ar_data)
    i
    moy = Maxim(i)
    append!(roots_maxim, moy)
end


Q3_Ar_data_describe = DataFrame(roots=names(Q3_Ar_data), max_growth=roots_maxim, mean_growth=roots_mean) # delete roots growth min values 
XLSX.writetable("Q3_Ar_data_describe.xlsx", Q3_Ar_data_describe)

## print Q1 dataframe with calculated values Mean, Min and Max 


Q1_Ar_data = DataFrame(XLSX.readtable("./Q1_Ar.xlsx", "Sheet1"))
select!(Q1_Ar_data, Not(:Dates)) # avoid :Dates column 

roots_mean = []
for i in eachcol(Q1_Ar_data)
    i
    moy = Moyenne(i)
    append!(roots_mean, moy)
end

roots_min = []
for i in eachcol(Q1_Ar_data)
    i
    moy = Minim(i)
    append!(roots_min, moy)
end

roots_maxim = []
for i in eachcol(Q1_Ar_data)
    i
    moy = Maxim(i)
    append!(roots_maxim, moy)
end


Q1_Ar_data_describe = DataFrame(roots=names(Q1_Ar_data), max_growth=roots_maxim, mean_growth=roots_mean) # delete roots growth min values 
XLSX.writetable("Q1_Ar_data_describe.xlsx", Q1_Ar_data_describe)