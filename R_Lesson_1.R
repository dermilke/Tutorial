#### Welcome to R! This is the "cookbook" and you read comments right now! They won't get executed in case you try to run the whole
#### recipe. Use the comments as much as you can/need, they help you understand whats going on in your recipe. 
#### Every good chef does that ;-)

# First of all: Lets remove everything R knows (usually that is nothing, the first time you open R! But it's good practice to start
# your recipes by doing that. Just like cleaning your kitchen before starting to cook.)
rm(list=ls(all=T))
# Okay, you dont need to understand that line of code now! Maybe the "rm" seems familiar from the BASH, but that's just 
# a coincidence

# R is pretty good at math, you can just try to give him tasks like
4+5
12-321
2*2
0/5
5/0
# yeah, that's infinity... 
Inf + 5
# still infinity!

5^2
sqrt(4)
exp(1)

# Unlike in BASH, spaces are not that strict when you write your code! Both lines do the same:
2   + 5
2+5
2   +5 
# Even the Tab does not affect the result
# Try to use that, to write your code in a tidy way! Use indents and new lines to create "chunks of code" 
# Like chapters in Books!

# Also, dont hesitate to create new recipes, instead of writing just one recipe after the other! That's not how Chefs would handle it!

# now lets try some variables, to make a^2 + b^2 = c^2
a = 5
b = 2
c = sqrt(a^2 + b^2)
# Check the environment on the top right corner, there you see the results! Thats not very handy. There are better ways:
a
b
c

# You only used single numbers! But imagine you want to use tables, those tables are made of columns. For example one column
# where you save all the temperatures of your cultures! Let's assume this Temperature-Column has 5 different Temperatures:
# 10, 15, 20, 25, 30 Degrees Celsius. 
# This kind of data is stored in a "vector". It's a variable that stores more than 1 value:
temperature = c(10, 15, 20, 25, 30)
# You can create those vectors by using : c(number_1, number_2, number_3, ...)
# The result looks like that:
temperature

# When you want to do the same math as above with this vector, every element of that vector will be affected:
temperature * 5
temperature / 10

# Now lets look at how one vector behaves with another:
salinity = c(28, 30, 32, 30, 31)

temperature * salinity
# Well that works! Even though this calculation makes absolutely no sense at all!
# But what if one of the vectors has another length:
salinity = c(28, 30, 32, 30)

temperature * salinity
# It works, BUT you get a warning message! Read all the red messages from R carefully, they usually tell you what's going wrong. 
# Even if your script is working, a warning message may be a hint that the result you produce might not be the desired one. 

# Anyway, can you guess what happened in this case?!

# It would be nice if we could check how long the vector is before doing this accidentally again:
# That's how you are going to learn what a "function" is!

# A function is like a Command in BASH! It is another recipe that another user wrote once for everyone to use. You already used 
# a function, not knowing it was one:
# c()
# And this function already gives you a hint how they look like: function_name(input_1, input_2, input_3, ...)

# Like the commands in BASH, every function in R has its own input-varaibles and option parameters. To highlight the differences,
# let's assume we have an odd number:
d = 1.414213562
# This one is 1.41... but we want it to be round! there is a simple function for that, which requires an input but also has the 
# possibility for the user to specify an option-parameter that controls the number of digits to be round at:

round(d)
round(d, digits = 2)

# You see, both function-calls work! (wow fancy word, a function call! Keep that in mind, that's how cool programming nerds call
# it if you run a function)

round()
# But the first input is mandatory, otherwise R will produce an error.

# This behaviour, which arguments are optional, which are mandatory, are completely random for every function! It just depends on the
# cook who invented the recipe of that function! To see which arguments exist for which function, check the Help on the right. 
# Also, google is again your best friend!

### OKAY lets get back to the initial task: We want to know the length of a vector before using it for our calculations.
# Handy function: length()

length(temperature)
length(salinity)

# Nice! We see temperature is longer than salinity. Okay, but the computer just knows two numbers, it has no judge whether 
# something is good or bad.

# Okay, that's not 100 percent true. It knows one thing: True and False! As it is pretty good in math, it can see if a number
# is equal to another number, or in general: if a mathematical statement is correct! 
# Let's try that out. To check numbers there are a couple of possibilities:

# number_1 EQUAL number_2
# number_1 BIGGER number_2
# number_1 SMALLER number_2
# number_1 UNEQUAL number_2

# And in R:

2 == 2
2 > 1
1 < 2
1 != 2

# They all produce one outcome: TRUE! But what if something is not correct:

2 == 1

# It's FALSE!!! Remember that, R knows if something is TRUE or FALSE! 
# Okay lets use that to check our length-issue:

length(salinity) == length(temperature)

# It's FALSE! Well done, R ;-)

# This is called a logical expression, or just BOOLEAN. 
# A boolean is also the kind of variable that stores "TRUE" or "FALSE".. 
# What does that mean, are there other kinds of variables?! Yes there are:
# double: number with digits like 3.2145
# integer: numbers without digits like 2 or 3 or 6 .....
# character: This are all numbers and letters that are interpreted as TEXT! They are defined with quotation marks: 
"3+5 is a number"
# Each letter in this text is one character. Together, they are a STRING! you can also have a vector of strings:
c("String_1", "String_2", "String_3", "...")

# Boolean: Yeah you know, the result of a logical expression! TRUE or FALSE! They can also exist as vectors:
c(1, 2, 3) == c(2, 3, 3)

# Those are the important variable-types! There are even more, but most of them you rarely encounter in your daily praxis. 
# Some special variable-types you might get in trouble with are
NULL # -> refers to NOTHING!! literally! 
NA   # -> refers to: Missing observation! For example, you forgot to measure Temperature at one of your timepoints, then this entry
     #               would be NA. You will get in trouble with this one pretty often, I assure you!!
NaN  # -> Stands for Not a Number. You rarely stumble upon this one ;-) 
Inf  # -> Infinity.. you already saw it! There is also a -Inf


# RECAP: 
# You learned about the following:
# - Mathematical operations in R
# - Variables
# - Vectors
# - Functions
# - Variable-Types

## This is the first foundation to build on! 
