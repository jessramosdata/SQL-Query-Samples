--Order level client report filterable by client. 
--Shows OrderID, the user who placed the order, order date, loan number, most recent report generated, etc.

SELECT OrderID, v.CompanyName, v.OrderDate, v.LoanNumber, 
v.UserName+' '+v.UserName AS UserName, ReportId AS 'Most Recent Report ID'
FROM Orders v
--Selects the most recent report generated for each order. Only those with reports are included (inner join)
INNER JOIN (SELECT OrderID, Id AS ReportId, ROW_NUMBER() OVER(PARTITION BY [OrderId] ORDER BY ReportCreatedAt DESC) AS RowNumber
		FROM Report) AS R2 
		ON v.OrderID = R2.OrderId
JOIN AOrder A
ON V.OrderId = A.ID
		WHERE R2.RowNumber is NULL OR R2.RowNumber = 1 AND v.OrderDate >= '2021-03-01' AND v.OrderDate < '2021-06-01' 
AND VerifierCompany = 'Company Mortgage LLC'
ORDER BY OrderDate desc