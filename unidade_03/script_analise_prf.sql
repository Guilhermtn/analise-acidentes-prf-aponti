-- 1. Verificar a versão do SQLite.
SELECT sqlite_version() AS versao_sqlite;

-- 2. Exibir a estrutura da tabela
PRAGMA table_info(dados_prf);

-- 3. Contar o número total de registros da base.
SELECT COUNT(*) AS total_ocorrencias
FROM dados_prf;

-- 4. Remove a view caso ela já exista e cria uma nova com a coluna acidente_fatal
DROP VIEW IF EXISTS vw_acidentes_base;

-- 5. Criando a view base, com a flag 'acidente_fatal'
CREATE VIEW vw_acidentes_base AS
SELECT
    *,
    CASE
        WHEN CAST(mortos AS INTEGER) >= 1 THEN 1
        ELSE 0
    END AS acidente_fatal
FROM dados_prf;

-- 6. Calcula os indicadores gerais da base de acidentes
SELECT
    COUNT(*) AS total_acidentes,
    SUM(acidente_fatal) AS acidentes_fatais,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base;

-- 7. Exibe indicadores de acidentes por UF
SELECT
    uf,
    COUNT(*) AS total_acidentes,
    SUM(acidente_fatal) AS acidentes_fatais,
    SUM(mortos) AS total_mortos,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
GROUP BY uf
HAVING COUNT(*) >= 100
ORDER BY perc_fatais DESC;

-- 8. Lista as 30 BRs com maior número de mortos
SELECT
    br,
    COUNT(*) AS total_acidentes,
    SUM(mortos) AS total_mortos,
    SUM(acidente_fatal) AS acidentes_fatais,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
WHERE br IS NOT NULL
GROUP BY br
HAVING COUNT(*) >= 100
ORDER BY total_mortos DESC
LIMIT 30;

-- 9. Exibe a evolução mensal dos acidentes
SELECT
    strftime('%Y', data_inversa) AS ano,
    strftime('%m', data_inversa) AS mes,
    COUNT(*) AS total_acidentes,
    SUM(mortos) AS total_mortos,
    SUM(acidente_fatal) AS acidentes_fatais,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
GROUP BY ano, mes
ORDER BY ano, mes;

-- 10. (Relação Bivariada) Exibe indicadores por tipo de acidente
SELECT
    tipo_acidente,
    COUNT(*) AS total_acidentes,
    SUM(acidente_fatal) AS acidentes_fatais,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
GROUP BY tipo_acidente
HAVING COUNT(*) >= 100
ORDER BY perc_fatais DESC;

-- 11. Exibe as 30 causas com maior percentual de acidentes fatais
SELECT
    causa_acidente,
    COUNT(*) AS total_acidentes,
    SUM(acidente_fatal) AS acidentes_fatais,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
GROUP BY causa_acidente
HAVING COUNT(*) >= 100
ORDER BY perc_fatais DESC
LIMIT 30;

-- 12. Exibe indicadores por fase do dia
SELECT
    fase_dia,
    COUNT(*) AS total_acidentes,
    SUM(acidente_fatal) AS acidentes_fatais,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
GROUP BY fase_dia
HAVING COUNT(*) >= 100
ORDER BY perc_fatais DESC;

-- 13. Exibe indicadores por condição meteorológica (coluna ficou com o nome de condicao_metereo pois ao importar foi cortado)
SELECT
    condicao_metereo,
    COUNT(*) AS total_acidentes,
    SUM(acidente_fatal) AS acidentes_fatais,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
GROUP BY condicao_metereo
HAVING COUNT(*) >= 100
ORDER BY perc_fatais DESC;

-- 14. Exibe indicadores por tipo de pista
SELECT
    tipo_pista,
    COUNT(*) AS total_acidentes,
    SUM(acidente_fatal) AS acidentes_fatais,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
GROUP BY tipo_pista
HAVING COUNT(*) >= 100
ORDER BY perc_fatais DESC;

-- Analisa a combinação entre tipo de pista e fase do dia
SELECT
    tipo_pista,
    fase_dia,
    COUNT(*) AS total_acidentes,
    SUM(acidente_fatal) AS acidentes_fatais,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM vw_acidentes_base), 2) AS cobertura_perc,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
GROUP BY tipo_pista, fase_dia
HAVING COUNT(*) >= 50
ORDER BY total_acidentes DESC;

-- Calcula o Lift da letalidade por tipo de acidente
SELECT
    tipo_acidente,
    COUNT(*) AS total_acidentes,
    SUM(acidente_fatal) AS acidentes_fatais,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais,
    ROUND(
        (1.0 * SUM(acidente_fatal) / COUNT(*)) /
        (SELECT 1.0 * SUM(acidente_fatal) / COUNT(*) FROM vw_acidentes_base),
        2
    ) AS lift
FROM vw_acidentes_base
GROUP BY tipo_acidente
HAVING COUNT(*) >= 100
ORDER BY lift DESC;

-- Cria a view com indicadores mensais
DROP VIEW IF EXISTS vw_indicadores_mensais;

CREATE VIEW vw_indicadores_mensais AS
SELECT
    strftime('%Y', data_inversa) AS ano,
    strftime('%m', data_inversa) AS mes,
    COUNT(*) AS total_acidentes,
    SUM(mortos) AS total_mortos,
    SUM(acidente_fatal) AS acidentes_fatais,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
GROUP BY ano, mes;

-- Cria a view com indicadores por UF e BR
DROP VIEW IF EXISTS vw_indicadores_uf_br;

CREATE VIEW vw_indicadores_uf_br AS
SELECT
    uf,
    br,
    COUNT(*) AS total_acidentes,
    SUM(mortos) AS total_mortos,
    SUM(acidente_fatal) AS acidentes_fatais,
    ROUND(100.0 * SUM(acidente_fatal) / COUNT(*), 2) AS perc_fatais
FROM vw_acidentes_base
GROUP BY uf, br;

-- Exibe a view base
SELECT * FROM vw_acidentes_base;

-- Exibe a view de indicadores mensais
SELECT * FROM vw_indicadores_mensais;

-- Exibe a view consolidada por UF e BR
SELECT * FROM vw_indicadores_uf_br;
