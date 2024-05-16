# Instalando pacotes
if(!require(dplyr))
  install.packages("dplyr")

if(!require(psych))
  install.packages("psych")


# Carregando pacotes
library(dplyr)
library(psych)


# Selecionando o diretório
setwd("C:/Users/wilson/Desktop/R")
getwd()


# Carregando o Banco de dados
dados <- read.csv('Banco de Dados 2.csv', sep = ';', dec = ',',
                  fileEncoding = 'latin1')

# Outra forma de abriro banco. Esse código considera o sep = ';' e dec = ','
dados <- read.csv2('Banco de Dados 2.csv', fileEncoding = 'latin1')


# Visualizando os dados
View(dados)
glimpse(dados)



### Tabelas categóricas

# FrequÊncias absolutas
table(dados$Genero)

table(dados$Grau_de_Instruçao)


## Tabela cruzada com frequência absoluta
table(dados$Genero, dados$Grau_de_Instruçao)


## Frequências Relativas
prop.table(table(dados$Genero))
prop.table(table(dados$Grau_de_Instruçao))


### Tabelas Quantitativas

## Tabela de frequÊncias

# Variáveis discretas
table(dados$N_Filhos)
prop.table(table(dados$N_Filhos))


# Variáveis contínuas

# Necessário criar categorias que correspondam a faixa de valores

# Analisar a amplitude

range(dados$Salario)

# Opcional: Avaliar a quantidade de categorias adequada (Método Sturges)

nclass.Sturges(dados$Salario)


# Criação da tabela com as faixas
# O l é a quantidade de faixas. Nesse caso foi colocado uma a mais para dar 6.
# 0, 6 é a faixa de salário
# A função cut é que realiza a divisão em faixas salariais 

table(cut(dados$Salario, seq(0,6, l = 7))) 


# Função summary - fornece a média, mediana, quartis e valores min e máx
summary(dados)

# Função describe e describe.by (pacote psych) - média, desvio, erro, mediana
describe(dados$Salario)

# Função describe.by (pacote psych) - média, desvio, erro, mediana por grupo
describeBy(dados$Salario, group = dados$Genero)
describeBy(dados$Salario, group = dados$Genero:dados$Grau_de_Instruçao)


# Usando o Group by do pacote dplyr

tabela <- dados %>% group_by(Genero, Grau_de_Instruçao) %>%
          summarise(
            média = mean(Salario),
            DP = sd(Salario),
            mediana = median(Salario)
          )

tabela
