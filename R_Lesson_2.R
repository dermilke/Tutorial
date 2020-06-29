### R_Lesson_2

# Okay, back to our Problem: We want to do a mathematical operation on Salinity and Temperature Vectors, but before we allow 
# R to do so, we want to check if both vector lenghts are the same.
# We already know how to check if their length is the same, but how do we tell R to ONLY do the mathematical operation, if 
# the length-comparison is TRUE?

# Here comes the "if-condition":
# It ONLY executes the after-coming commands, IF the statement beforehand is TRUE:

length_condition = length(temperature) == length(salinity)

if (length_condition == TRUE) {
  
  temperature * salinity

}

# Okay, lets break this apart: First we saved the condition in a variable called length_condition, after that the IF-statement
# was executed.
# If statements always look like this:     if (condition) { SOME COMMANDS }
# It works by FIRST checking the condition, if the condition is TRUE it runs SOME COMMANDS. These commands can be only one, but also
# multiple commands. All the commands are stored in a BLOCK! 
# A BLOCK of commands is always initiated with a "{" and ended with a "}". You will encounter these BLOCKs in other situations as 
# well, so keep them in mind.

# Okay, this was our first IF-Condition! But it has one more cool thing! What happens, if the condition is FALSE ?! 
# In our example, nothing would happen. This easily works, R knows what to do. But there is also a BLOCK of commands for R in case
# the condition is FALSE. It can be programmed in the following way:

if (length_condition == TRUE) {
  
  temperature * salinity
  
} else {
  
  message("Warning: Length of vectors did not match.")
  
}

# So, this is how the else BLOCK can be programmed. Right after the if-BLOCK ends, you can write else { SOME COMMANDS }
# This else does not work in any other context, it needs to have an if-condition beforehand. 

# Cool, so now we finished our task. 
# But wait, we were not able to multiply temperature and salinity, because they had different lengths. Is there a possibility
# to manipulate one of the vectors to do so?! Let's try to reduce the longer vector by its last number.

length(temperature)
length(salinity)

# In this case temperature is the longer vector. So we want to remove the last element of temperature, so it also has length of 4.

# To do so, we need to access an element of a vector. There are multiple ways to do that. I will show for now the most common one:

temperature[5]

# So, when we have a vector (later you will see this also works similar for tables) you can use the [] parenthesis to access single
# entries or elements of a vector. 

# Keep in mind, that EVERY entry has an ordered number from 1 to length of vector. The 1 is always the first element of the vector, 
# the 2 is the second element of the vector, the 3 the third and so on...
# This is called the INDEX of the entries. To know which entry has which index, just look at the vector. 
temperature
# First value = Index of 1
# Second value = Index of 2
# and so on....

# By that we can access the 5th element of the vector by using its index in the [] parenthesis:
temperature[5]

# You can also specify a range of INDEX-values
temperature[c(1,2,3)]
# or
temperature[2:4]

# AND what comes handy for us NOW we can also use negative INDEX values. That means, that this value will be excluded from the
# vector

temperature[-5]
temperature[1:4]
# You see: The fifth element of the vector has been excluded! Perfect for our task.

# Maybe you already realised it, but of course R didn't save any of these things. Temperature still looks the same as before.
# This is because we didn't save the results! In order to save the changes, you need to assign it to a variable. This can
# be the same variable as before, BUT BE AWARE! If we would do the following:

# temperature = temperature[-5]

# We would loose the complete temperature case, meaning we could not recover the fifth element of temperature. 
# So it would be better to save the manipulated temperature in another variable-name

temperature_modified = temperature[-5]

# Nice! Now we can keep the initial temperature but also have the reduced version to work with. Even though the name seems
# pretty long and always writing the long name is tedious. But let's keep it for interpretability right now.

# Okay, let's complete the task:

if (length_condition == TRUE) {
  
  temperature * salinity
  
} else {
  
  length_temp = length(temperature)
  length_sal = length(salinity)
  
  if (length_temp > length_sal) {
    
    temperature_modified = temperature[-length_temp]
    temperature_modified * salinity
    
  } else {
    
    salinity_modified = salinity[-length_sal]
    temperature * salinity_modified
    
  }
  
}

# Okay, that was complicated AND only works for the special case, where temperature OR salinity have only one length-difference!
# But did you see the trick? I saved the length in a variable and used that length-number to remove the last element of the vector!
# This way you can automate processes! 
# Nice key-word: Automation! Always try to think: HOW can i program my recipes in a way, that no matter what i give as an input,
# the recipe always works! 
# I mean, that's an ideal and it will probably not hold in reality, because there will always be some stupid users who
# give for example character-values into an integer-variable. But we should do our best to think in general terms.

# That's why our solution now is still not the best solution! In order to improve it, there is one new programming concept, which
# is strongly related to the "if" condition:
# It's called the "while" condition!!!

students_in_class = c("Miriam", "Bashar", "Sarah", "Dmytro")

while (length(students_in_class) > 0) {
  
  students_in_class = students_in_class[-1]
  cat(students_in_class)

}

# iteration

students_in_class
# character(0) means: This vector was a character-vector once (strings are also considered as characters) but has 0 entries now.
# This also exists for numeric vectors (integer or double) and logical vectors (the BOOLEANs - that sounds like a family-tv-show).

# but back to the while concept: 
# What it does is not only familiar to the if condition, but also to the loop-idea that will come soon. 

# while (condition) { BLOCK } 

# It first checks the condition and if it is TRUE it will execute all commands within the BLOCK.
# Then it goes up again to the while-condition. If this is still TRUE it will again execute all commands within the BLOCK.
# And again.
# Until the while-condition is FALSE. Then it will terminate the while-loop.

# And because the BLOCK will be executed OVER and OVER again until a condition is fulfilled, this is called a LOOP. (because
# it is running in a circle, over and over again. Makes Sense? Hopefully ;-) )

# Let's take advantage of this in our initial problem. We want the mathematical operation be only done, when temperature and
# salinity have the same length, no matter how long one of them is! And of course, the common length is the length of the shorter
# vector.

salinity = c(28, 30, 32)
temperature = c(10, 15, 20, 15, 15, 10)

salinity_length = length(salinity)
temperature_length = length(temperature)

if (salinity_length == temperature_length) {
  
  temperature * salinity
  
} else {
  
  if (salinity_length > temperature_length) {
    
    salinity_modified = salinity
    
    while (salinity_length != temperature_length) {
      
      salinity_modified = salinity_modified[-salinity_length]
      salinity_length = length(salinity_modified)
      
    }
    
    temperature * salinity_modified
    
  }
  
  if (salinity_length < temperature_length) {
    
    temperature_modified = temperature
    
    while (salinity_length != temperature_length) {
      
      temperature_modified = temperature_modified[-temperature_length]
      temperature_length = length(temperature_modified)
      
    }
    
    temperature_modified * salinity
    
  }
  
}

# Nice! That worked! Well, that was complicated, phew!!! But, fortunately there are as many ways to do this task in a programming
# language, as ways to say "rain" in the german language.

# If you want to see another way to do the same, voilá :

temperature[1:min(length(salinity), length(temperature))] * salinity[1:min(length(salinity), length(temperature))]

# So it's all about knowing the vocabulary. 
# I actually used only programming concepts you already knew, so try to understand that line of code. The only new thing was the 
# word (or in nerd language "function") min(). 
# Try to look up in the HELP on the right, what the function min() does.

# In this case, the HELP page gives us a lot of input, seems like min() (and also the related max() function) have a lot of
# special cases that need to be stated in the Details section. 
# This will often be the case when you look up vocabulary in the HELP. Mostly, only few sentences will be important to read,
# that will tell you what you were looking for. 
# To understand the HELP and its own technical terms it may take some time. More often, i find myself looking up a help in
# google, just because there you mostly find better example-code and explanation in common language ;-)

# Now it's time to learn another loop, first because we just were tought what a loop is, but also because this one is way more
# important than the WHILE-loop. Even though the WHILE-loop seems so logical and easy to understand, it is used much less 
# than the FOR-loop. 

# for (VARIABLE in SEQUENCE) { BLOCK }

# Let's break this into pieces. First of all, the "for" initiates the loop. 
# Then we need a VARIABLE, it is also considered as a running-parameter, that means a variable that is changed over a sequence of 
# numbers. You can take any name here (technically you can also use names that have been used before, but you would overwrite
# the content of that names, so i recommend to use new names. I mainly use i, j or k)
# And then we have the SEQUENCE, which contains the numbers that our VARIABLE will take over throughout the progress of the loop.

# The simple case:
# we call the VARIABLE i
# And the Sequence from 1 to 10
# And in the BLOCK lets just print the actual value of our VARIABLE in the console using the function cut()

for (i in 1:10) {
  cat("This is iteration number:", i, "\n")
}

# You see how it works? 
# The loop starts with i = 1 then it runs the BLOCK which in this case prints the text (be aware: the "\n" means New Line)
# Then the loop starts again from the beginning and i takes the next number in the SEQUENCE which is in this case the 2
# And it runs the BLOCK.

# Each run is called ITERATION (fancy nerd term)
# And it runs as often as there are elements within the SEQUENCE. (You see: I avoided the term "number within the Sequence" because
# you can also use character-vectors as SEQUENCE or BOOLEAN vectors... But that's fancy stuff you rarely need)

# Nice to know: You can rewrite EVERY while-loop as a for-loop and vice versa. To rewrite our while-loop as a for-loop, look:

salinity = c(28, 30, 32, 29, 31, 31)
temperature = c(10, 15, 15, 10)

salinity_length = length(salinity)
temperature_length = length(temperature)

salinity_modified = salinity

while (salinity_length != temperature_length) {
  
  salinity_modified = salinity_modified[-salinity_length]
  salinity_length = length(salinity_modified)
  
}

salinity_modified * temperature

salinity_length = length(salinity)
salinity_modified = salinity

for (i in 1:(salinity_length - temperature_length)) {
  
  salinity_modified = salinity_modified[-(salinity_length - (i-1))]
  
}

salinity_modified * temperature

# So this is a direct comparison of a WHILE-Loop solution and a FOR-Loop solution.
# Usually the FOR-Loop works faster and is more often used throughout the community,
# but the WHILE-Loop has a better "readability", you can more easily understand how your recipe works when you try to understand
# what you wrote the day before.

# I already showed you, it's all about the right vocabulary. And that has a reason! Let's also invent some new words for R,
# just because we can! 
# Okay our task is the same as before. We want to multiply two vectors no matter how long they are. But now let's call the
# vectors just x_1 and x_2 because we want to create a new vocabulary for R which works for every two vectors we want.

# To do so, we need to know how to define a new FUNCTION
# You already know how to apply a function that exists: function(input_1, input_2, ....)
# An example we used is the length(vector) function! (see above)

# To create a new function, it looks similar:

# NAME = function(INPUT_1, INPUT_2, ...) { FUNCTION-BLOCK }

# So NAME is just a random name that we can give our new function. Let's go with powerfulMultiplication
# = function() is the mandatory keyword for R to know: I'm gonna create a new function
# and everything which is within the parentheses () are variables/vectors that you have to give to your new function 
# when you want to execute it.
# And again the FUNCTION-BLOCK is what your function does.

# Okay let's define our powerfulMultiplication
# (be careful when using new names, they will overwrite existing names. But don't be scared if that happens, when you restart R
# or kill your environment the old functions will be restored)

powerfulMultiplication = function(x_1, x_2) {
  
  x_1[1:min(length(x_1), length(x_2))] * x_2[1:min(length(x_1), length(x_2))]
  
}

# For convenience i just used the one-liner-solution for our problem. So this script won't be too long!

# To test if our new function works properly, we need to test it! So let's just define some crazy new vectors and try it out:

first_vector = c(123,123,123,123)
second = c(1,2,3,4,100,123,500,1:10)

powerfulMultiplication(first_vector, second)

powerfulMultiplication(second, first_vector)

powerfulMultiplication(c(1,2,3,4), c(1,4,8,10,12,14))

powerfulMultiplication(c(1,2,3,4), c("Sarah", "Dmytro", "Bashar", "Miriam"))
# Okay it is not so powerful in the end! It throws an Error message if we use character-vectors. But that's totally okay,
# everyone who wants to multiply a text with a number has serious problems with his/her understanding of math ;-)

# RECAP: 
# So, what you learnd in this Lesson:

# - IF conditions
# - Accessing vector-elements by their INDEX number
# - While-Loops
# - For-Loops
# - creating new Functions

