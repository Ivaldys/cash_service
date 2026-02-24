DECLARE @StartDate DATETIME;
DECLARE @EndDate DATETIME;

SET @StartDate = DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1);
SET @EndDate = DATEADD(MONTH, 1, @StartDate);

SELECT b.City AS Город, b.Address AS Адрес, COUNT(l.Id) AS КоличествоДоставок, SUM(o.Amount) AS СуммаДоставлено
FROM Branches b
JOIN CashOrders o
    ON o.BranchId = b.Id
JOIN LogisticsRequests l
    ON l.CashOrderId = o.Id
WHERE l.Status = 'ДОСТАВЛЕНО' AND l.PlannedDeliveryAt >= @StartDate AND l.PlannedDeliveryAt <  @EndDate
GROUP BY b.City, b.Address
ORDER BY СуммаДоставлено DESC;
GO