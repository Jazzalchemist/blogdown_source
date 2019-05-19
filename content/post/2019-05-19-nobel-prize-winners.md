---
title: Nobel Prize Winners
author: Jared Braggins
date: '2019-05-19'
slug: nobel-prize-winners
categories:
  - Analysis
  - Data Visualisation
  - R
tags:
  - Analysis
  - Data Visualisation
  - Maps
  - dplyr
  - ggplot2
  - lubridate
  - R
  - TidyTuesday
  - tidyverse
thumbnailImage: "/img/TidyTuesday/Wk_20_2019/Nobel Map.png"
thumbnailImagePosition: top
---

For #TidyTuesday week 20 we looked at Nobel Prize Laureates.

##### The Data
The data for week 20 can be found on [Kaggle](https://www.kaggle.com/nobelfoundation/nobel-laureates).

##### The Analysis
For this week I wanted to continue my focus on creating maps, so I decided to visualise Nobel Prize Laureates by country of origin. For a bit of additional practice I created a boxplot to visualise Nobel Prize Laureates by gender and category.

Here's the code:
  ```
# Load packages
library(tidyverse)
library(lubridate)
library(extrafont)
library(paletteer)


getwd()
# Load data
nobel_winners <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-05-14/nobel_winners.csv") %>% 
  mutate(birth_year = year(birth_date)) %>% 
  mutate(birth_date = ymd(as.character(birth_date)))


# View the data
View(nobel_winners)


# Summarise data
nobel_filtered <- nobel_winners %>% 
  count(birth_country, sort = TRUE) %>% 
  filter(!is.na(birth_country))

# Update country names in nobel data
nobel_filtered <- nobel_filtered %>% 
  mutate(birth_country = str_replace_all(birth_country, c("Czechoslovakia" = "Czech Republic",
                                         "Northern Ireland" = "United Kingdom",
                                         "Scotland" = "United Kingdom",
                                         "East Germany" = "Germany",
                                         "United States of America" = "USA",
                                         "Guadeloupe Island" = "France",
                                         "Union of Soviet Socialist Republics" = "Russia",
                                         "Serbia" = "Republic of Serbia",
                                         "Republic of Macedonia" = "Macedonia")))


# Load world map
map.world <- map_data('world') %>% 
  filter(region != "Antarctica")

map_data('world') %>%
  group_by(region) %>%
  summarise()


# Join datasets
country_join <- left_join(map.world, nobel_filtered, by = c('region' = 'birth_country'))


# Set theme
my_background <- 'grey89'
my_textcolour <- "grey19"
my_font <- 'Century Gothic'
my_theme <- theme(text = element_text(family = my_font),
                  plot.title = element_text(face = 'bold', size = 16),
                  plot.background = element_rect(fill = my_background),
                  plot.subtitle = element_text(size = 14, colour = my_textcolour),
                  plot.caption = element_text(size = 8, hjust = 1.15, colour = my_textcolour),
                  panel.background = element_rect(fill = my_background, colour = my_background),
                  panel.border = element_blank(),
                  panel.grid.major.y = element_blank(),
                  panel.grid.minor.y = element_blank(),
                  panel.grid.major.x = element_blank(),
                  panel.grid.minor.x = element_blank(),
                  axis.text = element_blank(),
                  legend.background = element_rect(fill = my_background),
                  legend.key = element_rect(fill = my_background),
                  legend.title.align = 1)

theme_set(theme_light() + my_theme)
world_map <- borders("world", colour = "grey89", size = 0.05)


# Plot map
ggplot(country_join, aes( x = long, y = lat)) +
  geom_polygon(aes(fill = n, group = group )) +
 #scale_fill_gradientn(colours = c('#9CDA3B','#24858C', '#31668E')) +
  labs(title = "Nobel Prize Winners by Country of Origin",
       subtitle = "1901 - 2016",
       x = "",
       y = "",
       caption = "Visualisation: @JaredBraggins | Data Source: Harvard Dataverse",
       fill = "# of Winners") +
  world_map +
  scale_fill_paletteer_c("ggthemes", "Temperature Diverging", -1,
                         breaks = c(50, 150, 250))

ggsave('Nobel Map.png', device = "png", type = "cairo")


# Calculate prize winners' age
winner_age <- nobel_winners %>% 
  select(full_name, birth_year, gender, prize_year, category) %>% 
  mutate(age = as.numeric(prize_year - birth_year)) %>% 
  filter(!is.na(birth_year))


# Boxplot of prize winner age/gender
winner_age %>% 
  ggplot(aes(category, age, fill = gender)) +
  geom_boxplot() +
  scale_fill_manual(values = c('#D4855A', '#6C4E97')) +
  labs(x = "Category", 
       y = "Age",
       title = "Nobel Prize Winners by Age and Gender",
       caption = "Visualisation: @JaredBraggins | Data Source: Harvard Dataverse") +
  theme(axis.line = element_line(colour = "black"),
        axis.text = element_text(),
        axis.ticks = element_line(colour = "black"))

ggsave('Nobel Boxplot.png', device = "png", type = "cairo")

  ```
  
Here are the charts:
<img src="/img/TidyTuesday/Wk_20_2019/Nobel Map.png" title="Nobel Prize Winners by Country of Origin"/>
<img src="/img/TidyTuesday/Wk_20_2019/Nobel Boxplot.png" title="Nobel Prize Winners by Age and Gender"/>

##### Conclusion/Lessons Learned
To be honest, I rushed my #TidyTuesday submission this week. I wanted to build a map again after week 19's submission, but I didn't consider that some of the country names weren't going to match between the Nobel Prize data and the world map data. This was pointed to me by a Twitter user who questioned why my map showed that the USA didn't seem to have any Nobel Prize winners. 

So there's one major lesson I'll be taking away from this week's #TidyTuesday. It's something that I should and do know, but I have a bad habit of not doing - I must remember to review my own work before publishing it!
