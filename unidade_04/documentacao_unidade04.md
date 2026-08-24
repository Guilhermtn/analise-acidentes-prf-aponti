# 🐍 Unidade 4 — Preparação de Dados em Python

**Trilha:** Análise de Dados — Data Analytics com Dados Abertos da PRF
**Base:** Acidentes 2025 agrupados por ocorrência (CSV bruto da PRF, `dados_brutos/acidentes2025.csv`)

**Autor:** José Guilherme Teixeira Nunes

## O que essa etapa pediu

Depois das consultas em SQL (Unidade 3), a Unidade 4 leva o tratamento para o Python: ler a base bruta, diagnosticar e corrigir problemas de qualidade, criar as variáveis derivadas e a variável-alvo, e gerar as duas bases finais do projeto — uma para análise/dashboard e outra pronta para modelagem, sem vazamento de dado.

## Objetivo

Preparar os dados de acidentes da PRF 2025 para análise exploratória, Power BI e uma árvore de decisão explicável.

## Variável-alvo

`acidente_fatal = 1` quando `mortos >= 1`; caso contrário, `acidente_fatal = 0`. Mesma definição usada nas Unidades 1 e 3.

## Bases geradas

- `dados_tratados/base_analitica_prf_2025.csv` — base completa, para EDA e Power BI.
- `dados_tratados/base_modelavel_prf_2025.csv` — base para modelagem, sem data leakage.

## Observação metodológica

A base modelável exclui `mortos`, `feridos`, `feridos_leves`, `feridos_graves`, `total_vitimas`, `indice_gravidade`, `acidente_grave` e `classificacao_acidente` — todas variáveis derivadas do próprio desfecho do acidente. Incluí-las entraria como vazamento de dado (data leakage) na etapa de modelagem, já que "entregam" a resposta que o modelo deveria prever.

## O que foi feito

**Leitura e organização da base**
- Import das bibliotecas e configuração do ambiente; criação da estrutura de pastas do projeto.
- Leitura do CSV testando mais de um encoding (utf-8 antes de latin1, pra não corromper acento silenciosamente).
- Padronização dos nomes de coluna e conferência das colunas esperadas.

**Diagnóstico de qualidade dos dados**
- Tipos de dado e uso de memória, mapeamento de valores ausentes, checagem e remoção de duplicidades, e cardinalidade das colunas categóricas.

**Transformações e variáveis derivadas**
- Conversão das colunas numéricas (com ajuste da vírgula decimal em `km`).
- Variáveis de tempo: ano, mês, trimestre, dia da semana, fim de semana, hora, turno e faixa horária.
- Padronização de texto e tratamento de nulos categóricos e de contagem.

**Variável-alvo e indicadores de gravidade**
- Criação e validação lógica de `acidente_fatal`.
- Indicadores auxiliares (`total_vitimas`, `indice_gravidade`, `acidente_grave`), BR formatada e chave de localidade.
- Checagens rápidas, rankings de categoria, taxa de fatalidade por categoria e um gráfico de conferência da distribuição do alvo.

**Bases finais e verificação de vazamento**
- Geração da base analítica completa e seleção das variáveis modeláveis.
- Verificação automática de data leakage antes de seguir (o notebook interrompe se alguma variável proibida aparecer na base modelável).

**Exportação e documentação de apoio**
- Tratamento final de nulos na base modelável, exportação dos dois CSVs e reabertura deles como conferência.
- Geração do dicionário das variáveis criadas, do log de decisões de tratamento e deste README.

## Conteúdo desta pasta

- `preparacao_dados_modulo04.ipynb` — notebook completo, executável do início ao fim.
- `dados_tratados/` — as duas bases finais (analítica e modelável) e o dicionário das variáveis criadas.
- `logs/decisoes_tratamento_modulo4.md` — principais decisões de tratamento registradas.
