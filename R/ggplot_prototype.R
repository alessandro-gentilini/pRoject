

# -------------------------
# prototype of ggplot theme
# -------------------------

morley <- head(morley,20)

p <- ggplot(morley, aes(x=Run))
p <- p + theme(panel.grid.major = element_blank(),
			   panel.grid.minor = element_blank(),
			   panel.background = element_rect(fill
			   								= '#002b36'),
			   axis.line = element_line(colour = "black"),
			   legend.text=element_text(size=16),
			   legend.title=element_blank(),
			   axis.title.x = element_text(vjust=0, size=16),
			   axis.title.y = element_text(vjust=1, size=16),
			   plot.title   = element_text(vjust=1.5, size=20))
p <- p + geom_line(aes(y=Speed), colour = '#268bd2' )
p <- p + geom_point(aes(y=Speed), colour = '#cb4b16')
p <- p + scale_x_discrete(breaks = morley$Run)
p <- p + labs(title = "Morley runs")
p <- p + labs(x = "Runs")
p <- p + labs(y = "Speed")
show(p)

