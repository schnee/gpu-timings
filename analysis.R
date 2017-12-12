library(dplyr)
library(ggplot2)
library(readr)
library(ggthemes)

timing <- read_csv("./timings.csv")


ggplot(timing, aes(x=model, y=seconds, color=gpu)) + geom_boxplot() +
  theme_few() +
  theme(axis.text.x = element_text(angle=45, hjust=1)) +
  ggtitle("Keras Examples Training Times") 
       