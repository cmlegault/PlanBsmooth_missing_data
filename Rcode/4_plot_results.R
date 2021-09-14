# 4_plot_results.R
# look at the multipliers a number of ways

# set working directory to source file location to begin

library(dplyr)
library(tidyr)
library(ggplot2)

df <- read.csv("../data/multipliers.csv")
corrdf <- read.csv("../data/correlations.csv")

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

p1f <- ggplot(gbcod, aes(x=filled.data.mult, y=full.data.mult)) +
  geom_point() +
  geom_abline(slope = 1, linetype = "dashed") +
  geom_smooth(method='lm') +
  facet_wrap(~ StockID) +
  theme_bw()
p1f
ggsave(filename = "../plots/GBcodf.png", p1f, width = 5, height = 5, units = "in")

# all stocks
p2 <- ggplot(df, aes(x=missing.data.mult, y=full.data.mult)) +
  geom_point() +
  geom_abline(slope = 1, linetype = "dashed") +
  geom_smooth(method='lm') +
  theme_bw()
p2
ggsave(filename = "../plots/all.png", p2, width = 5, height = 5, units = "in")

p2f <- ggplot(df, aes(x=filled.data.mult, y=full.data.mult)) +
  geom_point() +
  geom_abline(slope = 1, linetype = "dashed") +
  geom_smooth(method='lm') +
  theme_bw()
p2f
ggsave(filename = "../plots/allf.png", p2f, width = 5, height = 5, units = "in")

# all stocks colored
p3 <- ggplot(df, aes(x=missing.data.mult, y=full.data.mult, color=StockID)) +
  geom_point() +
  geom_abline(slope = 1, linetype = "dashed") +
  theme_bw() +
  theme(legend.position = "none")
p3
ggsave(filename = "../plots/all_colored.png", p3, width = 5, height = 5, units = "in")

p3f <- ggplot(df, aes(x=filled.data.mult, y=full.data.mult, color=StockID)) +
  geom_point() +
  geom_abline(slope = 1, linetype = "dashed") +
  theme_bw() +
  theme(legend.position = "none")
p3f
ggsave(filename = "../plots/all_coloredf.png", p3f, width = 5, height = 5, units = "in")

# all stocks faceted
p4 <- ggplot(df, aes(x=missing.data.mult, y=full.data.mult, color=StockID)) +
  geom_point() +
  geom_abline(slope = 1, linetype = "dashed") +
  facet_wrap(~ StockID, scales = "free") +
  theme_bw() +
  theme(legend.position = "none")
p4
ggsave(filename = "../plots/all_faceted.png", p4, width = 8, height = 8, units = "in")

p4f <- ggplot(df, aes(x=filled.data.mult, y=full.data.mult, color=StockID)) +
  geom_point() +
  geom_abline(slope = 1, linetype = "dashed") +
  facet_wrap(~ StockID, scales = "free") +
  theme_bw() +
  theme(legend.position = "none")
p4f
ggsave(filename = "../plots/all_facetedf.png", p4f, width = 8, height = 8, units = "in")

# all stocks faceted - same axes
p4a <- ggplot(df, aes(x=missing.data.mult, y=full.data.mult, color=StockID)) +
  geom_point() +
  geom_abline(slope = 1, linetype = "dashed") +
  facet_wrap(~ StockID) +
  theme_bw() +
  theme(legend.position = "none")
p4a
ggsave(filename = "../plots/all_faceted_same_axes.png", p4a, width = 8, height = 8, units = "in")

p4af <- ggplot(df, aes(x=filled.data.mult, y=full.data.mult, color=StockID)) +
  geom_point() +
  geom_abline(slope = 1, linetype = "dashed") +
  facet_wrap(~ StockID) +
  theme_bw() +
  theme(legend.position = "none")
p4af
ggsave(filename = "../plots/all_faceted_same_axesf.png", p4af, width = 8, height = 8, units = "in")

# grouped by terminal year
p5 <- ggplot(df, aes(x=missing.data.mult, y=full.data.mult, color=StockID)) +
  geom_point() +
  geom_abline(slope = 1, linetype = "dashed") +
  facet_wrap(~ TermYear, scales = "free") +
  theme_bw() +
  theme(legend.position = "none")
p5
ggsave(filename = "../plots/all_by_termyear.png", p5, width = 8, height = 8, units = "in")

p5f <- ggplot(df, aes(x=filled.data.mult, y=full.data.mult, color=StockID)) +
  geom_point() +
  geom_abline(slope = 1, linetype = "dashed") +
  facet_wrap(~ TermYear, scales = "free") +
  theme_bw() +
  theme(legend.position = "none")
p5f
ggsave(filename = "../plots/all_by_termyearf.png", p5f, width = 8, height = 8, units = "in")

# grouped by terminal year - same axes
p5a <- ggplot(df, aes(x=missing.data.mult, y=full.data.mult, color=StockID)) +
  geom_point() +
  geom_abline(slope = 1, linetype = "dashed") +
  facet_wrap(~ TermYear) +
  theme_bw() +
  theme(legend.position = "none")
p5a
ggsave(filename = "../plots/all_by_termyear_same_axes.png", p5a, width = 8, height = 8, units = "in")

p5af <- ggplot(df, aes(x=filled.data.mult, y=full.data.mult, color=StockID)) +
  geom_point() +
  geom_abline(slope = 1, linetype = "dashed") +
  facet_wrap(~ TermYear) +
  theme_bw() +
  theme(legend.position = "none")
p5af
ggsave(filename = "../plots/all_by_termyear_same_axesf.png", p5af, width = 8, height = 8, units = "in")

# compute differences, squared differences, and relative of both from multipliers
diffdf <- df %>%
  mutate(diff = full.data.mult - missing.data.mult,
         diff2 = diff ^ 2,
         reldiff = diff / missing.data.mult,
         reldiff2 = reldiff ^ 2) %>%
  group_by(StockID) %>%
  summarize(avgdiff = mean(diff),
            avgdiff2 = mean(diff2),
            avgreldiff = mean(reldiff),
            avgreldiff2 = mean(reldiff2)) %>%
  pivot_longer(cols = !StockID, names_to = "metric", values_to = "value") %>%
  left_join(corrdf, by = "StockID")

p6 <- ggplot(diffdf, aes(x=corr, y=value)) +
  geom_point() +
  facet_wrap(~ metric, scales = "free_y") +
  theme_bw()
p6
ggsave(filename = "../plots/corr_diffs.png", p6, width = 6, height = 6, units = "in")

diffdff <- df %>%
  mutate(diff = full.data.mult - filled.data.mult,
         diff2 = diff ^ 2,
         reldiff = diff / filled.data.mult,
         reldiff2 = reldiff ^ 2) %>%
  group_by(StockID) %>%
  summarize(avgdiff = mean(diff),
            avgdiff2 = mean(diff2),
            avgreldiff = mean(reldiff),
            avgreldiff2 = mean(reldiff2)) %>%
  pivot_longer(cols = !StockID, names_to = "metric", values_to = "value") %>%
  left_join(corrdf, by = "StockID")

p6f <- ggplot(diffdff, aes(x=corr, y=value)) +
  geom_point() +
  facet_wrap(~ metric, scales = "free_y") +
  theme_bw()
p6f
ggsave(filename = "../plots/corr_diffsf.png", p6f, width = 6, height = 6, units = "in")

diffdiff <- left_join(diffdf, diffdff, by = c("StockID", "metric"))
p7 <- ggplot(diffdiff, aes(x=value.x, y=value.y)) +
  geom_point() +
  facet_wrap(~ metric, scales = "free_y") +
  xlab("missing") +
  ylab("filled") +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed") +
  theme_bw()
p7
ggsave(filename = "../plots/diffdiff.png", p7, width = 6, height = 6, units = "in")

pdf(file="../plots/allplots.pdf")
print(p1)
print(p1f)
print(p2)
print(p2f)
print(p3)
print(p3f)
print(p4)
print(p4f)
print(p4a)
print(p4af)
print(p5)
print(p5f)
print(p5a)
print(p5af)
print(p6)
print(p6f)
print(p7)
dev.off()

