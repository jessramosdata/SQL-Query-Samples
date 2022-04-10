
--Top Portion: collects all billable orders for Product#1.
--Bottom Portion: collects all billable orders for Product#2.
--Union stacks them together and includes all orders for both products in the same table.
(SELECT
	[AOrder ID],
	[Product#1 ID],
	[Product#2 ID] = NULL,
	CustomerID,
	[Verification OrderCompletionDate],
	[Product Type] = 'Product#1',
	[Product#1 Price],
	[Product#2 Price] = 0
FROM AOrder A
LEFT JOIN Orders v 
ON A.ID = v.AOrderId
LEFT JOIN OrderBillables B
ON V.OrderID=B.OrderID
WHERE v.OrderID is not null
AND b.[OrderCompletionDate] is not null
AND b.[OrderCompletionDate] >= '2020-01-01')
UNION
/* select statement below collects all billable Product#2s and filters out non billable Product#2s)
UNION stacks them together */
(SELECT
	[A Order ID],
	[Product#1 ID] = NULL,
	[Product#2 ID],
	CustomerID,
	[Verification OrderCompletionDate],
	[Product Type] = 'Product#2',
	[Product#1 Price] = 0,
	CASE WHEN v2.BillingEvent=0 THEN  15 WHEN v2.BillingEvent = 1 THEN 5 ELSE null END AS [Product#2 Price]
FROM AOrder A
INNER JOIN Product#2Billing v2
ON A.ID = v2.AOrderId
WHERE v2.ID is not null
AND v2.IsBillable = 1
AND v2.OrderCompletionDate >= '2020-01-01')