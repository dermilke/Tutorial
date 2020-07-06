### R_Lesson_5

# Community Special!!!
# Unfortunately not my community, it's all about the R-People!!!

# Basic R is already very powerful and gives us an enourmous playground to try and write all kinds of recipes/algorithms.
# People in the community developed new functions for us that build on top of R's foundation of skillset and enriches it with
# an infinite amount of toolsets. 
# Those toolsets are called packages in the world of R.
# Packages are distributed by CRAN https://cran.r-project.org
# CRAN is nothing else than a network of different servers around the world that have access to one database of packages that
# they distribute among the R-users.
# To use those packages from the CRAN network, it takes us nothing else than the name of the package itself and one line of code:

install.packages("vegan")

# Running this command lets R search in the CRAN database for the package name and downloads it in case there is a match.
# This package will then be installed.

# Packages as well as R are updated frequently. Sometimes, you try to download a package from CRAN and it tells you an error that
# your R-Version is outdated for that package. When you download packages from CRAN you always get the current version, so sometimes
# you need to update your R-Version in order to play around with the desired toolset ;-)

# Once it is successfully installed on your computer, you have to activate that package. Only when it's activated, R has access
# to its functions. To activate an installed package just type:

library(vegan)

# Sometimes you get warnings or other messages, but that's okay. If you encounter errors there is probably a version-mismatch.
# So either you need to update your package or R itself. But let's consider this not a problem for now.

# Whenever you write a new script, it makes sense to activate your packages at the beginning of your code, right after you
# cleaned the Environment. This way, people browsing through your code can directly see if they have all it needs to run it or
# if they need to install tools beforehand.

# Remember, you need to INSTALL a package only ONCE! But you have to ACTIVATE it at the beginning of EVERY script!

# For this lesson, we need the tidyerse package https://www.tidyverse.org 
# This is a powerful collection of handy data science packages including ggplot2 and dplyr.

library(tidyverse)

# There is a very good introduction to Data Science written extra for this package. It is a mandatory starting point if you 
# like to improve your data-science skills using dplyr and ggplot! I totally recommend reading it. 
# https://r4ds.had.co.nz

# But now let's just use some basic ideas of the tidyverse. First lets start with some changes to our good old data.frame type

# The package tibble changes our data.frames into a better looking version with some additional constraints (for example it
# completely misses row-names! Thanks Tidyverse!!! And it does not convert character-parameter into factors! Yeah!)

# To create a tibble you have various options, from which the classical import option is the most used one. Instead of
# read.csv() we will use read_csv(). This import-function works in the same way as the read.csv() function, but automatically
# converts our data into a tibble. 

read_csv("Environment_Data.csv")
Environment_tibble = read_csv("Environment_Data.csv")

# You see the changes when you look at its output in the console. It looks much better, more informative. But it constraints
# its output to only as many parameters, as fit on the screen! 
# To have a better look at big tables, there is a handy function of R-Studio, called view():

view(Environment_tibble)

# Next big chapter to introduce is the dplyr vocabular. dplr is another famous package of Hadley Wickham, which is widely used 
# throuhout the data-science community. It reduces basic data-conversion tasks, such as filtering or manipulating of 
# columns, to single functions, which are quite powerful. Let's see:

filter(Environment_tibble, Pot_Temperature > 20)

# All dplyr functions need a dataframe or tibble as first argument. This imported dataframe is the dataset that will be manipulated
# throughout a dplyr workflow! The next argument usually depends on what kind of function you run. The filter function requires
# a logical condition to filter the rows. 
# It always filters ROWS!!! Because columns are parameter, rows are observations. 
# There is another specialty in this command. Look at the Pot_Temperature call. Usually we would have to write it in the
# way: 

Environment_tibble$Pot_Temperature

# To access the Temperature-parameter-vector. But the dplyr functions automatically know that they have to look for that parameter
# in the dataframe/tibble that we used as input! 
# This reduces the amount of written code and also improves readability! 
# You can also use the oldschool version to filter:

filter(Environment_tibble, Environment_tibble$Pot_Temperature > 20)

# You can even use another table than the one we are working with:

filter(Environment_tibble, Environment_Import$Pot_Temperature > 20)

# Whatever logical condition you create, it needs to have as many elements as our input-dataframe has rows!!! 
# Can you imagine why? Try to think about that ;-)

# Next function: Works in the same manner as the filter function. But it doesn't use a logical filter-condition, but instead it
# uses the index-positions of the rows to select rows from a dataframe/tibble:

slice(Environment_tibble, 4:12)

# We just selected rows 4-12. Easy ;-)

# Next function:

select(Environment_tibble, Pot_Temperature)

# select() selects parameters! Again, thats easy :-D But it is also able to select it by position-number:
select(Environment_tibble, 1:3)

# And it has a sister-function to select by logical:
select_if(Environment_tibble, is.numeric)

# This was a very cool shortcut to automatically select numeric parameter (the ones that are no string, dates or others).
# But the way we used this command was completely different than the ones before. Instead of a logical or a sequence of numbers,
# we used a function as a second input. This time without the parentheses: is.numeric()
# This function is similar to the conversion function you saw earlier: as.numeric()
# Instead, this function tests, whether an input-vector is numeric and returns TRUE or FALSE.
# This helps us understand whats happening inside the function select_if()!
# It looks like this function tests all parameter-vectors one by one by applying a function on them, which returns TRUE or FALSE.
# In our case this function was is.numeric
# But it should work with every function. Lets create one ourselfs:

random_selector_function = function(x) {
  
  round(runif(1)) == 1
  
}

random_selector_function()
random_selector_function()

# This function randomy returns TRUE or FALSE! The function runif(1) returns a vector of length 1 with random values in it. 
# Check the help-page of this command to see how it works!
# Now lets try to use this random selector to select parameter-vectors:
select_if(Environment_tibble, random_selector_function)

# Everytime you run this line of code, the result should look differently, because every parameter was chosen randomly. 

# It works, and you also see how it works. When we defined the random_selector_function we had to give this function the input
# vector "x" which we didn't use at all. So, why would we need it in the first place? 
# You can remove the input-"x" from the function definition and it will work the same. But it won't work in the context of the 
# dplyr-verbs. They automatically try to run the function with an input, which in this case would result in an error, because
# our defined function doesn't have an input-place. 
# You will encounter this phenomenon throughout the dplyr universe, running functions automatically on a column to generate
# useful outputs. 
# Another powerful function that uses this exact technique is called mutate(). It manipulates columns by running functions on it
# (or simple mathematical operations)

mutate(Environment_tibble, Pot_Temperature = Pot_Temperature + 10)
mutate(Environment_tibble, New_Parameter = Salinity * Pot_Temperature)

# We can again define functions that do the job for us. For example, let's try to standardize one parameter, by first:
# substracting the mean-value of that parameter from all values. Then let's divide all resulting values by their standard-deviation.

standardize_parameter = function(x) {
  
  (x-mean(x))/sd(x)
  
}

test_tibble = mutate(Environment_tibble, Temp_standard = standardize_parameter(Pot_Temperature))
select(test_tibble, Pot_Temperature, Temp_standard)

# Nice! This way we can easily standardize our numeric parameter vectors!

# There is one more thing to say about mutate: You always need to specify the column-name you want to manipulate! 
# This is why you always use the = to assign a vector to a parameter! This parameter can be a new name, then you would add
# an additional column with that name. But if the vector-name was already present, you overwrite the old data-values
# with the new ones.

# So we have to assign each parameter by hand. Would be better to have functions like mutate, that do the job for every column!
# Luckily mutate also has some sisters and brothers:
# mutate_all() and mutate_if()
# Okay, assume we want to standardize all parameter with our new function! Try it:
mutate_all(test_tibble, standardize_parameter)

# Error: Argument is not numeric!!!
# This is, because some of our parameters are character-vectors or date-vectors!
# Damn, it would have been too easy. But there is the other sister-function mutate_if(), which comes in handy right now:

mutate_if(test_tibble, is.numeric, standardize_parameter)

# Yeah! That worked. You see, this function requires an additional input-argument. This is the logical condition. The name
# of the function implies already how it works: manipulate all parameter-columns, IF they fulfill a logical condition.
# In our case, the logical condition of the parameter-vector is that it needs to be numeric. 
# But this condition can be every kind of condition, even the random-selector can be used here:

mutate_if(test_tibble, random_selector_function, standardize_parameter)

# This line of code works, but only sometimes! I hope you understand why this is. Try to run it 5 times and you will see that
# it generally works, even though it makes no sense at all. Who would write code, which only works sometimes?!?!

# You see, all the output we genererated was sent to oblivion, just because we didn't assign it. To do so, it would look
# like the following lines of code (very hideous):

filtered_test_tibble = filter(test_tibble, Pot_Temperature > 20)
manipulated_test_tibble = mutate(filtered_test_tibble, Standardize_Temp = standardize_parameter(Pot_Temperature))
standardized_Temperature = select(manipulated_test_tibble, Standardize_Temp)

standardized_Temperature

# THAT was exhausting! 
# Not only hard to write or hard to read, it also consumes a lot of memory space of your computer! Because it tries to save 
# every variable that you create! In this case, every name you assigned was saved including its content. So, the 
# test_tibble was stored in 4 different versions, each consuming the same amount of space. In our case, this is not very
# troublesome, just because the datatable is quite small. But imagine your data would span tenthousands of rows and hundreds of 
# parameter-vectors! Then, each time you safe your data as a slightly modified version of itself, your memory space will be
# bursting before you even end the simplest tasks of data conversions. 

# The thing we will use to avoid that is something you already know from BASH! We called it the PIPE and this is how
# it shall be named from now on as well!
# The PIPE-operator takes an output from the LEFTHAND side and puts it as input to the RIGHTHAND side.
# In our case, the RIGHTHAND side can also be the next-line. It looks like that %>%
# To reproduce the code from above, we would write it now like this:

standardized_Temperature = test_tibble %>%
  filter(Pot_Temperature > 20) %>%
  mutate(Standardize_Temp = standardize_parameter(Pot_Temperature)) %>%
  select(Standardize_Temp)

standardized_Temperature

# This is much easier to read, consumes way less memory and needs less stuff to write. What a wonderful little helper this 
# tiny pipe ;-)

# To understand whats happening, try to read line by line. Lets stard with the first:
# We pipe test_tibble INTO our function filter
# Then we pipe the filtered result INTO the mutate function
# Then we pipe the mutated result INTO our select function.

# The outcome of all this piping will be saved into the variable called standardized_Temperature.
# And finally we want to look at the output of that parameter, that's why we call it ;-)

# There is an important feature you need to use, whenever you want to refer to the piped-input in one of the arguments.
# You can always use the "." to refer to the result from beforegoing function. 
# See the example here:

test_tibble %>%
  filter(Pot_Temperature > 20) %>%
  mutate(New_Param = .$Pot_Temperature * .$Salinity) %>%
  .$New_Param

# When we created our new parameter New_Param within the mutate() function, we used the "." to refer to the table we got as an 
# input from before. 
# In this case, it would not have been necessary to use that, just because it would have worked without the .$ as well. 
# We explicitly referred to the Pipe-Input, instead of implicitly by referring to the data-input when we dont use .$ before the
# parameter name.
# In the end, we just used the .$ to extract the New_Param parameter-vector.

# Now you also understand, why all the dplyr-verbs require the input-table as first argument! With this principle you can
# easily create long pipe-routines using mainly dplyr verbs for data-conversion.

# In the beginning you sometimes create code that looks like that: This is called nested function calling

max(nrow(select(test_tibble, 5:10)))

# This line of code selects columns 5-10 from test_tibble, returns the number of rows from each parameter-vector (which are all 
# the same obviously) and then selects the highest row-number.
# It makes no sense, I know. But i just want you to see what "nested function calling" means.
# When we recreate the same line of code with the pipe it looks like:

test_tibble %>%
  select(5:10) %>%
  nrow() %>%
  max()

# It's much easier to read and understand! Whenever you find yourself writing nested function calling, try to rewrite it using
# the pipe. Your future you and everyone else who will need to read your scripts will thank you ;-)

# Recap:
# - We started learning how to install community-packages and load them into your scripts
# - The tidyverse package-collection was introduced
# - We learned: Tibbles
# - Dplyr-Verbs like filter, select, mutate, slice
# - The Pipe-Operator in R!!!

# To improve your understanding of the dplyr-package and the complete tidyverse collection, I totally recommend to read the book
# R for Data Science https://r4ds.had.co.nz 
