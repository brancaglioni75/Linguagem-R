### Teste-t para uma amostra e teste de normalidade no R

# O "Teste T", ou "T-teste", é um tipo de teste estatístico usado para 
# determinar se há uma diferença estatisticamente significativa entre 
# as médias de dois grupos diferentes. É comumente utilizado em pesquisas 
# para comparar as médias de um grupo de controle e um grupo experimental, 
# por exemplo, para avaliar a eficácia de um tratamento ou intervenção. O 
# resultado do teste T fornece um valor p, que indica a probabilidade de 
# observar uma diferença tão grande entre as médias dos dois grupos se não 
# houver diferença real entre eles. Quanto menor o valor p, mais provável é 
# que exista uma diferença significativa entre os grupos.

# Instalar o pacote dplyr
if(!require(dplyr))
  install.packages("dplyr")

# Carregar o pacote
library(dplyr)

# Configurar o diretório
setwd("C:/Users/wilson/Desktop/R")
getwd()

# Carregar o banco de dados
dados <- read.csv('Banco de Dados 2.csv', sep = ';', dec = ',',
                  fileEncoding = "latin1")

# Verificar a tabela
View(dados)


### Antes do teste t devemos verificar a normalidade dos dados

# H0: Distribuição dos dados = normal  --> p > 0,05
# H1: Distribuição dos dados # normal  --> p < = 0,05
# Em nosso exemplo o valor de p é p-value = 0.214, portanto, maior que
# 0,05 consequentemente distribuição normal

shapiro.test(dados$Altura)


# Realização do teste t para uma amostra
t.test(dados$Altura, mu = 167)

# One Sample t-test
# data:  dados$Altura
# t = 0.70196, df = 29, p-value = 0.4883
# alternative hypothesis: true mean is not equal to 167
# 95 percent confidence interval:
#  164.2572 172.6095
# sample estimates:
#  mean of x 
# 168.4333 

# H0: Média da amostra = valor de referência  --> p > 0,05
# H1: Média da amostra # valor de referência  --> p < = 0,05

# Considera H0, portanto, esse grupo não tem uma média de altura
# diferente da média nacional, 167.

# o teste t para uma amostra mostrou que a média de altura da amostra (168,43cm)
# não é diferente da média de altura nacional (167cm) (t(29) = 0,702; p = 0,488)

### Teste bicaudal

# O teste bicaudal (ou teste de duas caudas) é uma variação do teste t para 
# uma amostra, onde a hipótese nula assume que não há diferença entre a média 
# da amostra e a média teórica, e a hipótese alternativa considera que há uma 
# diferença significativa, seja para mais ou para menos.
# O teste bicaudal é usado quando você está interessado em detectar qualquer 
# tipo de diferença significativa, seja ela positiva ou negativa, enquanto o 
# teste de uma cauda é usado quando você está especificamente interessado em 
# detectar diferenças em uma direção específica (por exemplo, apenas se a 
# média é maior do que a média teórica).

# Realização do teste t para uma amostra bicaudal, o bicaudal é default
t.test(dados$Altura, mu = 167, alternativa = "greater") # Verifica se a média é maior
t.test(dados$Altura, mu = 167, alternativa = "less")

# Visualização da distribuição dos dados
boxplot(dados$Altura, ylab = "Altura (cm)")

