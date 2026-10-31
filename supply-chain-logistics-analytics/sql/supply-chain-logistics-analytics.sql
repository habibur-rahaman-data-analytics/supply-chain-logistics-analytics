create database SupplyChainAndLogisticsAnalytics;

use SupplyChainAndLogisticsAnalytics;

select * from dbo.supply_chain_analysis;



-- Late deliveries by shipping mode

SELECT
    [Shipping Mode],
    COUNT(DISTINCT [Order Id]) AS total_orders,
    COUNT(DISTINCT CASE
        WHEN [Days for shipping (real)] >
             [Days for shipment (scheduled)]
        THEN [Order Id]
    END) AS late_orders,
    CAST(
        100.0 * COUNT(DISTINCT CASE
            WHEN [Days for shipping (real)] >
                 [Days for shipment (scheduled)]
            THEN [Order Id]
        END)
        / NULLIF(COUNT(DISTINCT [Order Id]), 0)
        AS DECIMAL(5,2)
    ) AS late_delivery_rate_pct
FROM dbo.supply_chain_analysis
GROUP BY [Shipping Mode]
ORDER BY late_delivery_rate_pct DESC;



-- Sales and profit by product category

SELECT
    [Category Name],
    SUM(TRY_CAST([Sales] AS DECIMAL(18, 2))) AS total_sales,
    SUM(TRY_CAST([Order Profit Per Order] AS DECIMAL(18, 2))) AS total_profit
FROM dbo.supply_chain_analysis
GROUP BY [Category Name]
ORDER BY total_sales DESC;



-- Late deliveries by market

SELECT
    [Market],
    COUNT(DISTINCT [Order Id]) AS total_orders,
    COUNT(DISTINCT CASE
        WHEN [Days for shipping (real)] >
             [Days for shipment (scheduled)]
        THEN [Order Id]
    END) AS late_orders,
    CAST(
        100.0 * COUNT(DISTINCT CASE
            WHEN [Days for shipping (real)] >
                 [Days for shipment (scheduled)]
            THEN [Order Id]
        END)
        / NULLIF(COUNT(DISTINCT [Order Id]), 0)
        AS DECIMAL(5,2)
    ) AS late_delivery_rate_pct
FROM dbo.supply_chain_analysis
GROUP BY [Market]
ORDER BY late_delivery_rate_pct DESC;