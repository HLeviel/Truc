# r�cup�ration des donn�es (cotes et matches) dans les fichiers d'entr�e
cotes   <- read.csv2("S02E04/input/cotes.csv", encoding = "UTF-8")
matches <- read.csv2("S02E04/input/matches.csv", encoding = "UTF-8")

# conversion des cotes en probabilit�s
cotes$Proba <- 1 - (cotes$Cote / (1 + cotes$Cote))

# affichage du barplot des probabilit�s de victoire finale par �quipe
ggplotly(ggplot(data=cotes, aes(x=reorder(Equipe,-Proba), y=100*Proba)) + 
           geom_bar(stat="identity") +
           theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5)) +
           labs(title = "Probabilit�s de victoire finale par �quipe", x = "Equipe", y = "% de chance"))
