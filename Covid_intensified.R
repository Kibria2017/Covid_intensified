# Infectious disease epidemics

require(tidyverse)
require(gghighlight)
require(ggrepel)
require(readxl)

setwd("D:/globalhealthanalytics_dashboard")
data<- read_xlsx("covid_intensity.xlsx")

str(data)
data <- data %>% mutate_if(is.character, as.factor)

data$R0 <- round(data$R0)
data$CFR <- as.numeric(data$CFR)

data %>% ggplot(aes(R0, CFR)) + geom_point(aes(size = CFR), color = "#0072B2D0") + 
  geom_text_repel(aes(label = Disease), size = 3, vjust = .4, hjust = "inward") + theme_bw() + 
  theme(legend.position = "none") + 
  gghighlight(Disease == "COVID-19", unhighlighted_colour = alpha("steelblue", 0.4)) + 
  labs(y = "estimated case fatality rate (%)", 
       x = "infectiousness: average no. of people infected by each sick person", 
       title = "how contagious and fatal COVID-19 is?", subtitle = "Source: US CDC and WHO")

# same but the new version of gghighlight package has changed the unhighlighted_() argument
data %>% ggplot(aes(R0, CFR)) + geom_point(aes(size = CFR), color = "red") + 
  geom_text_repel(aes(label = Disease), size = 3, vjust = .4, hjust = "inward") + theme_bw() + 
  theme(legend.position = "none") + 
  gghighlight(Disease == "COVID-19", unhighlighted_params = list (size = 3, color = alpha("steelblue", 0.7))) + 
  labs(y = "estimated case fatality rate (%)", 
       x = "infectiousness: average no. of people infected by each sick person", 
       title = "how contagious and fatal COVID-19 is?", subtitle = "Source: US CDC and WHO")

