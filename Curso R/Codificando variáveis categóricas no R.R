# Insalando pacotes
if(!require(dplyr))
  install.packages("dplyr")

# Carregar pacotes
library(dplyr)


# Selecionar o diretório de trabalho
setwd('C:/Users/wilson/Desktop/R')
getwd()


# Carregar o banco de dados
dados <- read.csv('Banco de Dados 2 Codificado.csv', sep = ';', dec = ',',
                  fileEncoding = "latin1")

# Verificar o banco de dados
View(dados)

# Visualizar um resumo do banco de dados
glimpse(dados)

# Informas que tipos são as variáveis
glimpse(dados)




# Ajustando as variáveis
dados$Genero <- factor(dados$Genero, labels = c("M","F"), levels = c(0,1))

dados$Grau_de_Instruçao <- factor(dados$Grau_de_Instruçao,
                                  labels = c("Fundamental", "Médio", "Superior"),
                                  levels = 0:2, order = T)

# Codificando valores ausentes
dados[dados==999] <- NA
