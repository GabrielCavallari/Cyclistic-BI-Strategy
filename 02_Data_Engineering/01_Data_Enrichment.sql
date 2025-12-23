/*
  Projeto: Cyclistic Bike Share - Google Data Analytics Capstone
  Arquivo: 01_Data_Preparation.sql
  Autor: Gabriel Lopes Cavallari
  Descrição: 
    Esta query consolida dados de três fontes distintas para criar a Tabela Fato
    que alimentará o Dashboard de Business Intelligence.
    
    Fontes de Dados:
    1. Viagens de Bike (Fact Table): bigquery-public-data.new_york_citibike.citibike_trips
    2. Geografia (Dimension): bigquery-public-data.geo_us_boundaries.zip_codes (Mapeamento Geoespacial)
    3. Clima (Dimension): bigquery-public-data.noaa_gsod.gsod2015 (Estação Central Park)
*/

SELECT
    -- --- DADOS PRINCIPAIS DA VIAGEM ---
    trips.start_station_name AS estacao_inicio,
    trips.end_station_name AS estacao_fim,
    trips.starttime AS data_inicio,
    trips.stoptime AS data_fim,
    trips.tripduration AS duracao_segundos,
    
    -- Segmentação de Cliente (Crítico para a análise de Marketing)
    trips.usertype AS tipo_usuario, 

    -- --- DADOS GEOGRÁFICOS (Enriquecimento) ---
    -- O CEP foi obtido via Join Espacial (Latitude/Longitude -> Polígono do CEP)
    geo_zip.zip_code AS cep_inicio,
    
    -- Bairros mapeados a partir do arquivo auxiliar 'nyc_zip_codes'
    nyc_bairros.borough AS distrito,
    nyc_bairros.neighborhood AS bairro,

    -- --- DADOS CLIMÁTICOS (Fatores Externos) ---
    -- Dados originais da estação meteorológica Central Park (ID 725053)
    
    -- Conversão de Fahrenheit para Celsius (Fórmula: (F - 32) * 5/9)
    ROUND((wea.temp - 32) * 5/9, 1) AS temp_media_celsius,
    
    -- Mantendo Fahrenheit para auditoria se necessário
    wea.temp AS temp_media_fahrenheit, 
    
    -- Precipitação em polegadas (0.00 indica sem chuva)
    wea.prcp AS precipitacao_chuva, 
    
    -- Flag categórico para simplificar visualização no Dashboard
    CASE 
        WHEN wea.prcp > 0 THEN 'Chuva' 
        ELSE 'Sem Chuva' 
    END AS condicao_tempo

FROM
    `bigquery-public-data.new_york_citibike.citibike_trips` AS trips

-- JOIN 1: ENRIQUECIMENTO GEOGRÁFICO
-- Cruza a lat/long da estação com o polígono geométrico do CEP dos EUA
INNER JOIN
    `bigquery-public-data.geo_us_boundaries.zip_codes` AS geo_zip
    ON ST_WITHIN(
        ST_GEOGPOINT(trips.start_station_longitude, trips.start_station_latitude),
        geo_zip.zip_code_geom
    )

-- JOIN 2: TRADUÇÃO DE BAIRROS
-- Cruza o CEP encontrado com a tabela de-para de Bairros de NYC
INNER JOIN
    `cyclistic-bi-capstone-482022.cyclistic_stg.nyc_zip_codes` AS nyc_bairros
    ON geo_zip.zip_code = CAST(nyc_bairros.zip AS STRING)

-- JOIN 3: ENRIQUECIMENTO CLIMÁTICO
-- Cruza a data da viagem com o registro diário do clima
LEFT JOIN
    `bigquery-public-data.noaa_gsod.gsod2015` AS wea
    ON 
        -- Extrai apenas a DATA (ignorando hora) para fazer o match
        DATE(trips.starttime) = DATE(PARSE_DATE('%Y%m%d', CONCAT(wea.year, wea.mo, wea.da)))
        -- Filtra especificamente a estação meteorológica do Central Park, NY
        AND wea.stn = '725053' 
        AND wea.wban = '94728'

WHERE
    -- Escopo do Projeto: Apenas ano fiscal de 2015 e estado de NY
    EXTRACT(YEAR FROM trips.starttime) = 2015
    AND geo_zip.state_code = 'NY'
    
-- Ordenação para facilitar a leitura inicial dos dados
ORDER BY 
    trips.starttime DESC;