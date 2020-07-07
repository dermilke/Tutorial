### R_Lesson_3

rm(list=ls(all=T))

# This lesson is all about tables and plotting! You will learn how to import datasets, create tables from vectors,
# manipulate tables, filter them according to some parameters and so on. 
# This section is all about the STRENGTH of R!!! (compared to other programming languages)

# Our first task will be: Create a table from our two vectors temperature and salinity!
# In one of the exercises you learned for that purpose the function cbind()

temperature = c(10, 12, 15, 13, 18)
salinity = c(30, 29, 28, 30, 31)

cbind(temperature, salinity, c(1,2,3,4,5))

# the outcome of that function needs to be analysed:
# First, you see rows and columns. Both have names:
# Column-Names are the names of the vectors you used in cbind() - R does that automatically. It just assumes the vector names
# should be the right names for the table-columns. Mostly that's correct ;-)
# Row-Names are the [,1] and [,2] and so on. Those "names" are not very meaningful for us. 
# In general, I don't recommend to create rownames, they are misleading. It is much easier to have an extra column with 
# Sample_IDs that contain the sample-names. 

# Okay i alread made an assumption: Rows are samples. Columns are parameters.

# This is the typical way to store environmental (or other) data. Many functions also rely on this format, just because it is so
# widely distributed. (which is unfortunately not true for every package)

table = cbind(temperature, salinity)

class(table)

# The class is "matrix" this is one of several ways to store a table. This is usually not the most common one, you will learn another
# format in a few minutes. 
# A class can take only one type of elements, in this case it contains numeric elements. What happens if we try to add
# a character vector to the matrix?!

cbind(table, c("A", "B", "C", "D", "E"))

# It automatically conerts all other elements in the matrix to character-type, indicated by the quotation marks!!! e.g. "10"
# Be careful when working with matrix tables! This happened silently, but can cause serious problems later in your script/recipe. 

# There is another function that gives us "attributes". This is a very technical term and you will probably never ever use 
# attributes of an R-Object (i.e. vector, matrix etc.). 
# They tell you things about the type of object, like its length. Let's check it out

attributes(table)

# We have 3 attributes: Dim (stands for dimensions), dimnames[[1]] (names of first dimension), dimnames[[2]] (names of second 
# dimension). 
# We already checked out the names, we saw that we didn't have any rownames, or at least they looked very cryptically. You 
# will see in a second what their meaning is. But technically, we dont have any rownames, which is why dimnames[[1]] = NULL.
# And dimnames[[2]] = "temperature" "salinity" are our column-names. 
# We see that the first dimension are the rows, the second dimension are the columns.
# We have a length of 5 in the first dimension and a length of 2 in the second dimension. (or in other words: we have 5 rows and
# 2 columns) This explains the "dim" attribute.

# Now let's check out the rownames, what they actually meant:
table

table[,1]

table[2,]

# So, the rownames show us how to access rows from tables. It's similar to accessing elements from vectors.
# This also works for the columns:
table[,1]
table[,2]
# But you see, the names disappeared. This is, because there was a silent conversion from matrix to a vector.
# R differentiates between those two data formats.
# When we check the class of it:
class(table[,1])
class(table[1,])
# Both are the same "numeric". It doesnt say vector, just because R doesnt use that name. Instead it uses the type of variables
# that are stored in that vector. See for example:
class(c("a", "b", "c"))
class("a")
class(c(TRUE, FALSE))
# The vector and the single element have the same class. Why? Just because a single entry is a special case of a vector with 
# length = 1. 
# R just knows how to differentiate between vectors and tables.

# Okay now that's already very technical and you probably will never use that knowledge in the first place. But i think it is
# important to know at least a little bit that there are different kind of objects (vectors, tables) and how they 
# are treated by R.

# So you got vectors so far when you accessed rows or columns, but you can combine both to get single numbers as well. Try to get 
# the second value from the first column:
table[2,1]
# that worked perfectly. 

# Let's try if the column names work as well to get the column-values from the table
table[temperature]

# What happened?! Temperature didn't even have a value of 31. But salinity had. 
# To break it appard, we entered the following:
# temperature is a vector with the values (10, 12, 15, 13, 18). 
# When we enter table[temperature] it is the following: table[c(10, 12, 15, 13, 18)]
# We use a vector as index and try to get all the elements with the index-numbers 10, 12, 15, 13, 18 from the table.
# But we only have 10 values stored

# So the first element will give us the 10th value from the table, which is the last entry of salinity (31)
# all the other elements from the temperature vector are >10, they will result in NA because there aren't entries with index >10.

# What you learned is: You can access elements from the table not only by using their row-position and column-position,
# but also by their absolute position. Try it out and see how the order looks like, is it rowwise or columnwise?!
table[2]
table[6]
table[7]

# It is usually always better to youse rowposition, columnposition to access single elements within a table. This is more 
# explicit than using the absolut position, especially when you try to understand how the code works.

# Our table is still a matrix. And you probably know from school-math that matrices are a mathematical construct in linear algebra.
# You can do special mathematical operations with them, like matrix-multiplication and so on. But that's not what we need,
# when we just want to work with our data. Not every dataset is a matrix, actually the fewest are!!!

# We just need a format of a table where we can store data in and access this data easily. And the format of choice needs to
# be able to store not only one kind of variables (like characters), but a combination of different kinds (characters, numbers ...).

# And typically, every row is one sample, every column is one parameter. So we also need column-names that tell us which parameter
# is which column (we will ignore row-names, even though they exist, but for the above mentioned reasons).

# But if we have this format, every row is one sample + every column is one parameter, we have one constraint:
# Every column needs to have the same length! That just means: every sample that we have must have been measured for every parameter
# in our data. Or it needs to have an NA entry! BUT it can not be, that temperature has another length than salinity!!!

# R calls this data format: data.frame

table_df = data.frame(temperature, salinity)
table_df

table_df$salinity

class(table_df)
attributes(table_df)

# Argh, it automatically produces rownames! Let's try to avoid that
data.frame(temperature, salinity, row.names = NULL)
# Come on, why does it not work?! Why does R want me to have rownames?!
# Sometimes R is a pain in the ass!!!

# You will see later that, thanks to the R-community, there is a solution for that problem. But now we need to face the fact that
# there are rownumbers displayed in the output. Just ignore them ;)

# The data.frame format gives us more options on how to access elements from it. There is one important way to do that, look:
table_df$temperature
table_df$salinity


# The syntax is easy: tablename$parametername
# And R-Studio also includes an auto-complete for that (similar to the tab in BASH).

# This way of extracting columns from a data.frame is very useful, especially because it is very readable (easy to understand) and
# will result in less errors. Just because, maybe for any reason the second column is not salinity, but another parameter. 
# But in your code you always assumed the second column is salinity, so you maybe wrote table_df[,2] to access salinity.
# This only works if the second column is salinity, so in our special case you get a silent error!!! Just because the syntax
# is completely right and R doesn't recognize an error. (those errors are the worst!!!)

# So, from now on try to use the $-way to access columns. And if this doesn't work, you are probably working with matrices. 
# Then convert the matrix into a data.frame. Yeah conversion is a big point actually, look:

class(table)

table_converted = as.data.frame(table)
class(table_converted)

as.numeric()
as.logical()
as.character()
as.matrix()

# There exists a conversion function for nearly every type of object. That means, you can also try to use the conversion to
# make a numerical vector into a character vector:

numbers = c(2,3,4,5)
class(numbers)
as.character(numbers)
class(as.character(c(2,3,4)))

# Some conversions make no sense:
as.logical(numbers)
# but they work! So be careful using conversions!

# Usually, you will rarely create complete tables within R, mostly you import your data that you created using Excel or similar 
# programs. So let's import a .csv file (you remember, the comma-seperated-files?!)

# First check the working directory, which is now important when we want to access files on our computer:
getwd()
setwd("/Users/felixmilke/PhD/SoftwareBuilds/Tutorial")
list.files()

# Cool, there is a file called Environment_Data.csv in my current working directory. That's the one i will import into R
Environment_Import = read.csv("Environment_Data.csv")

# So the function is called read.csv()
# There are similar functions like read.delim() or read.dcf()
# Read the documentation for those function if you are unsure what you need. Typically i recommend to always use .csv
# and if that doesn't work use read.delim() and specify the delimiter manually as an argument within the function call, like that:
read.delim("Environment_Data.csv", sep = ",")

# You can also specify the decimal-symbol with the argument dec = "." (or "," or whatever)

# Now we can start looking at the data, the first thing a data-scientist does! We need to see how it looks like
# There is a nice function that gives us some valid information. You see, the table has an enourmos amount of different
# parameter. 
str(Environment_Import)
# You see all the parameter names and what kind of variable they are. Also, you see some of the values within the parameter.
# Most parameter are numeric or integer, but there is something new called "Factor"

# Sorry but yeah there is still another kind of variable. This is the last i will show you, i promise ;-)
# A factor is a little bit more complicated to explain. Because it consists of 2 things:

# 1. A vector including all the vector elements. This vector is usually displayed as text elements. Lets look at one:
Environment_Import$Salinity
# So we see the vector elements, which are either SO248 or SO254
# But you also see that R doesn't use "" quotation marks for the text! So, something is different.
Environment_Import$Cruise[1]

# Here you see again the first element of the vector, but also:
# 2. The factor-levels!!! 
# So, a factor was designed for parameters that do not measure numbers. And because they dont measure numbers, the elements of 
# this parameter have no order! You can not say: SO248 is bigger than SO254. 
# Instead, those parameter have a specific amount of "realisations"! They can only be one of the entries from the factor-levels.

# This is why we need two elements in a factor: 
# 1. The measured realisation of the parameter
# 2. the theoretically probable cases that we might measure.

# In this case, both probable cases were realized, we find SO248 and SO254 in our data. But there might be cases,
# where you design a questionnaire and one of the questions, for example your favourite color, is a multiple-choice question with
# 5 different answers: red, blue, green, yellow, black.
# For any reason, no one of the respondents did choose black as his favourite color.
# If we would have created a normal character-vector for that, we might think that black was not chosen because it was not in the
# list of possible colors. But instead there was just no person that chose black, which is of course a valid information!

# So this is why we have to differentiate between realization and possible levels. 

# Generally, you can do nearly every task within R with a character vector as well as with a factor, this is why many people dont
# like the automatic conversion into factors when R imports data as a data.frame. 
# Also sometimes factors are harder to work with, just because they always carry this extra information "levels". This is something
# you will have to experience yourself when working with data. But now you know what a factor is and how to deal with it.

# We can now also easily convert the factor into a character:
as.character(Environment_Import$Cruise)

# To save this conversion, we have of course to assign it back to where it came from! 
Environment_Import$Cruise = as.character(Environment_Import$Cruise)

Environment_Import$Station[1:290] = -1:-290

# Check it:
str(Environment_Import)
# Now that variable is a chr (character)! Well done!

# You also saw that you can assign directly the parameter of that table in the way we did it above.
# Of course that also works with the other ways as well:
Environment_Import[,1] = as.character(Environment_Import$Cruise)

Environment_Import[1:5,]

# One more fact: Matrix and Data.Frames are both subcategories of another table-type.
# This table-type is called List!
# This table type has nearly no restrictions. You can put vectors of different length and different type into the same list.

temperature = c(11,12,13,19)
salinity = c(31,30,29,30,30,38)

data.frame(temperature, salinity)

province = c("NATL", "NAGR", "SPLR", "FKLD")

example_list = list(Temp = temperature, Sal = salinity, Prov = province)
example_list

class(example_list)

# You see, the output is not what we would expect if we want to look at a table. Here, every parameter has its own line and can
# be accessed by its name.
class(example_list$Temp)

example_list[,1]
# But this way of accessing the vectors won't work anymore! Instead you need to first access the object number within the list
# (easily: first object: number 1, second object: number 2 etc.)

temp_vector = example_list[1]

# And now you still have a list but reduced to only the first object within the list!
class(example_list[1])
# Well, that's not very helpful we want to have the parameter as a vector, not as a list! Because lists are very complicated to 
# handel!!! To extract a single object from a list, you need to write the following:
example_list[[1]]
class(example_list[[1]])
# Nice, now we have the numeric vector we were looking for ;-)

# So, whenever you encounter the [[]] double brackets, you can be sure that this is because you are handling lists. 

# Recap:
# - We have the following datatypes:
# https://cloudstorage.elearning.uni-oldenburg.de/s/eo5HoBiNotWZaSd
#
# - There are all kind of conversions possible with the as.XXX() functions! 
# - For our data we usually always use data.frames
# - We know how to access the data from a data.frame in different ways. 
