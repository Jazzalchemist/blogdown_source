---
title: Tidy Tuesday Week 12 2019 - Stanford Policing Project Analysis
author: Jared Braggins
date: '2019-03-20'
slug: tidy-tuesday-week-12-2019-stanford-policing-project-analysis
categories:
  - Analysis
  - Data Visualisation
  - R
tags:
  - Data Visualisation
  - Data Viz
  - '#TidyTuesday'
  - R
  - tidyverse
  - ggplot2
  - dplyr
thumbnailImage: "/img/Annual_Stops.png"
thumbnailImagePosition: left
---

My second week taking part in #TidyTuesday! Let's keep the ball rolling...

#### The Data
The data for week 12 was all about [traffic stops made by US police officers](https://github.com/rfordatascience/tidytuesday/tree/master/data/2019/2019-03-12), which comes from the [Stanford Open Policing Project](https://openpolicing.stanford.edu/)

#### Analysis
I wanted to continue focusing on refreshing my ggplot2 skills this week, particularly around the use of using facet_wrap(). My approach to the analysis was to have a look at driver race in terms of number of traffic stops. I wanted to use small multiples to show this for each state.  

So lets bring the data in and convert the state abbreviations to full state names:

  ```
library(tidyverse)
library(scales)

# import data
combined_data <- read.csv("https://raw.githubusercontent.com/5harad/openpolicing/master/results/data_for_figures/combined_data.csv")

# Convert abbr to state name  (Credit to Jerrick Tram for this great solution)
names(combined_data)[2] <- "region"
combined_data$region <- str_to_lower(state.name[match(combined_data$region, state.abb)])

  ```
  
Then visualise the number of traffice stops, per driver race, per state:

  ```
  # Plot number of stops per ethnicity per state 
combined_data %>%
group_by(region, driver_race) %>%
summarise(n = sum(stops_per_year)) %>%
arrange(-n) %>%
mutate(highlight_flag = ifelse(driver_race == 'White', T, F)) %>%
ggplot(aes(x=reorder(driver_race, n), y=n, fill = highlight_flag)) + 
scale_fill_manual(values = c('#595959', 
                              'orange2')) +
geom_bar(stat="identity") +
theme_classic() +
theme(legend.position = "none",
      text = element_text(size = 10),
      plot.caption=element_text(hjust=1,size=9,colour="grey30"),
      plot.subtitle=element_text(face="italic",size=11,colour="grey40"),
      plot.title=element_text(size=14,face="bold")) +
labs( title = " Annual Stops by Law Enforcement",
      subtitle = "Grouped By Driver Race",
      x = "Driver Race",
      y = "Stops",
      caption = "Data Source: Stanford Open Policing Project") +
scale_y_continuous(labels = comma) +
coord_flip() +
facet_wrap(~region, ncol = 3)  +
theme(strip.text.x = element_text(size=8),
      strip.text.y = element_text(size=10, face="bold"),
      strip.background = element_rect(colour="white", 
                                  fill="gray96"))
  ```
Finally, let's save the chart as an image:

  ```
  # Save image of chart
ggsave(
  filename = 'Annual_Stops.png',
  height = 20,
  width = 20,
  units = 'cm',
  dpi = 600
)
  
  ```

  
Here's the chart
<img src="/img/Annual_Stops.png" title="/img/Annual Stops"/>

#### Conclusion
I really like how the final chart turned out! This was a very interesting dataset to play around with. 


