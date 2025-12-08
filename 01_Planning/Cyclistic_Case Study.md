# 📂 Cyclistic Case Study: Meta-Análise de Requisitos

Projeto: Google Data Analytics Capstone (Cyclistic)

Analista: Gabriel Lopes Cavallari

Data: Dezembro/2025

Tipo de Documento: Meta-Análise (Decomposição de Cenário)

## 1. 🧠 O Método de Leitura Analítica

_Este documento demonstra a metodologia utilizada para transformar notas de reuniões desestruturadas em requisitos técnicos de Business Intelligence._

Para extrair valor de atas de reunião, utilizo a **Decomposição Categórica**, classificando informações em quatro pilares fundamentais:

|   |   |   |   |
|---|---|---|---|
|**Categoria**|**Cor Mental**|**Pergunta Chave**|**O que procurar no texto?**|
|**Problema de Negócio**|🔴 **Vermelho**|_Por que estamos gastando dinheiro nisso?_|Dores, quedas de receita, novas estratégias, perguntas sem resposta.|
|**Stakeholders**|🔵 **Azul**|_Quem manda e quem usa?_|Nomes, cargos, quem aprova dados, quem consome o painel.|
|**Requisitos Funcionais**|🟢 **Verde**|_O que o software deve fazer?_|Gráficos específicos, mapas, filtros, KPIs, comparações.|
|**Restrições**|🟣 **Roxo**|_Quais são os limites?_|Prazos, leis (GDPR/LGPD), acessibilidade, ferramentas obrigatórias.|

## 2. 🏢 Decomposição do Cenário (Aplicação Prática)

### Contexto da Empresa

A **Cyclistic** é uma empresa de compartilhamento de bicicletas em Nova York (fictícia, baseada em dados reais do Citi Bike). Possui uma frota de bicicletas e estações físicas.

### 🔴 O Problema de Negócio (The "Why")

A equipe de crescimento quer entender o comportamento dos usuários para criar um plano de negócios para o próximo ano.

- **Dor Principal:** As estratégias atuais baseiam-se em observações internas ("achismos"), e não em dados.
    
- **Objetivo Estratégico:** Aumentar a base de clientes convertendo **Clientes Casuais** em **Membros Anuais** (Assinantes).
    
- **A Pergunta de Ouro:** _"Como clientes diferentes usam as bicicletas e onde a demanda exige novas estações?"_
    

### 🔵 Stakeholders (The "Who")

|   |   |   |
|---|---|---|
|**Nome**|**Cargo**|**Papel no Projeto**|
|**Sara Romero**|VP de Marketing|**Sponsor Principal**. Foca na conversão de usuários. Exige acessibilidade.|
|**Ernest Cox**|VP de Produto|Foca na expansão física (novas estações) e fluxo de bicicletas.|
|**Jamal Harris**|Diretor de Dados|**Gatekeeper**. Aprova o uso de dados de clientes e valida a privacidade.|
|**Equipe Técnica**|(Adhira, Megan, Rick)|Fornecem suporte sobre API, Data Warehouse e Governança.|

## 3. 📋 Matriz de Requisitos Traduzidos

Abaixo, a tradução das notas da reunião para requisitos técnicos, priorizados pela regra **R/D/N** (Required, Desired, Nice-to-have).

### 🟢 Requisitos Funcionais (Visualizações & Análises)

1. **Mapa de Demanda Geográfica (Prioridade: R)**
    
    - _Descrição:_ Visualizar locais de início e fim agregados por localização (Bairro/Distrito).
        
    - _Objetivo:_ Decidir onde instalar novas estações.
        
2. **Perfil de Uso: Membro vs. Casual (Prioridade: R)**
    
    - _Descrição:_ Segmentar todas as métricas por `User Type`.
        
    - _Objetivo:_ Entender o comportamento distinto para focar o marketing na conversão.
        
3. **Sazonalidade e Tendências de Pico (Prioridade: R)**
    
    - _Descrição:_ Análise focada no Verão de 2015 e picos horários.
        
    - _Objetivo:_ Planejamento de capacidade operacional.
        
4. **Análise de Destinos por Duração (Prioridade: D)**
    
    - _Descrição:_ Identificar para onde vão as viagens longas vs. curtas.
        
    - _Objetivo:_ Diferenciar uso de lazer (longo) vs. deslocamento (curto).
        
5. **Métricas de Congestionamento (Prioridade: D)**
    
    - _Descrição:_ Cálculo de fluxo líquido (`Saídas - Chegadas`) por estação.
        
    - _Objetivo:_ Identificar estações desbalanceadas (vazias ou cheias demais).
        
6. **Crescimento YoY (Ano a Ano) (Prioridade: D)**
    
    - _Descrição:_ Comparativo de volume 2014 vs 2015.
        
    - _Nota:_ Depende da disponibilidade de dados históricos (GAP identificado).
        

### 🟣 Requisitos Não-Funcionais (Restrições)

- **Acessibilidade (Crítico):** O dashboard deve ter fontes grandes e suporte a leitores de tela (TTS).
    
- **Privacidade:** Dados devem ser anonimizados. Nenhuma PII (Informação Pessoal Identificável).
    
- **Dados Externos:** Obrigatório o cruzamento com dados secundários de Clima e Censo (Limites Geográficos).
    
- **Prazo:** MVP em 6 semanas.
    

## 4. 🏗️ Arquitetura e Dados

### Fontes de Dados

- **Primária:** `Cyclistic Trip Data` (CSV/Banco de Dados). Contém: Start Time, End Time, Station ID, Lat/Long, User Type.
    
- **Secundária:**
    
    - `NOAA Weather Data` (Dados climáticos históricos).
        
    - `NYC Census Tracts` (Shapefiles para mapas).
        

### Suposições e GAPs (Lacunas)

1. **Impacto da Chuva:** Assumimos que precipitação diária afeta o dia todo, pois não temos dados de chuva por hora.
    
2. **Demanda Reprimida:** Assumimos que a falta de dados de "bicicleta indisponível" é uma limitação aceita; só analisaremos viagens concluídas.
    

## 5. 📅 Roll-out Plan (Cronograma)

- **Semana 1:** Configuração do GitHub, Download dos Dados e Documentação Inicial (Stakeholder Reqs).
    
- **Semana 2-3:** **ETL e SQL.** Limpeza de dados, tratamento de nulos e criação das tabelas fato/dimensão.
    
- **Semana 3-4:** **Design.** Criação dos wireframes e validação de KPIs.
    
- **Semana 5-6:** **Desenvolvimento e Entrega.** Construção final no BI (Power BI/Tableau) e apresentação.
    

_Documento gerado como parte do portfólio de Business Intelligence de Gabriel Lopes Cavallari._