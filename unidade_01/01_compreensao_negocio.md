# Documento de Compreensão do Negócio

Projeto: Análise de Acidentes em Rodovias Federais (PRF 2025)
Autor: José Guilherme Teixeira Nunes
Etapa: Módulo 1 (Entendimento do Negócio — CRISP-DM)

## 1. Contexto e Problema

A Polícia Rodoviária Federal disponibiliza anualmente, como dado aberto, o
registro de todos os acidentes ocorridos nas rodovias federais brasileiras
(base DATATRAN). Em 2025, essa base reúne 72.529 acidentes registrados por
ocorrência.

A grande maioria desses acidentes não resulta em morte, mas uma fração deles
sim — e é justamente essa fração que carrega o impacto mais grave do problema,
tanto humano quanto social. Este projeto parte da pergunta: dado que um
acidente aconteceu, o que diferencia os casos que terminam em morte dos que
não terminam? Entender esse padrão é o primeiro passo para pensar em
prevenção.

## 2. Dados e Variável-Alvo

**Fonte:** Dados Abertos da PRF, base DATATRAN, ano de 2025.
**Granularidade:** uma linha por ocorrência de acidente.
**Volume inicial:** 72.529 linhas e 30 colunas.

**Variável-alvo:** `acidente_fatal`, binária, construída a partir da coluna
`mortos`: recebe 1 quando `mortos >= 1` e 0 quando `mortos = 0`.

**Indicadores gerais da base:**

| Indicador | Valor |
|---|---|
| Total de acidentes | 72.529 |
| Acidentes fatais | 5.210 |
| Percentual de acidentes fatais | 7,18% |
| Total de mortos | 6.043 |

**Como as variáveis foram agrupadas:**

| Grupo | Colunas | Para que serve |
|---|---|---|
| Tempo | `data_inversa`, `horario`, `dia_semana` | Enxergar padrões por período |
| Lugar | `uf`, `br`, `km`, `municipio`, `latitude`, `longitude` | Localizar onde o problema se concentra |
| Circunstância do acidente | `causa_acidente`, `tipo_acidente`, `fase_dia`, `tipo_pista`, `tracado_via`, `condicao_metereo`, `sentido_via`, `uso_solo` | Entender o contexto em que ele ocorreu |
| Consequência | `mortos`, `feridos`, `feridos_leves`, `feridos_graves`, `pessoas`, `ilesos`, `ignorados`, `veiculos`, `classificacao_acidente` | Descrevem o resultado — **não entram como variável explicativa** |

O grupo de consequência é excluído das variáveis explicativas por descrever o
próprio desfecho do acidente: incluí-lo geraria vazamento de dados (a base
"entregaria a resposta"). Essas colunas ficam de fora da base usada para
modelagem, tratamento já feito no Módulo 4.

## 3. Objetivo e Público-Alvo

**Objetivo analítico:** mapear quais fatores — local, momento, causa, tipo de
acidente, condição da via e do tempo — aparecem associados a uma taxa de
fatalidade mais alta que a média geral (7,18%), organizando essas evidências
de forma que sirvam de insumo tanto para um painel descritivo (Power BI)
quanto para uma futura árvore de decisão explicável.

**Público-alvo, de forma realista:** o uso mais direto e alcançável deste
projeto é acadêmico — servir como entrega do curso e como peça de portfólio
demonstrando o ciclo completo de um projeto de dados. Dito isso, o tipo de
indicador produzido (ranking de rodovias, horários e condições de maior risco)
é o mesmo formato que equipes de fiscalização de trânsito costumam usar para
priorizar onde atuar. A ressalva importante é que, para virar uma ferramenta
de decisão real, faltariam dados que esta base não tem — principalmente
volume de tráfego por trecho, sem o qual não dá para saber se uma rodovia é
mais perigosa ou apenas mais movimentada.

## 4. Perguntas Orientadoras

1. Quais UFs e rodovias concentram mais acidentes fatais — e essa lista muda
   quando se olha taxa de fatalidade em vez de número absoluto de mortes?
2. Existe algum mês de 2025 com taxa de fatalidade destacadamente acima da
   média geral?
3. O horário e a fase do dia (plena noite, amanhecer, pleno dia, anoitecer)
   influenciam a chance de um acidente terminar em morte?
4. Quais causas de acidente registradas pelo agente têm taxa de fatalidade
   mais alta que os 7,18% da base?
5. Tipos de acidente como colisão frontal ou atropelamento têm taxa de
   fatalidade muito diferente da média?
6. Pista simples tem taxa de fatalidade maior que pista dupla ou múltipla?
7. Chuva ou neblina aumentam a taxa de fatalidade, ou só reduzem o volume de
   acidentes (por menos gente rodando)?

## 5. Hipóteses Iniciais

<!-- Ajuste esta lista para refletir o que vocês discutiram em equipe antes
de rodar as consultas SQL. O valor de registrar isso agora é justamente poder
comparar, na etapa de avaliação, o que vocês esperavam com o que os dados
mostraram. -->

| # | Hipótese | Confirmada pelos dados? |
|---|---|---|
| 1 | Acidentes em plena noite têm taxa de fatalidade maior que em pleno dia | a verificar |
| 2 | Colisão frontal é o tipo de acidente com maior taxa de fatalidade | a verificar |
| 3 | Pista simples concentra mais acidentes fatais que pista dupla | a verificar |
| 4 | Causas ligadas a velocidade incompatível têm taxa de fatalidade acima da média | a verificar |
| 5 | Condição meteorológica adversa (chuva/neblina) não muda muito a taxa de fatalidade, só reduz o volume de acidentes | a verificar |


## 6. Limitações

- A base cobre só rodovias federais — acidentes em vias estaduais e
  municipais não entram, então as conclusões não podem ser estendidas para a
  malha viária como um todo.
- A causa do acidente é um julgamento do agente que atendeu a ocorrência, não
  uma medição objetiva, e pode variar entre casos parecidos.
- Não há dado de volume de tráfego por trecho: uma rodovia pode aparecer no
  topo do ranking de acidentes só por ser mais movimentada, não
  necessariamente mais perigosa.
- Faltam informações como velocidade no momento do acidente, uso de cinto ou
  capacete, e estado do veículo — variáveis que, em outras análises, costumam
  pesar bastante no desfecho.
- Os resultados mostram associação, não causa. Nenhuma conclusão deste
  projeto afirma que um fator causa a morte no acidente.
- Questões práticas de importação também impõem limites: nomes de coluna
  truncados pela ferramenta usada e a necessidade de converter o encoding do
  CSV original (ISO-8859-1 → UTF-8) antes de qualquer consulta.
- As consultas usam corte mínimo de 100 registros por categoria (`HAVING
  COUNT(*) >= 100`) para evitar que categorias muito pequenas distorçam os
  percentuais — o que significa que causas ou tipos de acidente raros ficam
  de fora das comparações.

## 7. Relação com as Fases do CRISP-DM

| Fase | Onde acontece neste projeto |
|---|---|
| Entendimento do negócio | Este documento (Unidade 1) |
| Entendimento dos dados | Exploração no Excel (Unidade 2) e consultas SQL (Unidade 3) |
| Preparação dos dados | Notebook em Python (Unidade 4), gerando base analítica e base modelável |
| Modelagem | Etapa seguinte — árvore de decisão explicável sobre a base modelável |
| Avaliação | Confronto entre as hipóteses da seção 5 e a evidência obtida |
| Implantação | Dashboard em Power BI alimentado pela base analítica |
