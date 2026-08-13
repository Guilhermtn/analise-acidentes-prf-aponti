# 🚦 Análise de Acidentes da PRF - 2025

Projeto de Data Analytics com dados abertos da Polícia Rodoviária Federal (DATATRAN 2025).

**Autor:** José Guilherme Teixeira Nunes

## 🎯 Objetivo

Investigar fatores associados a acidentes com vítimas fatais, cruzando a variável-alvo `acidente_fatal` com UF, rodovia, município, mês, causa, tipo de acidente, fase do dia, condição meteorológica e tipo de pista.

## 📂 Conteúdo do repositório

### 📄 doc_modulo01 — Compreensão do negócio

Problema central, objetivo analítico, público-alvo, variável-alvo, perguntas orientadoras, hipóteses e limitações do projeto.

### 📊 excel_modulo02 — Exploração inicial em Excel

Primeira leitura da base: tabelas dinâmicas, gráficos exploratórios e observações que embasaram as primeiras hipóteses.

### 🧾 sql_modulo03 — Consultas SQL

Consultas sobre a base bruta, com dicionário de dados e resultados exportados.

### 🐍 python_modulo04 — Preparação de dados em Python

Notebook que trata a base bruta, cria a variável-alvo `acidente_fatal` e gera a base analítica (para EDA e Power BI) e a base modelável (sem data leakage).

## 🗂 Estrutura do repositório

```
analise-acidentes-prf-aponti/
├── doc_modulo01/
├── excel_modulo02/
├── python_modulo04/
├── sql_modulo03/
└── README.md
```
