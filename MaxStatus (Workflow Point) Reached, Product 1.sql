--Below maps/recodes each status to a StatusLevel, which are assigned chronologically for clarity
--The second part pulls the max status level reached to determine the max workflow point the order reached.
--This helps identify fallout points and determine how to increase the order completion rate.

WITH StatusLevels AS(
SELECT vr.OrderID, vsl.PreviousStatus, vsl.NewStatus, vsl.StatusTimestamp, [Order Date], [CurrentStatus], CompanyID,

CASE 
	WHEN vsl.NewStatus = 111 THEN 0
	WHEN vsl.NewStatus = 222 THEN 1
	WHEN vsl.NewStatus = 333 THEN 1
	WHEN vsl.NewStatus = 444 THEN 2
	WHEN vsl.NewStatus = 555 THEN 3
	WHEN vsl.NewStatus = 666 THEN 4
	WHEN vsl.NewStatus = 777 THEN 4
	WHEN vsl.NewStatus = 888 THEN 4
	WHEN vsl.NewStatus = 999 THEN 5
	WHEN vsl.NewStatus = 1212 THEN 6
	WHEN vsl.NewStatus = 2323 THEN 6
	WHEN vsl.NewStatus = 3434 THEN 7
	WHEN vsl.NewStatus = 4545 THEN 8
	WHEN vsl.NewStatus = 5656 THEN 9
	WHEN vsl.NewStatus = 123 THEN 10
	WHEN vsl.NewStatus = 234 THEN 11
	WHEN vsl.NewStatus = 456 THEN 11
	WHEN vsl.NewStatus = 543 THEN 12
	WHEN vsl.NewStatus = 321 THEN 13
	WHEN vsl.NewStatus = 3456 THEN 13
	ELSE NULL END AS [StatusLevel]


FROM Orders vr 
LEFT JOIN OrderStatusLog vsl
ON vr.OrderID = vsl.OrderID
WHERE vr.OrderDate >= DATEADD(DAY, -30, GETUTCDATE())
)

/*below pulls the MAX status level reached and the current status for each OrderID*/

SELECT s.[OrderID], MIN([Order Date]) AS [Order Date], MAX(StatusLevel) AS MaxStatusLevel, s.CurrentStatus, CompanyID
FROM StatusLevels s
GROUP BY S.OrderID, s.CurrentStatus, CompanyID







/*
SELECT MaxStatus.*,

CASE
	WHEN MaxStatusLevel IN (1, 2, 3) OR MaxStatusLevel is null THEN 'No Attempt'
	WHEN MaxStatusLevel >= 4 THEN 'Attempted Link'
	WHEN MaxStatusLevel >= 16 THEN 'Completed Link'
	WHEN MaxStatusLevel = 18 THEN 'Report Ready'

	ELSE NULL END AS [Description]

FROM MaxStatus
*/
