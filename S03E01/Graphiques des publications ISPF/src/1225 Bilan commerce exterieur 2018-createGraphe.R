library(ggrepel)
windowsFonts("Roboto" = windowsFont("Roboto Light"))
#font_import()
ispfPalette <- c("#56B4E9", "#B359B4", "#FF9D37", "#009FA4", "#999999", "#FF0000", "#D55E00", "#CC79A7")
custom.col <- c(ispfPalette[2], ispfPalette[1], "#FFFFFF")

cat("Cr�ation des graphiques en PDF\n")
i <- 6

createSimpleGGPlot <- function(i){
  graphe <- fread(sprintf("graphe%d.txt", i), encoding = "UTF-8", header = T)
  graphe <- melt(graphe,id.vars="Ann�e")
  #graphe3$variable <- factor(graphe3$variable,levels(graphe3$variable)[c(4,1,5,3,2,6)])
  g <- ggplot(graphe, aes(x=Ann�e, y=value, fill=variable, colour=variable)) +
    geom_line()+
    geom_point()+
    scale_y_continuous(labels = scales::number_format(accuracy = 1))+
    scale_x_continuous(labels = scales::number_format(accuracy = 1, big.mark = ''))+
    scale_fill_manual(values=ispfPalette)+
    scale_colour_manual(values=ispfPalette)+
    theme_ispf()+
    ylab("")+
    theme(legend.position = "bottom",legend.direction = "horizontal")
  g
}



g1 <- createSimpleGGPlot(1)+
  scale_y_continuous(labels = scales::percent_format(accuracy = 1),
                     breaks=seq(0.05,0.14,0.02),
                     limits=c(0.05,0.14))
  
                   

graphe2 <- fread("graphe2.txt", encoding = "UTF-8", header = T)
graphe2 <- melt(graphe2,id.vars="Ann�e")
graphe2$Ann�e <- factor(graphe2$Ann�e)

g2 <- ggplot(graphe2,aes(x = variable,y=value, fill=Ann�e, colour=Ann�e)) +
  geom_bar(stat="identity", position="dodge", width = 0.8)+
  geom_text(aes(label=scales::number(value, accuracy = 1)),
            position = position_dodge(width=0.8), vjust=1, hjust=1,
            color="white", size=2)+
  scale_fill_manual(values=ispfPalette)+
  scale_colour_manual(values=ispfPalette)+
  scale_y_continuous(labels = scales::number_format(accuracy = 1))+
  theme_ispf()+
  ylab("")+xlab("")+
  theme(legend.position = "right",legend.direction = "vertical")+
  coord_flip()


graphe3 <- fread("graphe3.txt", encoding = "UTF-8", header = T)
graphe3 <- melt(graphe3,id.vars="Ann�e")
graphe3[,variable:=stringr::str_wrap(variable, 15)]
graphe3$variable=factor(graphe3$variable, 
                        levels=stringr::str_wrap(c("Ouvrages en perles en valeur","Autres perles (keshi, mabe) en valeur",
                                 "Perles brutes en valeur", "Perles brutes en volume"),15))
graphe3$Ann�e <- factor(graphe3$Ann�e)
g3 <- ggplot(graphe3, aes(x=Ann�e, y=value, fill=variable, colour=variable)) +
  geom_col( data=graphe3[variable!="Perles brutes en volume"], width = 0.5)+
  geom_line(aes(x=Ann�e, y=value/2, group="variable"),
            data=graphe3[variable=="Perles brutes\nen volume"])+
  geom_point(aes(x=Ann�e, y=value/2),
             data=graphe3[variable=="Perles brutes\nen volume"])+
  scale_fill_manual(values=ispfPalette)+
  scale_colour_manual(values=ispfPalette)+
  
  #scale_x_discrete(limits=c(1995,2000,2005,2011,2013,2015,2018), labels=c(1995,2000,2005,2011,2013,2015,2018))+
  scale_y_continuous(name = "Millions de F.CFP",
                     limits = c(0, 10000),
                     labels = scales::number_format(accuracy = 1),
                     sec.axis = sec_axis(~./500, 
                                         name = "Tonnes",
                                         labels = scales::number_format(accuracy = 1)))+
  theme_ispf()+
  theme(axis.title.x=element_blank())+
  theme(legend.position = "bottom",legend.direction = "horizontal")

graphe4 <- fread("graphe4.txt", encoding = "UTF-8", header = T)
graphe4 <- melt(graphe4,id.vars="Ann�e")
graphe4$Ann�e <- factor(graphe4$Ann�e)
graphe4[,variable:=stringr::str_wrap(variable,15)]
graphe4$variable=factor(graphe4$variable, 
                        levels=stringr::str_wrap(c("Autres","Poissons congel�s",
                                                   "Filets et chairs de poissons",
                                                   "Poissons frais ou r�frig�r�s"),15))
g4 <- ggplot(graphe4,aes(x = Ann�e,y=value, fill=variable, colour=variable)) +
  geom_bar(stat="identity", position="stack", width = 0.8)+
  geom_text(aes(label=scales::number(value, accuracy = 1)),
            position = position_stack(), vjust=1, hjust=1,
            color="white", size=2)+
  scale_fill_manual(values=rev(ispfPalette[1:4]))+
  scale_colour_manual(values=rev(ispfPalette[1:4]))+
  scale_y_continuous(labels = scales::number_format(accuracy = 1))+
  theme_ispf()+
  ylab("")+xlab("")+
  theme(axis.title.x=element_blank())+
  theme(legend.position = "bottom",legend.direction = "horizontal")


graphe5 <- fread("graphe5.txt", encoding = "UTF-8", header = T)
graphe5 <- melt(graphe5,id.vars="Ann�e")
graphe5$Ann�e <- factor(graphe5$Ann�e)

g5 <- ggplot(graphe5,aes(x = variable,y=value, fill=Ann�e, colour=Ann�e)) +
  geom_bar(stat="identity", position="dodge", width = 0.8)+
  geom_text(aes(label=scales::number(value, accuracy = 1)),
            position = position_dodge(width=0.8), vjust=1, hjust=1,
            color="white", size=2)+
  scale_fill_manual(values=ispfPalette)+
  scale_colour_manual(values=ispfPalette)+
  scale_y_continuous(labels = scales::number_format(accuracy = 1))+
  theme_ispf()+
  ylab("")+xlab("")+
  theme(legend.position = "right",legend.direction = "vertical")+
  coord_flip()



suppressMessages(ggsave("graphe1.pdf", g1, width = 9, height=7, units = "cm", device=cairo_pdf))
suppressMessages(ggsave("graphe2.pdf", g2, width = 9, height=5, units = "cm", device=cairo_pdf))
suppressMessages(ggsave("graphe3.pdf", g3, width = 9, height=5, units = "cm", device=cairo_pdf))
suppressMessages(ggsave("graphe4.pdf", g4, width = 9, height=6, units = "cm", device=cairo_pdf))
suppressMessages(ggsave("graphe5.pdf", g5, width = 9, height=5, units = "cm", device=cairo_pdf))


suppressMessages(ggsave("graphe1.svg", g1, width = 9, height=7, units = "cm", device=svg))
suppressMessages(ggsave("graphe2.pdf", g2, width = 9, height=5, units = "cm", device=cairo_pdf))
suppressMessages(ggsave("graphe3.pdf", g3, width = 9, height=5, units = "cm", device=cairo_pdf))
suppressMessages(ggsave("graphe4.pdf", g4, width = 9, height=6, units = "cm", device=cairo_pdf))
suppressMessages(ggsave("graphe5.pdf", g5, width = 9, height=5, units = "cm", device=cairo_pdf))
