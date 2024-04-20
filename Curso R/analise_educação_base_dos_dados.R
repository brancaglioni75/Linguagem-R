## Instalar os pacotes
if(!require(basedosdados))
  install.packages("basedosdados")
libraty(basedosdados)

if(!require(ggplot2))
  install.packages("ggplot")
if(!require(dplyr))
  install.packages("dplyr")
library(ggplot2)
library(dplyr)

## Configurar o projeto 
basedosdados::set_billing_id('dataw-372722')

query <- 
"
WITH siconfi as (
#QUERY 1 -> encontrar os investimento na conta de educação 
SELECT 
ano,
sigla_uf,
id_municipio,
SUM (valor) as total_siconfi
FROM `basedosdados.br_me_siconfi.municipio_despesas_funcao`
WHERE ano = 2020 AND sigla_uf = 'SP' AND conta = 'Educação' AND estagio = 'Despesas Pagas'
GROUP BY 1,2,3
ORDER BY 4 DESC),

#Query 2
censo_escolar as (
SELECT
ano,
sigla_uf,
id_municipio,
sum(quantidade_matricula_masculino + quantidade_matricula_feminino + quantidade_matricula_nao_declarada) as total_matriculas
FROM `basedosdados.br_inep_censo_escolar.escola`
WHERE ano = 2020 AND sigla_uf = 'SP'
GROUP BY 1,2,3),

# QUERY 3 - INVESTIMENTOS EM EDUCAÇÃO
investimento_educacao as (
SELECT
siconfi.id_municipio,
ROUND((total_siconfi/total_matriculas),2) as investimento_per_capita
FROM siconfi
inner join censo_escolar
on siconfi.ano = censo_escolar.ano AND siconfi.id_municipio = censo_escolar.id_municipio
)

select 
investimento_educacao.id_municipio,
investimento_educacao.investimento_per_capita,
saeb.rede,
saeb.media as media_matematica_5ano,
FROM investimento_educacao
INNER JOIN `basedosdados.br_inep_saeb.municipio` saeb ON
investimento_educacao.id_municipio = saeb.id_municipio 
WHERE saeb.ano = 2020 AND saeb.serie = 5 AND saeb.disciplina = 'MT'  AND saeb.localizacao = 'total'
"

# Chamamos os dados do SQL
dados <- basedosdados::read_sql(query = query)

