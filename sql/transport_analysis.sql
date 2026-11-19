-- London Public Transport Data Engineering Project
-- SQL Analysis using Microsoft Fabric Gold Layer

-- 1. Total journeys by transport mode
SELECT
    SUM(Bus_journeys_m) AS Total_Bus,
    SUM(Underground_journeys_m) AS Total_Underground,
    SUM(DLR_Journeys_m) AS Total_DLR,
    SUM(Tram_Journeys_m) AS Total_Tram,
    SUM(Overground_Journeys_m) AS Total_Overground,
    SUM(London_Cable_Car_Journeys_m) AS Total_Cable_Car,
    SUM(TfL_Rail_Journeys_m) AS Total_TfL_Rail,
    SUM(Total_Transport_Journeys) AS Grand_Total
FROM dbo.public_transport_gold;


-- 2. Top 10 reporting periods by total journeys
SELECT TOP 10
    Reporting_Period,
    Total_Transport_Journeys
FROM dbo.public_transport_gold
ORDER BY Total_Transport_Journeys DESC;


-- 3. Transport mode percentage share
WITH TransportTotals AS (
    SELECT 'Bus' AS Transport_Mode,
           SUM(Bus_journeys_m) AS Total_Journeys
    FROM dbo.public_transport_gold

    UNION ALL
    SELECT 'Underground',
           SUM(Underground_journeys_m)
    FROM dbo.public_transport_gold

    UNION ALL
    SELECT 'DLR',
           SUM(DLR_journeys_m)
    FROM dbo.public_transport_gold

    UNION ALL
    SELECT 'Tram',
           SUM(Tram_Journeys_m)
    FROM dbo.public_transport_gold

    UNION ALL
    SELECT 'Overground',
           SUM(Overground_Journeys_m)
    FROM dbo.public_transport_gold

    UNION ALL
    SELECT 'London Cable Car',
           SUM(London_Cable_Car_Journeys_m)
    FROM dbo.public_transport_gold

    UNION ALL
    SELECT 'TfL Rail',
           SUM(TfL_Rail_Journeys_m)
    FROM dbo.public_transport_gold
)
SELECT
    Transport_Mode,
    Total_Journeys,
    ROUND(
        Total_Journeys * 100.0 /
        SUM(Total_Journeys) OVER (), 2
    ) AS Percentage_Share
FROM TransportTotals
ORDER BY Total_Journeys DESC;


-- 4. Total number of records
SELECT COUNT(*) AS Total_Records
FROM dbo.public_transport_gold;
