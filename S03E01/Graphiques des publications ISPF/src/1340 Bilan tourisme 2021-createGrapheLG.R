
cat("Cr�ation des graphiques en PDF\n")



graphe2 <- readCSVFile(2)
graphe2 <- melt(graphe2,id.vars="Date")
#r <- graphe2[,Date]
graphe2[,Date:=factor(Date,levels=rev(c("d�cembre", "novembre", "octobre", "septembre", "ao�t", "juillet", "juin","mai", "avril","mars", "f�vrier", "janvier")))]

g2 <- ggplot(graphe2, aes(x = Date,y=value, group=variable, fill = variable)) +
  geom_bar( stat="identity", position ="dodge") +
  scale_fill_manual(values=ispfPalette)+
  #geom_label_repel(aes(label=number(value, accuracy = 1)),  position = position_stack(vjust = 0,reverse = T),color="white", size=3)+
 #geom_text(data=graphe2, aes(label=percent(value, accuracy = 1.11)),  position = position_dodge(width = 0.8),color="black", size=1, hjust = 0.5, vjust = -0.3)+
  scale_y_continuous(labels = scales::percent_format(accuracy = 1), limits=c(0,1))+
  xlab("")+   ylab("")+  theme_ispf()+
  theme(legend.position = "bottom",legend.direction = "horizontal")+
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1, size=7))+
  theme(legend.text=element_text(size=rel(0.7)))
g2



graphe3 <- readCSVFile(3)
graphe3 <- melt(graphe3,id.vars="R�gion")
#graphe3 <- readCSVFileAndMelt(3, keysList = "R�gion", isVariableOrdered = T)
graphe3[,R�gion:=factor(R�gion,levels=rev(c("Am�rique du Nord", "Europe (hors France)", "France m�tropolitaine", "Autre pays")))]

g3 <- ggplot(graphe3, aes(x = variable,y=value, group=R�gion, fill = factor(R�gion))) +
  geom_bar( stat="identity", width = 0.5)+
  scale_fill_manual(values = ispfPalette)+
  #geom_label_repel(aes(label=number(value, accuracy = 1)),  position = position_stack(vjust = 0,reverse = T),color="white", size=3)+
  #geom_text(data=graphe3, aes(label=number(value, accuracy = 1)),  position = position_dodge(width = 0.2),color="black", size=2, hjust = 0.5, vjust = -0.3)+
  scale_y_continuous(labels = scales::number_format(accuracy = 1), limits=c(0,60000))+
  xlab("")+   ylab("")+  theme_ispf()+
  theme(legend.position = "bottom",legend.direction = "horizontal")+
  guides(fill = guide_legend(nrow = 2))+
  theme(axis.text.x = element_text(angle =0, vjust = 1, hjust=0.5, size=8))+
  theme(legend.text=element_text(size=rel(0.7)))
g3



graphe4 <- readCSVFile(4)
graphe4 <- melt(graphe4,id.vars="R�gion")
graphe4 <- readCSVFileAndMelt(4, keysList = "R�gion", isVariableOrdered = T)
#graphe4[,variable:=factor(variable, levels=c("Paraha peue", "Crevette"))]

g4 <- ggplot(graphe4,aes(x = R�gion,y=value, group=variable, color=variable)) +
  geom_line(aes(x =R�gion,y=value, group=variable, colour = variable))+
  geom_point(aes(group=R�gion))+
  #geom_bar(mapping=aes(x = Ann�e,y=value, fill=variable), stat="identity", position = "dodge")+
  #scale_x_continuous(labels = scales::number_format(accuracy = 1, big.mark = ''), breaks = c(2019, 2020, 2021))+
  scale_y_continuous(labels = scales::number_format(accuracy = 1), limits=c(0,160))+
  scale_fill_manual(values=ispfPalette)+
  scale_colour_manual(values=ispfPalette)+
  theme_ispf()+
  ylab("")+  xlab("")+
  theme(legend.position = "bottom") +
  guides(col = guide_legend(ncol = 3))

g4


saveGrapheFiles(2, largeurCM = 9, hauteurCM = 5)
saveGrapheFiles(3, largeurCM = 9, hauteurCM = 5)
saveGrapheFiles(4, largeurCM = 9, hauteurCM = 5)