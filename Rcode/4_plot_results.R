# 4_plot_results.R
# look at the multipliers a number of ways

# set working directory to source file location to begin

library(dplyr)
library(ggplot2)

df <- read.csv("../data/multipliers.csv")

# Only GB cod
gbcod <- filter(df, StockID == "GBcod")

p1 <- ggplot(gbcod, aes(x=missing.data.mult, y=full.data.mult)) +
  geom_point() +
  geom_abline(slope = 1, linetype = "dashed") +
  geom_smooth(method='lm') +
  facet_wrap(~ StockID) +
  theme_bw()
p1
ggsave(filename = "../plots/GBcod.png", p1, width = 5, height = 5, units = "in")

# all stocks
p2 <- ggplot(df, aes(x=missing.data.mult, y=full.data.mult)) +
  geom_point() +
  geom_abline(slope = 1, linetype = "dashed") +
  geom_smooth(method='lm') +
  theme_bw()
p2
ggsave(filename = "../plots/all.png", p2, width = 5, height = 5, units = "in")

# all stocks colored
p3 <- ggplot(df, aes(x=missing.data.mult, y=full.data.mult, color=StockID)) +
  geom_point() +
  geom_abline(slope = 1, linetype = "dashed") +
  theme_bw() +
  theme(legend.position = "none")
p3
ggsave(filename = "../plots/all_colored.png", p3, width = 5, height = 5, units = "in")

# all stocks faceted
p4 <- ggplot(df, aes(x=missing.data.mult, y=full.data.mult, color=StockID)) +
  geom_point() +
  geom_abline(slope = 1, linetype = "dashed") +
  facet_wrap(~ StockID, scales = "free") +
  theme_bw() +
  theme(legend.position = "none")
p4
ggsave(filename = "../plots/all_faceted.png", p4, width = 8, height = 8, units = "in")

# grouped by terminal year
p5 <- ggplot(df, aes(x=missing.data.mult, y=full.data.mult, color=StockID)) +
  geom_point() +
  geom_abline(slope = 1, linetype = "dashed") +
  facet_wrap(~ TermYear, scales = "free") +
  theme_bw() +
  theme(legend.position = "none")
p5
ggsave(filename = "../plots/all_by_termyear.png", p5, width = 8, height = 8, units = "in")
