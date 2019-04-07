---
title: Seattle Pet Names
author: Jared Braggins
date: '2019-03-27'
slug: tidytuesday-week-13-2019-seattle-pet-names
categories:
  - Analysis
  - R
  - Data Visualisation
tags:
  - Analysis
  - Data Visualisation
  - dplyr
  - ggplot2
  - TidyTuesday
  - R
thumbnailImage: "/img/Top Ten Pet Names.png"
thumbnailImagePosition: left
---

This is my post for #TidyTuesday Week 13, which looked at pet names in Seattle.

#### The Data
Week 13's data comes from Seattle's open data portal and contains information about registered pets. 

#### The Analysis
Since this was a quick #TidyTuesday this week I decided to visualise the top ten pet names. I highlighted the most popular name in a different colour to help it stand out.

Here's the code:
  ```
  
library(tidyverse)

seattle_pets <- read.csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-03-26/seattle_pets.csv")

# Inspect data
View(seattle_pets)

# Find top ten names for all pets
pet_names <-
  seattle_pets %>% 
  filter(!is.na(animals_name)) %>%
  group_by(animals_name) %>%
  summarise(count=n()) %>%
  top_n(n=10, count)

# Reorder names by count from largest to smallest
pet_names$animals_name <- factor(pet_names$animals_name) %>%
  fct_reorder(pet_names$count)

# Plot Pet Names
pet_names %>%
  mutate(highlight_flag = ifelse(animals_name == "Lucy",T,F)) %>%
  ggplot(aes(x = animals_name, y = count, fill = highlight_flag)) +
  geom_col() + 
  scale_fill_manual(values = c('grey65', 'skyblue4')) +
  theme_classic() +
  labs(title = "Top Ten Pet Names in Seattle",
       subtitle = "For Pets Registered in 2018",
       x = "",
       y = "",
       caption = "Data source: seattle.gov") +
  coord_flip() +
  geom_text(aes(label=count), hjust = 1.5, color = 'white') +
  theme(legend.position = "none",
        text = element_text(size = 10),
        plot.caption=element_text(hjust=1,size=9,colour="grey30"),
        plot.subtitle=element_text(face="italic",size=11,colour="grey40"),
        plot.title=element_text(size=14,face="bold"),
        axis.ticks = element_blank(),
        axis.line = element_blank(),
        axis.text.x = element_blank())
  ```

Here's the chart:
<img src="/img/Top Ten Pet Names.png" title="/img/Top Ten Pet Names"/>

#### Conclusion
This was a fun dataset to explore, especially in seeing what people name their pets in Seattle! Unfortunately, due to a busy week, I didn't get the time to really dig into it. If I had more time I would have likeed to explore different pet names by species, or number of registrations by zip code.
