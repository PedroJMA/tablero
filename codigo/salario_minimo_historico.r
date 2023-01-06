############################################
##  Gráficas para Micrositio del INEGI  ###
###########################################
install.packages("ggplot2")
install.packages("showtext")
install.packages("plotly")
install.packages("dplyr")
install.packages("htmlwidgets")

library(dplyr)
library(ggplot2)
library(showtext)
library(plotly)
library(htmlwidgets)

font_add_google("Montserrat", "Montserrat")
font_families()
letra_m <- "Montserrat"

#setwd("G:/CONASAMI/Proyectos/Micrositio/series_sm")
setwd("/Users/pedrojma/Documents/GitHub/tablero/datos/")
sm_hist <- read.csv("sm_hist.csv",header=TRUE, sep=",", na.strings="NA", dec=".",as.is=TRUE)

sm_hist <- sm_hist %>%      
  mutate(sm_pa =round(sm_pa, digits = 2)) %>%
  rename(Salario_minimo = sm_pa, Año=anio)

sm_grafica <- ggplot(sm_hist) + 
  geom_col(aes(x=Año, y=Salario_minimo, fill = NPSM)) + 
  scale_fill_manual(values = c("#691C32", "#BC955C")) +
  labs(x = "Años", y = "Salario mínimo (pesos diarios)") +
  scale_x_continuous(breaks = sm_hist$Año, expand = c(0, 0)) +
  scale_y_continuous(breaks = scales::breaks_width(50), expand = c(0, 0)) +
  theme(legend.position="none",
        axis.text.x = element_text(angle = 90, vjust = 0.5),
        panel.background = element_blank(),
        axis.line = element_line(colour = "black"),
        text=element_text(family=letra_m, face="bold", size=14),
        plot.title = element_text(hjust = 0.5, size=16))
 
graf_smh <- ggplotly(sm_grafica) %>%
  layout(margin = list(t = 50),
    title = list(text = paste0('Salario mínimo en México: 1976 - 2022',
                                    '<br>',
                                    '<sup>',
                                    'Pesos de septiembre de 2022','</sup>')))
graf_smh
