graphe1 <- readCSVFile(1)
graphe1 <- melt(graphe1,id.vars="Ann�e")
g1 <- ggplot(graphe1,aes(x = Ann�e,y=value, color=variable)) +
  geom_line()+
  scale_x_continuous(labels = scales::number_format(accuracy = 1, big.mark = ''), breaks = seq(2010,2020,2))+
  scale_y_continuous(labels = scales::percent_format(accuracy = 1), limits=c(0.00,0.15),)+
  scale_fill_manual(values=ispfPalette)+
  scale_colour_manual(values=ispfPalette)+
  theme_ispf()+
  ylab("")+  xlab("")+
  theme(legend.position = "bottom")

g1

graphe2 <- readCSVFile(2)
colnames(graphe2) <- c("R�gion", "2019", "2020")
graphe2 <- melt(graphe2,id.vars="R�gion")
graphe2[,R�gion:=factor(R�gion, levels=rev(c("France","Chine","Etats-Unis d'Am�rique","Cor�e du Sud","Nouvelle-Z�lande")))]


g2 <- ggplot(graphe2,aes(x = R�gion,y=value, color=variable)) +
  geom_bar(mapping=aes(x = R�gion,y=value, fill=variable), stat="identity", position="dodge")+
  scale_y_continuous(labels = scales::number_format(accuracy = 1))+
  scale_fill_manual(values=ispfPalette)+
  scale_colour_manual(values=ispfPalette)+
  theme_ispf()+
  ylab("")+  xlab("")+
  theme(legend.position = "bottom")+
  coord_flip()
  
g2


graphe3 <- readCSVFile(3)
graphe3 <- melt(graphe3,id = "Ann�e")
#graphe3[,variable:=stringr::str_wrap(variable, 20)]


g3 <- ggplot() + 
  geom_bar(data=graphe3[variable!="Perles brutes en volume"], 
           mapping = aes(x = Ann�e, y = value, fill=variable), stat = "identity")+ 
   geom_line(data=graphe3[variable=="Perles brutes en volume"],
            mapping = aes(x = Ann�e, y = value*500, colour=variable), size=1, breaks = seq(2014,2020,1))+
  scale_x_continuous(labels = scales::number_format(accuracy = 1, big.mark = ''), breaks = seq(2014,2020,1))+
  scale_y_continuous(name = expression("Millions de F.CFP"), 
                     labels = scales::number_format(accuracy = 1),
                           sec.axis = sec_axis(~ ./500 , name = "Tonnes",labels = scales::number_format(accuracy = 1)))+
  scale_fill_manual(values=ispfPalette)+
  theme_ispf()+
  xlab("")+
  theme(legend.position = "bottom",legend.direction = "horizontal",
        axis.title.x = element_blank())+
  guides(fill = guide_legend(nrow = 3))
g3
#OK

graphe4 <- readCSVFile(4)
graphe4 <- melt(graphe4,id = "Ann�e")
graphe4[,variable:=stringr::str_wrap(variable, 15)]

g4 <- ggplot(graphe4,aes(x = Ann�e,y=value/1000, fill = variable, group = variable, weight = value, color=variable)) +
  geom_bar(stat = "identity")+
  scale_x_continuous(labels = scales::number_format(accuracy = 1, big.mark = ''), breaks = seq(2014,2020,1))+
  scale_y_continuous(labels = scales::number_format(accuracy = 1), limits=c(0,2000))+
  scale_fill_manual(values=rev(ispfPalette[1:4]))+
  scale_colour_manual(values=rev(ispfPalette[1:4]))+
  theme_ispf()+
  ylab("")+  xlab("")+
  theme(legend.position = "bottom")
g4
#OK

graphe5 <- readCSVFile(5)
colnames(graphe5) <- c("R�gion", "2019","2020")
graphe5 <- melt(graphe5,id = "R�gion")
graphe5[,R�gion:=factor(R�gion, levels=c("Chine","Hong-Kong","Japon","France","Etats-Unis d'Am�rique"))]
r <- graphe5[,R�gion]
graphe5[,R�gion:=factor(R�gion, levels=r, ordered=T)]


g5 <- ggplot(graphe5,aes(x = R�gion,y=value, fill = variable, group = variable, weight = value, color=variable)) +
  geom_bar(stat = "identity", position=position_dodge())+
  geom_text(aes(label=scales::number(value, accuracy = 1)), size=2, hjust=1, color="white", position = position_dodge(0.9))+
  scale_y_continuous(labels = scales::number_format(accuracy = 1), limits=c(0,4500))+
  scale_fill_manual(values=ispfPalette)+
  scale_colour_manual(values=ispfPalette)+
  xlab("")+ylab("")+
  coord_flip()+
  theme_ispf()+
  theme(legend.position = "bottom",legend.direction = "horizontal")
g5
#OK



saveGrapheFiles(1, largeurCM = 9, hauteurCM = 4.5)
saveGrapheFiles(2, largeurCM = 9, hauteurCM = 5)
saveGrapheFiles(3, largeurCM = 9, hauteurCM = 5)
saveGrapheFiles(4, largeurCM = 9, hauteurCM = 5)
saveGrapheFiles(5, largeurCM = 9, hauteurCM = 5)

