# 📊 Módulo 2 — Exploração Inicial em Excel

Primeira leitura da base DATATRAN 2025 (PRF), antes de partir para as consultas em SQL e o tratamento em Python.

**Autor:** José Guilherme Teixeira Nunes

## O que essa etapa pediu

**Trilha:** Análise de Dados — Data Analytics com Dados Abertos da PRF.
**Atividades:** Importação do CSV e Inspeção Inicial / Tabelas Dinâmicas e Gráficos Exploratórios.

Depois de definir o problema no Módulo 1, o CRISP-DM pede a Compreensão dos Dados: primeiro conhecer a base (importar, conferir tipos, linhas, colunas e inconsistências), depois já começar a explorar padrões (tabelas dinâmicas e gráficos).

**Nosso objetivo aqui:** trazer a base da PRF para o Excel, validar se ela veio íntegra, e dar os primeiros passos para responder as perguntas orientadoras e confrontar as hipóteses levantadas no Módulo 1 — antes de partir para SQL e Python.

## Conteúdo da planilha

- **dados** — base bruta importada (72.529 linhas, 32 colunas).
- **dicionario_resumido** — dicionário resumido dos campos: tipo aparente, utilidade analítica e observação de qualidade de cada coluna.
- **tabelas_dinamicas** — 8 tabelas dinâmicas: Acidentes por UF, Fatais por Mês, Causas Frequentes, Mortos por BR, Tipo de Acidente e Gravidade, Condição Meteorológica, Classificação do Acidente e Município e Fatais.
- **graficos** — 4 gráficos (Top 10 UFs com mais acidentes, evolução mensal de acidentes fatais, Top 10 causas mais frequentes, Top 10 BRs com mais mortes), cada um com uma observação de leitura e notas de cautela sobre os limites dos dados.
- **Observações** — registro das principais observações feitas durante essa exploração.

## Adendo — arquivo produzido no Google Sheets

> Esta planilha foi montada no Google Sheets e depois baixada em formato `.xlsx`. Isso pode causar diferença de visualização ao abrir direto no Excel — em especial nas tabelas dinâmicas e nos gráficos, que podem aparecer sem dados até serem atualizados manualmente (no Excel: botão direito sobre a tabela dinâmica → **Atualizar**, ou **Dados → Atualizar Tudo**). Se a visualização não ficar boa no Excel, o recomendado é abrir o arquivo original no Google Sheets.
