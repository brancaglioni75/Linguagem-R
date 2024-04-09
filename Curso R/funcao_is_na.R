"
A função is.na() é usada para verificar se um valor é NA 
(Not Available, ou seja, ausente). Ela retorna um vetor 
lógico do mesmo comprimento que o vetor de entrada, indicando 
TRUE para cada valor NA e FALSE para os outros valores.
"

# Função is.na()
vetor <- c(1,2,NA,4,NA,6,NA,8)

# Identificar os valores NA por meio da função is.na()

na_logical <- is.na(vetor)
print(na_logical)

# Contar quantos valores NA existem

num_na <- sum(na_logical)
print(num_na)
