library(tidyverse)
gapminder_1997 <- read_csv("un-report/gapminder_1997.csv")
gapminder_1997

name <- "Courtney"
age <- 84
name <- "Sarah"

#Guidelines for naming variables
#cannot begin with a number!
1dog <- "fido"
dog1 <- "fido" 

#cannot contain spaces 

my name <- "Courtney"
my_name <- "Courtney"

#variable names are case sensitive 

dog <- "Fido"
Dog <- "Fluffy"

#be consistent!

read_csv("data/gapminder_1997.csv")
read_csv(file = "gapminder_1997.csv")

gapminder_1997

#this pulls up the table in that separate tab. 
view(gapminder_1997)

#Plotting in R
#making plots, stringing together different layers
#plus lets us add these layers
#if you dont see stuff on your plots, check for the pluses! It wont come up as an error, if you're missing one since it can plot the other stuff above. 
ggplot(data = gapminder_1997) +
  aes(x = gdpPercap)+
  #sets x axis
  labs(x = "GDP Per Capita")+
  #labels x axis 
  aes(y = lifeExp)+
  labs(y = "Life Expectancy")+
  #geoms are the "geometries" they define how your plot looks. 
  geom_point()+
  labs(title = "Do People in Wealthy Countries Live Longer?")+
  #color code data points
  aes(color = continent)+
  #default color scheme, but you can change them! 
  #look up these color palettes, google it! 
  scale_color_brewer(palette = "Set1") +
  #change the size of the points 
  #that can divide the numbers 
  aes(size = pop/1e6)+
  labs(size = "Population in Millions")
#you can also merge all this stuff together you if you wanna 

ggplot(data = gapminder_1997) +
  aes(x = gdpPercap, y = lifeExp, 
      color = continent, size = pop/1e6)+
  labs(x = "GDP Per Capita", y = "Life Expectancy", 
       title = "Do People in Wealthy Countries Live Longer?", 
       size = "Population in Millions")+
  geom_point()+
  scale_color_brewer(palette = "Set1")

#larger gapminder dataset
read_csv("gapminder_data.csv") -> gapminder_data
# "alt minus sign" will give u the -> sign 

ggplot(data = gapminder_data) +
  aes(x = year, y = lifeExp, color = continent, group = country)+
  #a single line for each country 
  geom_line()

#discrete plots 

ggplot(data = gapminder_1997)+
  aes(x= continent, y=lifeExp)+
  geom_boxplot()

ggplot(data = gapminder_1997)+
  aes(x= continent, y=lifeExp)+
  geom_violin()+
  #you can add another layer to show all the points! 
  #order matters, if you do the violins FIRST, they will cover the points
  #jitter makes it so all your points arent overlapping
  #be careful that it DOESNT effect height
  #you can add aesthetics WITHIN geoms, this way, the violin doesn't change, but the points do
  geom_jitter(width=0.2, height = 0, 
              aes(size=pop))

ggplot(data = gapminder_1997)+
  aes(x = gdpPercap, y = lifeExp)+
  geom_point() +
  #to change the axis 
  scale_x_continuous(trans = "log10")

#another way to log trans
#maybe better bc it adds the label with it! 
ggplot(data = gapminder_1997)+
  aes(x = log10(gdpPercap), y = lifeExp)+
  geom_point() +
  #to change the axis 
  scale_x_continuous(trans = "log10")

#color vs fill 

violin_plot <- ggplot(data = gapminder_1997)+
  aes(x= continent, y=lifeExp)+
  #color defines outline
  #fill fills it in with color
  #if you want to map a VARIABLE, you need to use the aes() instead if just a single color def
  geom_violin(aes(fill = continent))+
  geom_jitter(width= 0.3)
!
#define plot as a variable, and now you can save them 
#you can just add a plus sign to add more layers
#themes will give you a general display to make  things look nicer
violin_plot = <- violin_plot + theme_bw()

#to save plot
ggsave("awesome_violin_plot.jpg", plot=violin_plot,
       width = 6, height = 4)

#themes 
#making a histogram
ggplot(gapminder_1997)+
  aes(x= lifeExp)+
  #default bins is 30, you will get a message in your console unless you specify, you can also specify color, etc
  geom_histogram(bins = 20, color = "black")+
  theme_bw()+
  #to rotate the x axis labeling 
  #lots of options under "theme"
  #vjust (vertical) and hjust (horizontal) can move positioning 
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))
  

#facets
#when you wanna make the same plot BUT with different variables! 

ggplot(gapminder_1997)+
  aes(x = gdpPercap, y= lifeExp)+
  geom_point()+
  #define which vraiable you want to vary with "vars"
  facet_wrap(vars(continent))
  #this will give me different plots with JUST the data of a continent 

ggplot(gapminder_1997)+
  aes(x = gdpPercap, y= lifeExp, fill = continent)+
  #shapes are defined by numbers, you can look them up with google 
  geom_point(shape = 21, color = "black")+
  #define which vraiable you want to vary with "vars"
  #grid will give us a SINGLE x axis 
  #this will give me different plots with JUST the data of a continent 
  facet_grid(rows = vars(continent)) +
  labs(x="GDP Per Capita", y = "Life Expectancy", 
       title = "Do People in Wealthy Countries Live Longer?")+
  theme_bw()+
  #axis.title tells us what we're modifying
  #element_text tells us were modifying the text of the title
  #face is bold, italtics, etc 
  theme(axis.title = element_text(face = "bold"), 
        #to remove the legend
        legend.position = "none")

ggsave("awesome_plot.jpg")
