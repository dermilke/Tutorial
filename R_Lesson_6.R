### R_Lesson_6

# This last lesson will be all about ggplot2, the package that recreated the principles behind programming visuals.

library(ggplot2)
library(tidyverse)

# Well, actually you would not need to load ggplot2 explicitly, because it is included in the tidyverse-collection, but i just wanted
# to emphasize that we arenparticularly working with this package.

# A ggplot-understanding of graphics is quite simple:
# We have the data-layer, which defines what parameter will be assigned to which "aesthetic". Here you define the contexts of your
# graphics. 
# Then you have to define HOW your plot will be done. There are tons of different plotting types, like boxplot, scatterplot, barplot
# and so on. For a complete list of all plotting types and how to realize them i recommend you to take a look at the following page:
# https://www.data-to-viz.com
# This is a beautifully designed webpage that lets you interactively explore the world of Plotting graphics!! 
# I totally recommend this to interested people, it's a little bit like porn for data scientists ;-)

# So, the HOW to plot is defined by the GEOMETRY-layer. This layer defines what you will see in the end.

# And on top of those two layers, you can define all kinds of different options! So many, that you will have to look them up once
# you need to change some detail, just because you can not know all of them out of mind.

# Okay, now our first test-graphic:

ggplot(Environment_tibble, aes(x = Latitude, y = Pot_Temperature)) +
  geom_point()

# This is the simplest kind of plot, a scatterplot using 2 different parameter.
# When we break apart the two commands, we see the first function:
# ggplot()
# followed by a "+"
# and the next function 
# geom_point()

# The ggplot() function is the foundation to build on. It initialises a new plot, using a data.frame/tibble as its primary input.
# It also needs to specify the Aesthetics! this is done by another function, called aes().

# Let's look what the aes() function outputs:
aes(x = Environment_tibble$Latitude)
# Okay, that won't help us personally, but it's nice to see that this function creates some kind of output, which is necessary
# for the ggplot() function. The output of aes defines, which parameter will be used for which aesthetic-item.
# The mostly used possible items are: x, y, color, fill, size, shape

# So, the first foundation of ggplot is been set, by defining the Aesthetics and the data to use. 
# This is been connected with "+" to other ggplot-functions

# One important kind of functions are the geometry-functions. Like you read before, the geometry defines the kind of plot we are 
# creating. The easiest one is just a scatterplot, where we plot points for each observation.
# Its geometry-function is called geom_point().
# There are others, like geom_boxplot() or geom_bar(). You can look them up on the page i mentioned before.

# When we define the geometry on top of the ggplot-foundation, it automatically creates a plot using the default option settings.
# These default options are customizable, of course ;-)
# Let's play around

ggplot(Environment_tibble, aes(x = Latitude, y = Pot_Temperature, color = Province)) +
  geom_point(size = 3, shape = 21) +
  labs(x = "Latitude along transect", 
       y = "Temperature [°C]",
       title = "This is our first GGplot example",
       subtitle = "nice") +
  scale_x_continuous(breaks = c(-50, -25, 0, 25, 50))

# This is only the tip of the iceberg! You can play around, adding additionaly point- or line-geoms and so on.
# But we also encountered something new, which is called the "scale".

# The scale of an Aesthetic (like the x-axis or color-definition) defines, whether the values of that Aesthetic are discrete
# or continuous. If you are not familiar with the meaning of those words, try to look it up. 

# To talk in R-Words: numerics are most often continuous parameter, whereas factors are always discrete parameters.
# Temperature in our case, as well as Latitude, are continuous parameters. They can take any values within a given range.
# A discrete parameter can be only a few, countable number of values. In our case, the Aestetic color, which was defined
# as the parameter Province has automatically been defined as discrete scale. Just because our Province-Parameter can only 
# realize a certain amount of different values (here defined as those short 4 letters). 

# To see the impact of the difference, let's use not a discrete color-Aesthetic, but a continuous:

ggplot(Environment_tibble, aes(x = Latitude, y = Pot_Temperature, color = Salinity)) +
  geom_point(size = 3, shape = 21) +
  labs(x = "Latitude along transect", 
       y = "Temperature [°C]",
       title = "This is our first GGplot example",
       subtitle = "nice") +
  scale_x_continuous(breaks = c(-50, -25, 0, 25, 50)) +
  scale_color_continuous()

# You can see the difference especially when looking at the legend on the right. To display a continuous parameter as a color
# aesthetic, you would need to have an infinite amount of colors to display an infinite amount of different possible values.
# This is of course easily possible by just defining a color-range from which the colors will be drawn.

# A realisation of discrete x-axis values might look like that:

ggplot(Environment_tibble, aes(x = Province, y = Pot_Temperature, color = Salinity)) +
  geom_point(size = 3, shape = 21) +
  labs(x = "Latitude along transect", 
       y = "Temperature [°C]",
       title = "This is our first GGplot example",
       subtitle = "nice") +
  scale_x_discrete()

# You see that scatterplots are not the right choice of geometry for this kind of data-display. Let's improve that:

ggplot(Environment_tibble, aes(x = Province, y = Pot_Temperature)) +
  geom_boxplot() +
  labs(x = "Latitude along transect", 
       y = "Temperature [°C]",
       title = "This is our first GGplot example",
       subtitle = "nice") +
  scale_x_discrete()

# Boxplots suit much better to show the actual distribution of datapoints.

# Last but not least, i will show you some basic workflows of how to efficiently use and combine the dplyr and ggplot-principles:

# Let's assume we want to filter our data first and also create some additional variables before putting the table into our
# ggplot foundation. 

Environment_tibble %>%
  mutate(New_Parameter = Salinity * Pot_Temperature) %>%
  filter(Depth <= 40) %>%
  
  ggplot(., aes(x = Latitude, y = New_Parameter)) +
    geom_point(aes(fill = Province), shape = 21, size = 5) +
    geom_line()

# You see, we easily created a complete workflow of data-wrangling and plotting into a few lines of code that did not create
# temporary variable-names which are only placeholders for intermediate products. 
# And it's also easy to read and understand! 
# That's why i like this way of working so much, compared to the old'school techniques i showed you in the first few lessons.
# BUT You need both, old'school AND tidyverse, just because the latter is, even though it can help you in nearly every task, limited
# to the scope of its functions. Especially iterative tasks where you need to work with loops need the basic understanding
# of R! Also all the types of objects in R!
# I think, mastering the understanding of object-types is a crucial skill in working with R! 

# Recap:
# - Different layers of ggplot
# - Aesthetic, Geometry, Scales
# - Difference between discrete and continuous scales
# - Basic tidyverse workflows
