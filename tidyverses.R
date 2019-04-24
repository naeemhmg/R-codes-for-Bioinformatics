library(gapminder)
library(dplyr)

# Tidyverse is used for data wrangling
# this is a very powerful tool to analyze and visualize the data
# In the above two lines we have loaded dplyr and gapminder library
# the gapminder librrary contains our data. 
# Lets wrangle with data and try to see what gapminder contains 
gapminder
# this contains data of many years of all countries along with their gdp growth
# Lets try to identify the type of gapminder 
class(gapminder) # Note at the output. Its a data frame type of data
# Now lets start analyzing the data 
# In data analysis with tidyverse, we will first try to under stand pipe function 
# The pipe function is "%>%" and this will allow you to pass the data to next function 
# for example if i want to pass my gapminder data than the syntax will be like gapminder %>%
# After pipe, we apply some function to sort the data, lets first try to undestand "filter".
# The filter function will help us to filter the data based on some observations. Lets try it
gapminder %>%
  filter (year==1957)# if we look at the output than we will see the data of all countries in 1957
# We can filter many observations at one time, lets assume that we want to filter the data of Pakistan
# in 2002 than following syntax will be used. 
gapminder %>% 
  filter(country=="Pakistan", year==2002) # look at the output 
# Now lets try with three observations 
gapminder %>% 
  filter (country=="Pakistan", lifeExp < 30 | lifeExp > 40, year == 1957) # here we have used different 
# observations to dig the data of interest from gapminder. 
# Sometime it is important to arrange verb (data) in special format (decesending order etc)
# to arrange the data in dplyr we used the "arrange" function, have a look at the following syntax
gapminder %>% 
  arrange (lifeExp) # data is arranged in asending order
gapminder %>% 
  arrange(desc(lifeExp)) # data is arranged in desending order
# We can use filter and arrange function at same time as well. lets have a look on following syntax
gapminder %>%
  filter (country == "Pakistan") %>%
  arrange(desc(lifeExp))
# Sometime there is need to mutate the verb (data). Lets try to see how can we do it. Here we will use
# the function mutate
gapminder %>%
  mutate (lifeExp * 12)
# Let store the mutated values in form of new column 
gapminder %>%
  mutate (lifeExp_Month= lifeExp*12) # Similarly we can mutate any column present in the data 
# Filter, arrange and mutate function can work togather, let have look on the following syntax 
# In this syntax, we will mutate the column of lifeExp and make a new column lifeExp_Month 
# Finally we will arrange the lifeExp_Month to desending order. Lets have look
gapminder %>% 
  filter (year==1957) %>%
  mutate (lifeExp_Month= lifeExp *12) %>%
  arrange (desc(lifeExp_Month))
# Now after data wrangling, this is time of data visulization, lets try to visulize the data using ggplot2
# loading of ggplot2 library 
library (ggplot2)
# Now lets create the a variable having only values of Pakistan
gapminder_Pak <- gapminder %>%
  filter (country =="Pakistan")
gapminder_Pak
# Now try to visulize the data which is present in this variable 
# lets try to compare the population and gdpPercap in all years of Pakista histroy
# We will use the ggplot function, have a look in following syntax
ggplot (gapminder_Pak, aes(x=pop, y=gdpPercap))+geom_point()
# The above mentioned code will display a scatter plot having population on x-axis and gdpPercap on y-axis 
# X-axis values are not very good. Lets first convert the values of population into million
gapminder_Pak2 <- gapminder_Pak %>% 
  mutate (pop_million = pop/1000000)
# Now lets make scatter plot once again
ggplot(gapminder_Pak2, aes(x=pop_million, y=gdpPercap))+geom_point()
# Now graph looks more readable and it indicates that as there is growth in population there is also
# increase in gdpPercap.
# Now lets compare population size and life Exp in Pakistan.
ggplot(gapminder_Pak2, aes(x=pop_million, y=lifeExp))+geom_point()
# the graph again highlighted linear relationship between life Exp and increase in population 
# Lets try to understand this phenmenon in another way 
ggplot(gapminder_Pak2, aes(x=year, y=pop_million, color=gdpPercap, size=lifeExp))+geom_point()
# In this graph we have compared three parameter with one another. 
# Some times it is good to add log scale on x or y axis to make the plots more readable. Consider the
# following code
ggplot (gapminder_Pak2,aes(x=pop, y=lifeExp))+geom_point() + scale_x_log10()
# To get good idea about log scale applications let take whole gapmider data of 1952
gapminder_1952 <- gapminder %>%
  filter (year==1952)
# plot without log scale between population and life Exp
ggplot (gapminder_1952, aes(x=pop, y=lifeExp))+geom_point()
# Plot with log scale, which is more readable  
ggplot(gapminder_1952, aes(x=pop, y=lifeExp))+geom_point()+scale_x_log10()
# Log scale can be used on both axis 
ggplot(gapminder_1952, aes(x=pop, y=gdpPercap))+geom_point()+scale_x_log10()+scale_y_log10()
# How is it if you get many plots in one shot. lets assume you want to see population growth in each year 
# in Pakistan so rather than filtering each year, we will use single command to get all plots in one shot
# This is known as facet and facet_wrap(~) function. Have a look on the following code
    
ggplot(gapminder_1952, aes(x=pop, y=lifeExp, size=gdpPercap))+geom_point()+scale_x_log10()+facet_wrap(~continent)
              
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp, color=continent, size=pop))+geom_point()+scale_x_log10()+facet_wrap(~year)       
# As we know that R is primarly used for statistical analysis
# dplyr allows us to summarize the data by applying various statistical formulas.
# here we will use the summarize function and within this function we will call statistical function. 
# have a look on the following code
# Lets calculate the median life Exp in Pakistan data 
gapminder_Pak2 %>% 
  summarize(medianlifeExp=median(lifeExp))
# here we have our median of life Exp which is 55.1. Lets calculate overall median of lifeExp in whole data
gapminder %>% 
  summarize(medianlifeExp=median(lifeExp))
# We can use the summarize function along with filter, arrange, and mutate combination. lets have a look
gapminder %>%
  filter (year==1957) %>%
  summarize(medianlifeExp=median(lifeExp)) 
# We can also group the data and than apply the summarize function.
# For this we will use group_by () function. Have a look on the following code.
# this function will analyze the data in rows 
gapminder %>%
  group_by(year) %>%
  summarize(medianLifeExp=median(lifeExp), maxGdpPercap=max(gdpPercap))
# Similarly, we can group by country 
country_gapminder<- gapminder %>%
  group_by(country)%>%
  summarize(medianlifeEXp=median(lifeExp),maxgdpPercap=max(gdpPercap))
ggplot(country_gapminder, aes(x=country, y=medianlifeEXp))+geom_col()

# Let group the data on bases of continent and analyze it 
gapminder %>%
  filter(year==1957) %>%
  group_by(continent) %>%
  summarize (medianLifeExp=median(lifeExp), maxGdpPercap=max(gdpPercap))
# We can also group by using two different data points as well. For example, year and continent
gapminder %>%
  filter(year==1957) %>%
  group_by(continent, year) %>%
  summarize (medianLifeExp=median(lifeExp), maxGdpPercap=max(gdpPercap))
# Now lets try to analyze some data of Pakistan
gap <- gapminder_Pak %>%
  group_by(year) %>%
  summarize (medianLifeExp=median(lifeExp), maxGdpPercap=max(gdpPercap), population=pop)

gap
ggplot(gap, aes(x=maxGdpPercap, y=medianLifeExp, color=population))+geom_point()
# some time expand limit can be used to make graph more readable 
by_year_continent <- gapminder %>%
  group_by(continent, year) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Plot the change in medianGdpPercap in each continent over time
ggplot(by_year_continent, aes(x = year, y = medianGdpPercap, color = continent)) +
  geom_point() +
  expand_limits(y = 0)+facet_wrap(~continent)

# There is not always scatter plot to visulize the data 
# There are many other graphical representations are also available 
# which can be used to visulize the data 
# These visulizations include, bar chart, boxplot, histogram etc
# Lets have a look on them.
# Following code will be used for line plot
ggplot (by_year_continent, aes(x=year, y=medianGdpPercap, expand_limits(y=0)))+geom_line()
# Following will be used for bar plot 
ggplot(by_year_continent, aes(x=continent, y=medianGdpPercap, color=continent))+geom_col()
# Following will be used for histogram plot
ggplot(gapminder_1952, aes(x = pop)) + geom_histogram()
# The following will be used for boxplot
ggplot(gapminder_1952, aes(x=continent, y=gdpPercap))+geom_boxplot()+scale_y_log10()
