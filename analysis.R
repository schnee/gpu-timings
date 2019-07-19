library(dplyr)
library(ggplot2)
library(readr)
library(ggthemes)

timing <- read_csv("./timings.csv")


ggplot(timing , aes(x=model, y=seconds, color=gpu)) + geom_boxplot() +
  theme_few() +
  theme(axis.text.x = element_text(angle=45, hjust=1)) +
  ggtitle("Keras Examples Training Times") + ylab("Seconds per Epoch") +
  xlab("Example Name")
       
ggplot(timing, aes(x=seconds, fill=gpu)) + facet_wrap(~model, ncol=1) +geom_density(alpha=0.5)

t1070 <- timing %>% filter(gpu != "P100")


baseline <- t1070 %>% 
#  filter(gpu == "1070ti") %>% 
  group_by(model, gpu) %>% summarize(mean=mean(seconds)) %>% mutate(ratio = mean / lag(mean))

baseline[is.na(baseline$ratio),]$ratio <- 1

ggplot(baseline, aes(x=model, y=ratio, fill=gpu)) + 
  geom_col(position = 'dodge') + theme_few() +
  theme(axis.text.x = element_text(angle=45, hjust=1)) +
  ggtitle("Model Training Means (relative)") + ylab("Relative to no docker") +
  xlab("Example Name")
