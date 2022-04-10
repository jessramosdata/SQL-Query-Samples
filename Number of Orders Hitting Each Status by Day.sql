--This query computes the number of orders hitting a certain status each day.
--It is useful for tracking statuses and possible system issues.

SELECT DATEADD(DAY, DATEDIFF(DAY, 0, StatusTimestamp), 0) AS StatusTimestamp, 
	sum(case [NewStatus] when 1 then 1 else 0 end) AS Status1,
	sum(case [NewStatus] when 2 then 1 else 0 end) AS Status2,
	sum(case [NewStatus] when 3 then 1 else 0 end) AS Status3,
	sum(case [NewStatus] when 4 then 1 else 0 end) AS Status4,
	sum(case [NewStatus] when 5 then 1 else 0 end) AS Status5,
	sum(case [NewStatus] when 6 then 1 else 0 end) AS Status6,
	sum(case [NewStatus] when 7 then 1 else 0 end) AS Status7,
	sum(case [NewStatus] when 8 then 1 else 0 end) AS Status8,
	sum(case [NewStatus] when 9 then 1 else 0 end) AS Status9,
	sum(case [NewStatus] when 10 then 1 else 0 end) AS Status10,
	sum(case [NewStatus] when 11 then 1 else 0 end) AS Status11,
	sum(case [NewStatus] when 12 then 1 else 0 end) AS Status12,
	sum(case [NewStatus] when 13 then 1 else 0 end) AS Status13,
	sum(case [NewStatus] when 14 then 1 else 0 end) AS Status14,
	sum(case [NewStatus] when 15 then 1 else 0 end) AS Status15,
	sum(case [NewStatus] when 16 then 1 else 0 end) AS Status16,
	sum(case [NewStatus] when 17 then 1 else 0 end) AS Status17,
	sum(case [NewStatus] when 18 then 1 else 0 end) AS Status18

FROM OrderStatusLog
WHERE [StatusTimestamp] >= DATEADD(MONTH, -6, GETUTCDATE())
GROUP BY DATEADD(DAY, DATEDIFF(DAY, 0, StatusTimestamp), 0)
ORDER BY 1 desc