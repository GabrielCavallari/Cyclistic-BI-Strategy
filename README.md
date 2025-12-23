# 🚲 Cyclistic Bike Share: Business Intelligence Strategy

![Badge Status](https://img.shields.io/badge/STATUS-FASE%202%20CONCLUÍDA-green) ![Tool BigQuery](https://img.shields.io/badge/Stack-BigQuery-blue) ![Tool SQL](https://img.shields.io/badge/Lang-SQL-orange) ![Tool Obsidian](https://img.shields.io/badge/Tool-Obsidian-purple)

## 📋 Sobre o Projeto
Este repositório documenta o ciclo completo de Business Intelligence desenvolvido para a **Cyclistic**, uma empresa fictícia de compartilhamento de bicicletas em Nova York. O projeto faz parte do *Google Business Intelligence Professional Certificate*.

**Objetivo de Negócio:**
A equipe de marketing busca entender como os **Clientes Casuais** e os **Membros Anuais** usam as bicicletas de forma diferente, visando criar estratégias baseadas em dados para converter casuais em membros recorrentes.

---

## 📂 Entregáveis da Fase 1: Planejamento Estratégico

Nesta etapa inicial, o foco foi traduzir necessidades de negócio em requisitos técnicos antes da execução.

### 1. [Project Requirements Document (PRD)](./01_Planning/Project_Requirements_Document.pdf)
Documento executivo que define o escopo, riscos e critérios de sucesso.
* **Métricas de Sucesso:** Identificação de pontos de alta demanda e padrões de sazonalidade (Verão 2015).
* **Acessibilidade:** Requisitos de design inclusivo (alto contraste e suporte a TTS).

### 2. [Strategy Document & KPIs](./01_Planning/Strategy_Document.pdf)
Alinhamento técnico das visualizações.
* **Decisão Estratégica:** Substituição da métrica de "Receita" (indisponível) por **"Média de Duração de Viagem"** para medir engajamento real.
* **Arquitetura:** Planejamento do Schema do banco de dados para unir Viagens, Clima e Geografia.

---

## 📂 Entregáveis da Fase 2: Engenharia de Dados (ETL)

O foco desta etapa foi a preparação e o enriquecimento dos dados brutos utilizando **Google BigQuery**. O dataset original carecia de informações geográficas granulares e contexto climático.

### 🛠️ Arquitetura da Solução
Desenvolvi um pipeline de dados em SQL para consolidar três fontes distintas em uma **Tabela Fato** única, otimizada para ferramentas de visualização.

**Fontes de Dados Conectadas:**
1.  **Viagens (Fact):** `citibike_trips` (BigQuery Public Data).
2.  **Geografia (Dimension):** `geo_us_boundaries` e `nyc_zip_codes` (Upload manual).
3.  **Clima (Dimension):** `noaa_gsod` (Dados meteorológicos globais).

### 💻 Destaques do Código SQL
* **Spatial Joins (`ST_WITHIN`):** Mapeamento reverso de coordenadas (Lat/Long) das estações para identificar Bairros e Distritos de NY.
* **Tratamento de Dados:** Conversão de unidades (Fahrenheit para Celsius) e criação de colunas condicionais (`CASE WHEN`) para categorizar dias de chuva.
* **Otimização:** Filtragem de dados ao nível do servidor para reduzir custos de processamento e armazenamento.

📄 **[Ver Código SQL Completo](./02_Data_Engineering/01_Data_Enrichment.sql)**

---

## 📂 Entregáveis da Fase 3: Design & Prototipagem

Antes do desenvolvimento final, protótipos de baixa fidelidade foram criados para validar a hierarquia visual.

### [Dashboard Mockup (Low-Code)](./03_Design/Dashboard_Mockup_v1.jpg)
* **Visualização:** Foco em Mapas de Calor (Heatmaps) para análise geoespacial intuitiva.
* **Funcionalidade:** Filtros de granulação temporal (Mês/Ano) e Tipo de Usuário no topo (Z-Pattern).

![Dashboard Mockup](./03_Design/Dashboard_Mockup_v1.png)
*(Mockup desenhado no Excalidraw demonstrando a disposição de KPIs, Mapa de Calor e Análise Sazonal)*

---

## 🛠 Ferramentas Utilizadas
* **Banco de Dados:** Google BigQuery (SQL Standard)
* **Documentação:** Obsidian & Google Docs
* **Prototipagem:** Excalidraw
* **Metodologia:** Decomposição Categórica de Requisitos

## 🔜 Próximos Passos
* [x] Fase 1: Planejamento
* [x] Fase 2: Engenharia de Dados
* [ ] **Fase 3: Visualização no Tableau (Em andamento)**

---
*Autor: Gabriel Lopes Cavallari* | [LinkedIn](https://www.linkedin.com/in/gabriel-lopes-cavallari-18106020a/)
