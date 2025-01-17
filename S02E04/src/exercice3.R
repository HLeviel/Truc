# d�finit le nombre de simulations de chaque match
nbSimulations <- 10
# rajoute 1 si besoin pour avoir un nombre impair et �viter les cas de "50-50"
nbSimulations <- nbSimulations + (nbSimulations+1) %% 2 


# simulation d'un nombre donn� de tournois
anneeDebut <- 2022
nbTournois <- 10
palmares <- simulationTournois(anneeDebut, nbTournois, probaCroisees, nbSimulations) 

# classement historique des �quipes par nombre de victoires, puis nombre de finales, etc
histo <- palmares %>% 
  group_by(Equipe, Classement, Rang) %>%
  summarise(n(), .groups="rowwise") %>%
  arrange(Classement, n()) %>%
  rename("Nombre" = "n()")

print(histo)
  
# affichage du barplot des probabilit�s de victoire finale par �quipe
ggplotly(ggplot(data=histo, aes(x = reorder(Equipe, Classement), y=Nombre, fill=Rang)) + 
           geom_bar(stat="identity") +
           theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5)) +
           labs(title = "Palmar�s du tournoi", x = "Equipe"))
