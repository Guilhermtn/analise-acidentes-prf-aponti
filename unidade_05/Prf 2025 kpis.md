# Análise de KPIs — PRF 2025: Quatro Sinais de Risco nas Rodovias Federais

Análise integrada de letalidade nas rodovias federais brasileiras, com base nos dados abertos de acidentes da Polícia Rodoviária Federal (PRF) referentes ao ano de 2025.

**Autor:** José Guilherme Teixeira Nunes

## Sobre o Projeto

Este trabalho identifica e analisa quatro dimensões-chave que influenciam a taxa de fatalidade em acidentes de trânsito nas rodovias federais, com o objetivo de subsidiar a priorização de políticas públicas e alocação de recursos.

**Período analisado:** Janeiro a Dezembro de 2025
**Total de ocorrências:** 72.529
**Taxa geral de letalidade:** 7,18%
**Acidentes fatais:** 5.210 (com pelo menos 1 óbito confirmado)

## Conteúdo da Pasta

| Arquivo | Descrição |
|---|---|
| `PRF_2025_KPIs_Analise.pptx` | Apresentação em slides com os 5 KPIs, gráficos e análises |
| `analytics_prf.xlsx` | Planilha de origem com a base de dados e as tabelas dinâmicas de cada KPI |

## Os KPIs Analisados

1. **ISPS — Índice de Severidade em Pistas Simples** (Engenharia Viária)
   Pista simples apresenta letalidade de 9,86%, quase o dobro da pista dupla (4,88%), e concentra 65,7% das mortes com apenas 47,9% do volume de acidentes.

2. **FLN — Fator de Letalidade Noturna** (Operação e Turnos)
   Amanhecer (11,20%) e Plena Noite (10,18%) concentram cerca do dobro da letalidade do Pleno Dia (5,07%); a Plena Noite sozinha responde por 48,4% das mortes.

3. **TRCL — Taxa de Risco por Transitar na Contramão** (Fator Comportamental)
   Conduta mais letal mapeada na base: 29,74% de letalidade em 2.475 registros, 4,1x a taxa nacional.

4. **TLUV — Taxa de Letalidade por Ultrapassagem Indevida** (Fator Comportamental)
   17,06% de letalidade em 1.770 registros, 2,4x a taxa nacional — a segunda conduta mais grave mapeada.

5. **Alerta de Risco Climático** (Sazonalidade e Visibilidade)
   Nevoeiro/Neblina apresenta letalidade de 10,85%, cerca de 51% acima da média nacional e quase o dobro de dias de sol (5,88%).

## Principais Conclusões

Os fatores **comportamentais** (condutas graves como contramão e ultrapassagem indevida) apresentam impacto muito maior na letalidade do que fatores estruturais (tipo de pista) ou climáticos (neblina) — respectivamente 4,1x e 2,4x acima da taxa global, contra 1,4x (pista simples) e 1,5x (neblina). Juntas, contramão e ultrapassagem concentram quase 4.250 ocorrências em manobras evitáveis de alto risco, reforçando que o comportamento do condutor é a dimensão com maior potencial de mitigação de mortes nas rodovias federais.

## Metodologia

- **Fonte de dados:** Dados Abertos de Acidentes da PRF (aba `tb_acidentes_prf`, arquivo `analytics_prf.xlsx`)
- **Volume:** 72.529 ocorrências de trânsito válidas em rodovias federais
- **Indicador base:** Acidentes com pelo menos 1 óbito confirmado
