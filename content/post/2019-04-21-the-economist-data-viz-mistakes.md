---
title: The Economist Data Viz Mistakes
author: Jared Braggins
date: '2019-04-21'
slug: the-economist-data-viz-mistakes
categories:
  - Analysis
  - Data Visualisation
  - R
tags:
  - Analysis
  - Data Visualisation
  - dplyr
  - ggplot2
  - tidyverse
  - TidyTuesday
thumbnailImage: "/img/pension.png"
thumbnailImagePosition: left
---

My focus for #TidyTuesday Week 16 was on trying to replicate a chart. For context, the idea was to explore the data behind some before and after charts from the [Economist](https://medium.economist.com/mistakes-weve-drawn-a-few-8cdd8a42d368). Here are the charts I was looking at:

<img src="/img/1_4RND--Bo31DVfiziaa-HBA.png" title="/img/Brazilian Pension Charts"/>

Instead of trying to make my own version of the better chart, I decided to try and figure out how to replicate some of the elements in it. Specifically:

- Highlighting points in a scatterplot
- Label the highlighted points, but to also add custom formatting to some of the labels only

Here's the code:
  ```
  # Load libraries
library(tidyverse)
library(scales)

# Import data
pensions <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-16/pensions.csv")

# Set chart theme
theme_set(theme_light())

# Filter countries for colours/labels
Brazil <- pensions %>% 
  filter(country == "Brazil")

Labels <- pensions %>% 
  filter(country %in% c("France", "Japan", "Italy", "Mexico", "South Korea", "Turkey", 
                        "United States", "Greece", "Poland"))

# Calculate OECD average
OECD = pensions %>% 
  summarise(pop_65_percent = mean(pop_65_percent), 
            gov_spend_percent_gdp = mean(gov_spend_percent_gdp))

# Create scatterplot
pensions %>% 
  ggplot(aes(pop_65_percent, gov_spend_percent_gdp)) +
  geom_point(color = "#2DC0D2", size = 3, alpha = 1) +
  geom_point(aes(pop_65_percent, gov_spend_percent_gdp), 
             data = Brazil, color =  "black", pch = 21, size = 4) +
  geom_point(aes(pop_65_percent, gov_spend_percent_gdp),
             data = Labels, color =  "black", pch = 21, size = 4) +
  geom_point(aes(pop_65_percent, gov_spend_percent_gdp),
             fill = "#2DC0D2", data = OECD, color =  "black", pch = 21, size = 4) +
  geom_text(aes(pop_65_percent, gov_spend_percent_gdp, label = country), 
            data = Brazil, color = "black", fontface = "bold", size = 3.5, nudge_y = 1, nudge_x = -1.5) +
  geom_text(aes(pop_65_percent, gov_spend_percent_gdp, label = country), 
            data = Labels, color = "black", size = 3, nudge_y = 1, nudge_x = -1.5) +
  geom_text(aes(pop_65_percent, gov_spend_percent_gdp, label = "OECD average"), 
            data = OECD, color = "black", fontface = "italic", size = 3, nudge_y = 1, nudge_x = -1.5) +
  scale_y_continuous(limits = c(0,20)) +
  scale_x_continuous(limits = c(0,35)) +
  labs(title = "Brazil's golden oldie blowout",
       subtitle = "Latest Available",
       x = "Population aged 65 years and over, % of total",
       y = "Government spending\non pension benefits\n% of GDP",
       caption = "Sources: OECD; World Bank; Previdencia Social") +
  theme(axis.title.y = element_text(size = 10, colour="grey15", vjust = 1, hjust = 0, angle = 0),
        axis.title.x = element_text(size = 10, colour="grey15"),
        plot.title = element_text(size=14,face="bold"),
        plot.subtitle = element_text(size=11,colour="grey15"),
        plot.caption = element_text(size=10,colour="grey38"),
        plot.background = element_rect(fill = "#D9E9F0"),
        panel.background = element_rect(fill = "#D9E9F0"))

# Save chart as png
aspect_ratio <- 2
ggsave("pension.png", height = 5 , width = 3 * aspect_ratio)
  ```
  
Here's my replicated chart:
<img src="/img/pension.png" title="/img/Brazilian Pension Chart"/>

#### Conclusion
This week presented a great ggplot2 formatting challenge for me. I've applied highlighting to bar charts in ggplot2, but never scatterplots. It took me awhile to get my head around how to apply custom formatting to different points, but I now feel more confident in how I can customise scatterplots in R.

