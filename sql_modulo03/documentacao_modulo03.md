# 🧾 Módulo 3 — Consultas SQL (SQLite)

**Trilha:** Análise de Dados — Data Analytics com Dados Abertos da PRF
**Base:** Acidentes 2025 agrupados por ocorrência (tabela `dados_prf`, importada do CSV bruto da PRF)

**Autor:** José Guilherme Teixeira Nunes

## O que essa etapa pediu

Depois da exploração inicial no Excel (Módulo 2), o Módulo 3 leva a mesma investigação para o SQL, agora consultando a base já importada no SQLite (via SQLiteOnline). O objetivo é validar com consultas os padrões que apareceram nas tabelas dinâmicas do Excel, e já deixar views prontas para alimentar o dashboard no Power BI.

## O que foi feito

**Preparação e checagem** (consultas 1 a 3)
- Verificar a versão do SQLite.
- Exibir a estrutura (colunas e tipos) da tabela `dados_prf`.
- Contar o total de ocorrências da base.

**Criação da view base** (consultas 4 e 5)
- Criar a `vw_acidentes_base`, com a flag `acidente_fatal` (1 quando `mortos >= 1`, senão 0) — a mesma variável-alvo definida no Módulo 1.

**Métricas gerais e por localização** (consultas 6 a 8)
- Indicadores gerais: total de acidentes, total de fatais e % de letalidade.
- Acidentes, mortos e % de fatais por UF, com corte mínimo de 100 registros.
- As 30 rodovias (BRs) com mais mortos em número absoluto.

**Padrões temporais** (consulta 9)
- Evolução mensal de acidentes, mortos e % de fatais, com ano e mês extraídos de `data_inversa`.

**Análises bivariadas — variável explicativa x `acidente_fatal`** (consultas 10 a 14)
- Tipo de acidente.
- As 30 causas com maior taxa de letalidade.
- Fase do dia.
- Condição meteorológica (coluna `condicao_metereo` — nome truncado na importação pelo SQLiteOnline).
- Tipo de pista.

Todas com corte mínimo de 100 registros por categoria, pra taxa não ser distorcida por grupos pequenos.

**Combinação de fatores**
- Cruza tipo de pista e fase do dia ao mesmo tempo, com corte mínimo de 50 registros e uma coluna extra de cobertura (% que aquela combinação representa do total da base).

**Lift de letalidade**
- Calcula, por tipo de acidente, o Lift — razão entre a taxa de letalidade da categoria e a taxa média geral. Lift > 1 indica risco acima da média; Lift < 1, abaixo.

**Views para o dashboard**
- `vw_indicadores_mensais` — acidentes, mortos e % de fatais por ano e mês.
- `vw_indicadores_uf_br` — a mesma métrica consolidada por UF e BR.

## Conteúdo desta pasta
- `script_analise_prf.sql` — script comentado do início ao fim, reexecutável.
- Dicionário de dados das colunas da base.
- Resultados de cada consulta exportados em CSV.
