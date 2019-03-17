---
title: Tidy Tuesday Week 11 2019 - Board Game Analysis
author: Jared Braggins
date: '2019-03-17'
slug: tidy-tuesday-week-11-2019-board-game-analysis
categories:
  - Data Visualisation
  - Analysis
  - R
tags:
  - Analytics
  - Data Visualisation
  - Data Viz
  - Tidy Tuesday
  - R
  - Board Games
  - tidyverse
  - ggplot
  - dplyr
thumbnailImage: "/img/Board Game.png"
thumbnailImagePosition: left
---

I've started taking part in #TidyTuesday, a weekly project focused on using tidyverse packages to clean, wrangle, tidy, and plot a new dataset. The big draw card for me is getting better at using R for analysis. 

#### The Data
The data for week 11 was all about [board games](https://github.com/rfordatascience/tidytuesday/tree/master/data/2019/2019-03-12), which comes from the [Board Game Geek Database](https://boardgamegeek.com/)

#### Analysis
I kept it very simple this week. This was mainly due to my R skills slipping over the previous year.

First off, I imported the csv and took a look at the data.

  ```
library(tidyverse)

# import csv
bg <- read.csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-03-12/board_games.csv")


# Inspect the data
glimpse(bg)
  ```
  
Then I calculated the running total of the total published games over the years.

  ```
  # Get a running total of board games
running_total <-
  bg %>%
  group_by(year_published) %>%
  summarise(counts = n()) %>%
  mutate(running_total = cumsum(counts))
  ```
  
Lastly, I plotted the data and annotated the chart to show my findings.

  ```
# plot the running total by year
running_total %>%
  ggplot(aes(x = year_published, y = running_total)) +
  geom_line(color = 'deepskyblue4') +
  geom_area(fill = 'deepskyblue4', alpha = .1) +
  scale_x_continuous(breaks = seq(1950, 2020, 10)) +
  scale_y_continuous(labels = comma) +
  geom_vline(xintercept=2000, linetype = "dotted") +
  labs( title = "The Number of Board Games Published Since 1950",
        subtitle = "Based on a running total of board games",
        x = "Year",
        y = "No. of Board\nGames") +
  annotate("text", x = 1967, y = 9500, 
           label = "There has been a significant increase\nin the number of published board games\nafter 2000",
           hjust = 0, color = 'deepskyblue4') +
  theme_classic() +
  theme(axis.title.y = element_text(size = 10, vjust = 1, hjust = 0, angle = 0),
       axis.title.x = element_text(size = 10, hjust = 0)) 
  ```
Here's the chart
<img src="/img/Board Game.png" title="/img/Board Game"/>

#### Conclusion
My analysis for this week's #TidyTuesday wasn't as detailed as I would have liked, but I did get in some valuable ggplot practice.