n = 10000
reliability = .80
true.score = rnorm(n)
measure.1 = true.score * sqrt(reliability) + rnorm(n) * sqrt(1 - reliability)
measure.2 = true.score * sqrt(reliability) + rnorm(n) * sqrt(1 - reliability)
change = measure.2 - measure.1

d = data.frame(true.score,
               measure.1,
               measure.2,
               change)
c = round(cor(d),3);c

c[4, 2]^2 + c[4, 3]^2 + c[1, 2]^2

text = str_c("Regression effect slope = ", -(1 - reliability))
grob = grobTree(textGrob(text, x = .95,  y = 0.95, hjust = 1,
                         gp=gpar(col="red", fontsize=13)))

ggplot(d, aes(measure.1, change)) +
  geom_point(alpha = .7) +
  geom_smooth(method = lm, se = F) +
  annotation_custom(grob) +
  scale_x_continuous(breaks = seq(-10, 10, by = .5)) +
  scale_y_continuous(breaks = seq(-10, 10, by = .5)) +
  xlab("First measurement") + ylab("Change between first and second measurement")

ggplot(d, aes(measure.1, measure.2)) +
  geom_point(alpha = .7) +
  geom_smooth(method = lm, se = F) +
  scale_x_continuous(breaks = seq(-10, 10, by = .5)) +
  scale_y_continuous(breaks = seq(-10, 10, by = .5)) +
  xlab("First measurement") + ylab("Second measurement")

