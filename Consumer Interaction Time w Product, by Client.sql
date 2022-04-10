--This tables computes basic stats on how fast consumers interact with our product for each company/client.
--Those with faster order interaction times are high performers. 

select CompanyID, Count(Distinct(OrderID)) AS [Number of Orders],
MIN(DateDiff(minute, OrderStartedDate,  OrderCompletionDate)) AS [MIN Consumer Interaction Time Minutes],
AVG(DateDiff(minute, OrderStartedDate,  OrderCompletionDate)) AS [AVG Consumer Interaction Time Minutes],
MAX(DateDiff(minute, OrderStartedDate,  OrderCompletionDate)) AS [MAX Consumer Interaction Time Minutes], 
MIN(DateDiff(Hour, OrderStartedDate,  OrderCompletionDate)) AS [MIN Consumer Interaction Time Hours],
AVG(DateDiff(Hour, OrderStartedDate,  OrderCompletionDate)) AS [AVG Consumer Interaction Time Hours], 
MAX(DateDiff(Hour, OrderStartedDate,  OrderCompletionDate)) AS [MAX Consumer Interaction Time Hours]

from Orders v
LEFT JOIN OrderStatusLog s
on OrderID = s.OrderID
JOIN accountchekorder a 
on v.accountchekorderid = a.id

where v.OrderStartedDate >= (getutcdate() -60) AND v.OrderStartedDate < (getutcdate() -30)
AND Newstatus IN (503) AND a.integratorid = 'Optional: FILTER FOR INTEGRATION PARTNER ID HERE'
GROUP BY CompanyID
--Filter out those with very small sample sizes
Having Count(Distinct(OrderID)) >= 10
ORDER BY Count(Distinct(OrderID))

/*84.3% of borrowers go to the FI selection page*/



