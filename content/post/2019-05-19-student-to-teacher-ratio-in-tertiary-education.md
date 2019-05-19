---
title: Student to Teacher Ratio in Tertiary Education
author: Jared Braggins
date: '2019-05-19'
slug: student-to-teacher-ratio-in-tertiary-education
categories:
  - Analysis
  - Data Visualisation
  - R
tags:
  - Analysis
  - Maps
  - Data Visualisation
  - dplyr
  - ggplot2
  - R
  - TidyTuesday
  - tidyverse
thumbnailImage: "/img/TidyTuesday/Wk_19_2019/Student Ratios.png"
thumbnailImagePosition: left
---

For #TidyTuesday week 19 we looked at global student to teacher ratios.

##### The Data
The data for week 19 comes from the [UNESCO Institute of Statistics](http://data.uis.unesco.org/index.aspx?queryid=180).

##### The Analysis
For this week I wanted to focus on student to teacher ratios for tertiary education. I wanted to see what this looked like on a gobal scale, so I decided to show this on a map.

Here's the code:
  ```
  # Load packages
library(tidyverse)
library(extrafont)

# Import data
student_ratio <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-05-07/student_teacher_ratio.csv")


# Inspect data
View(student_ratio)

# Group countries and calculate mean
ratio_grouped <-student_ratio %>%
  filter(indicator == "Tertiary Education") %>% 
  group_by(country) %>%
  mutate(mean = mean(student_ratio, na.rm = TRUE))


# Load world map
map.world <- map_data('world') %>% 
  filter(region != "Antarctica")

map_data('world') %>%
  group_by(region) %>%
  summarise()


# Join datasets
country_join <- left_join(map.world, ratio_grouped, by = c('region' = 'country'))


# Set theme
my_background <- 'white'
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
                  axis.text = element_blank())

theme_set(theme_light() + my_theme)


# Plot map and save image
ggplot(data = country_join, aes(x = long, y = lat, group = group)) +
  geom_polygon(aes(fill = mean)) +
  scale_fill_gradientn(colours = c('#F9E53F', '#7FD157','#2A8A8C','#404E88', '#461863', '#462255')) +
  labs(title = "Student to Teacher Ratio in Tertiary Education",
       subtitle = "2012 - 2018",
       x = "",
       y = "",
       caption = "Visualisation: @JaredBraggins | Data Source: UNESCO Institute of Statistics") +
  guides(
    fill = guide_legend(title = "Ratio"))

ggsave('Student Ratios.png', device = "png", type = "cairo")

  ```
  
Here's the chart:
<img src="/img/TidyTuesday/Wk_19_2019/Student Ratios.png" title="Student to Teacher Ratio in Tertiary Education"/>

##### Conclusion/Lessons Learned
This was my first map created in R! It was a challenge trying to figure out how to join another dataset to the world map data. I did enjoy customising the map though. Bring on more maps!