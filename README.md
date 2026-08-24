# 🚦 Projeto PRF 2025 — Trilha de Análise de Dados

Repositório do projeto desenvolvido na trilha de Análise de Dados da Aponti Academy, com dados abertos de acidentes nas rodovias federais brasileiras (base DATATRAN, PRF 2025).

**Autor:** José Guilherme Teixeira Nunes

---

## Sobre o projeto

O projeto investiga os fatores associados a acidentes com vítimas fatais nas rodovias federais brasileiras, usando os dados abertos da PRF de 2025.

### Pergunta central

Quais fatores estão associados à ocorrência de acidentes com vítimas fatais nas rodovias federais brasileiras?

### Objetivo

Identificar padrões e indicadores associados à gravidade dos acidentes, cruzando a variável-alvo `acidente_fatal` com UF, rodovia, município, mês, causa, tipo de acidente, fase do dia, condição meteorológica e tipo de pista — preparando o terreno para um dashboard e, depois, uma árvore de decisão explicável.

---

## Contexto do estudo

**Variável-alvo:** `acidente_fatal`, binária, criada a partir de `mortos`:
- `acidente_fatal = 1` quando `mortos >= 1`
- `acidente_fatal = 0` quando `mortos = 0`

**Indicadores gerais da base (72.529 ocorrências):**

| Indicador | Valor |
|---|---|
| Total de acidentes | 72.529 |
| Acidentes fatais | 5.210 |
| % de letalidade | 7,18% |

---

## Estrutura do repositório

```
analise-acidentes-prf-aponti/
├── doc_modulo01/
├── excel_modulo02/
├── python_modulo04/
├── sql_modulo03/
└── README.md
```

---

## O que foi feito em cada módulo

### 📄 doc_modulo01 — Compreensão do negócio

Documento de Business Understanding (CRISP-DM): contexto e problema, objetivo analítico, público-alvo, classificação das variáveis da base, indicadores gerais, 7 perguntas orientadoras, hipóteses iniciais a confirmar na etapa de avaliação, e as limitações do projeto — como a ausência de dado de volume de tráfego e o fato de a causa do acidente ser um julgamento do agente, não uma medição objetiva.

### 📊 excel_modulo02 — Exploração inicial em Excel

Primeira leitura da base, em 5 abas: dados brutos importados, dicionário resumido dos campos, 8 tabelas dinâmicas (acidentes por UF, fatais por mês, causas frequentes, mortos por BR, tipo de acidente, condição meteorológica, classificação do acidente e município), 4 gráficos exploratórios com observações de leitura, e uma aba com as principais observações registradas nessa fase. Planilha construída no Google Sheets e exportada para `.xlsx`.

### 🧾 sql_modulo03 — Consultas SQL

Script comentado no SQLite (via SQLiteOnline) sobre a tabela `dados_prf`: criação da view `vw_acidentes_base` com a flag `acidente_fatal`, indicadores gerais e por UF/BR, evolução mensal, análises bivariadas (tipo de acidente, causa, fase do dia, condição meteorológica, tipo de pista) sempre com corte mínimo de registros por categoria, cruzamento de tipo de pista com fase do dia, cálculo do Lift de letalidade por tipo de acidente, e duas views (`vw_indicadores_mensais` e `vw_indicadores_uf_br`) prontas para alimentar o dashboard.

### 🐍 python_modulo04 — Preparação de dados em Python

Notebook que parte da base bruta e: lê o CSV testando encoding, padroniza colunas, diagnostica qualidade (tipos, nulos, duplicidade, cardinalidade), cria as variáveis derivadas (tempo, turno, faixa horária, BR formatada, chave de localidade), constrói e valida a variável-alvo `acidente_fatal`, e gera as duas bases finais:

- `dados_tratados/base_analitica_prf_2025.csv` — base completa, para EDA e Power BI.
- `dados_tratados/base_modelavel_prf_2025.csv` — base para modelagem, com verificação automática de data leakage (exclui `mortos`, `feridos`, `feridos_leves`, `feridos_graves`, `total_vitimas`, `indice_gravidade`, `acidente_grave` e `classificacao_acidente`).

Também gera o dicionário das variáveis criadas e o log de decisões de tratamento.

---

## Repositório em evolução

Este repositório acompanha o andamento da trilha da Aponti Academy: a cada módulo concluído, os arquivos e a documentação correspondente são adicionados aqui, mantendo um histórico do desenvolvimento do projeto.

---

## Licença

Projeto de uso educacional, desenvolvido no contexto da trilha de formação da Aponti Academy.
