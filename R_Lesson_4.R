### R_Lesson_4

# This lesson will be all about plotting! Finally, I think this is the most pleasent part of working with R: Visualization!!!

# Now we know how to load data into R, we know how to access different parameter of that data. 
# Next step will be plotting those parameter against each other!!!

Environment_Import = read.csv("Environment_Data.csv")

# Base R comes with one standard plotting command, which is quite powerful and flexible, but it is not state of the art!
# The community, especially Hadley Wickham, used scientific visualization principles and invented the so called
# grammar of graphics. This was the name of a publication from another scientist back in the 70's who tried to break down the 
# principles of visualization to fundamental steps.
# This grammar was used by Wickham to invent the package ggplot and later ggplot2. 
# Before we dell into the grammar of graphics, I want to show the basic R plotting first, just because it is an
# easy to understand, straight forward solution to create quick and dirty data-visualizations!

# Okay, let's start by plotting a wonderful temperature-salinity-diagram (also called TS-Plot in oceanography - can you guess
# why this kind of plots are relevant?!)

# So the data we work with is actual data from our Pacific cruises SO248 and SO254 with the Research Vessel Sonne. Those cruises
# took part in spring 2015 and 2016, when we started from New Zealand to take samples along a transect at 180°E/W and 60°N/55°S.
# This is "real data" we are currently working with (but already open accessible). 
# I chose this dataset to show you what kind of problems one has to face when doing data analysis using data generated from 
# various people and different working groups. It is curated in a sense, that it is easy to read into R and has no ambiguous entries
# in its parameter vectors.

# Temperature is called Pot_Temperature, because we are working with the potential temperature (pressure-corrected)
Environment_Import$Pot_Temperature
Environment_Import$Salinity

# Because the data comes from the same data.frame both vectors must have the same length. You remember? This was one of the 
# requirements of the data.frame object type.
# Now, this comes handy because we can be sure that the first value of the Temperature-Vector matches the first value of the
# Salinity-Vector! And so on until the last value of both vectors!!!
# This is very important if you want to plot and work with the data. 

# Plot works this way: plot(x,y)
# In every plot we have our beloved x-axis and y-axis. Now we only need to decide which of those two parameters will be used as
# which axis. For now, this is not very important. But you will see in our next example that this question is a matter of 
# context ;-)

plot(Environment_Import$Pot_Temperature, Environment_Import$Salinity)

# Looks already interesting! The data is clearly not randomly distributed, but if you know how to interpret TS-Plots then you
# probably knew that already! 
# To distinguish the data, let's try to use colored points instead of black ones. Let's try to use another color for higher depths:

plot(Environment_Import$Pot_Temperature, Environment_Import$Salinity, col = Environment_Import$Depth)

# Maybe that was already one step ahead! 
# The plot() command can interpret what to do based on what you give it as an input. For example the color option uses a color
# for every point if you give it a vector with as many entries as you have data-points. 
# But you can give it also only one color and then it uses that color for every point:

plot(Environment_Import$Pot_Temperature, Environment_Import$Salinity, col = "navy")

# In our case, we gave it a vector with numbers
Environment_Import$Depth
# And it knew how to interpret the vector, so that every number was used as a color. But honestly, this was really not super useful!
# We don't have a legend to interpret the color, and the colors were assigned randomly. It would be much better to have a color
# gradient that changes from low Depth-Values to high Depth-Values.

# For that we will use the ggplot-solution. But let's safe that for later.

# Instead, let's use that "oldschool" plot() function to plot something useful
# I already said that this dataset was created measuring along a transect in the middle of the pacific. So, it makes sense
# to use this spatial information on the x-axis and plot some other values on top of that:

plot(Environment_Import$Latitude, Environment_Import$Pot_Temperature)

# Uff, hm, not very beautiful! We already encountered a problem: Temperature changes strongly close to the ocean-surface just because
# of the impact from the sun, waves, rain... But this changes strongly with depth. In deeper ocean-layers the impact of the
# atmosphere on water temperatures is much less and the water bodies have rather uniformely distributed temperatures. 

# So, in order to make a useful plot, we should rather focus on surface-samples than on deep-sea samples! So we need to filter our
# data!!!
# One way to do that is the following (you already saw how it works in one of the exercises):

Environment_Import$Latitude[Environment_Import$Depth <= 40]
Environment_Import$Pot_Temperature[Environment_Import$Depth <= 40]

# It is important to understand the details of those commands, because here you have to combine the knowledge from the last few days:
# We use a logical (BOOLEAN) vector to filter our parameter-vectors. 
# Here it is again very important that all parameter-vectors have the same length and that the first element always corresponds to 
# the first element of the other parameter-vectors!!!
# The computer will see something like that:

# Latitude[TRUE, FALSE, TRUE, TRUE ....]

# And every TRUE is an element from the parameter-vector that R will take, whereas every FALSE will be dropped.

# Now let's plot the filtered parameter-vectors:

plot(Environment_Import$Latitude[Environment_Import$Depth <= 40],
     Environment_Import$Pot_Temperature[Environment_Import$Depth <= 40])

# Side-Note: R doesn't care if you have new-lines in the code, as long as you do that after a "," 

# The results look pretty good. We now see the distribution of temperatures at the ocean surface along the transect.
# At 0° we crossed the equator and here we encountered the highest temperatures. That makes total sense!!!
# Whereas towards the ends of the transect, we got closer to the poles where temperatures declined strongly. 

# Unfortunately, the labels of the axes are very cryptical. Actually, you see that R just uses the code you gave it to define
# the x-axis and the y-axis.
# But we can change that. Let's try to make the plot as beautiful as possible with the plot() command:

plot(Environment_Import$Latitude[Environment_Import$Depth <= 40],
     Environment_Import$Pot_Temperature[Environment_Import$Depth <= 40],
     xlab = "Latitude", ylab = "Temperature [°C]", 
     main = "Progression of surface temperature along a \nlatitudinal transect in the Pacific Ocean",
     bty = "n", xlim = c(-60, 60), ylim = c(0, 35))

# You saw, that everytime we use a plot() command, the old plot is deleted and the new one is plotted from scratch.
# But there are a few functions, that build on top of a plotted figure:

grid()
points(0, max(Environment_Import$Pot_Temperature), pch = 21, bg = "red", cex = 1.5)
text(5, 30, "Equator", adj = 0, col = "red")
legend("bottomleft", legend = "Equator", pch = 21, pt.bg = "red", title = "Legend:", bty = "n")

# To fully understand what happened you can read the help page for each of those commnands. One hint: google "R pch"
# under images and you will quickly see what that argument stands for ;-)

# One easy task would be now to produce a function that does all of that for us and we only have to specify the parameters:

easy_plot = function(param_1, param_2, xlabel, ylabel) {
  
  plot(param_1,
       param_2,
       xlab = xlabel,
       ylab = ylabel,
       bty = "n")
  
  grid()
  
}

easy_plot(Environment_Import$Oxygen, Environment_Import$Chlorophyll_a, "Oxygen", "Chlorophyll")

# Hm, okay that didn't make any sense because we still need to define all the labels and axis-limits manually. 
# But nice for practicing ;-)

# R comes with some other plotting commands beside plot(). 

# barplot()
# hist()
# pie()
# boxplot()

# You can guess from the names what those function are good for. To understand how they work, just use the help page and/or google
# some examples. Especially the boxplot() command comes with a new feature from R, so called formulas. This is (again)
# a special data type that i don't want to explain now. If you are interested in it, you can of course ask ;-) or google it. 
# But I think I tortured you enough with data-types! 

# Recap:
# - You learned how to use the plot() command
# - How to filter data.frames with logicals
# - And that you can add graphical elements to plot() figures.
# - Finally, you will probably not use those functions very often because now you will see the power of the R-Community!!!