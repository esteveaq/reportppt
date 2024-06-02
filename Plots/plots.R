#plot --------------------------------------------------

# data required for plot a
plotdata <-  
  evolution %>%
  count(sectors) %>%
  mutate(prop = (n/sum(n)))

a <-
plotdata %>% 
  ggplot(mapping = aes(x = fct_reorder(sectors, prop), y = prop)) +
  geom_col(fill = "gray70") +
  geom_col(data = plotdata %>% filter(sectors == sector.select), fill = "red4") + #highlight filter
  coord_flip() +
  geom_text(aes(label = paste0(prop*100, "%")), 
            vjust = .5,
            hjust = 1.2,
            size = 4,
            color = "white") + #add labels
  scale_y_continuous(labels = scales::percent) + # axis label in %
  labs(x = "Sectors",
       title = paste("Proportion of deals for the",sector.select, "sector"), 
       subtitle = "By number of deals") #relabel x axis

# data required for plot b
evolutioncount <- 
  evolution %>%
  group_by(year = year(DatesDeals)) %>%
  count(sectors) 

evolutioncount.filt <- evolutioncount %>% filter(sectors == sector.select)

b <-
  ggplot(data = evolutioncount, aes(x = year, y = n)) +
  geom_col(fill = "gray70") + 
  geom_col(data = evolutioncount.filt, fill = "red4") +
  geom_text(data =  evolutioncount %>% filter(sectors == sector.select), mapping = aes(label = n), 
            vjust = -0.8, color = "red4") 


