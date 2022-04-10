--Computes the Days History returned for each order based on their bank account records.
--Days History is computed by the timestamp difference between the first transaction date and the date the data is pulled.
--This shows how many days history we have returned for a consumer. 
SELECT V.Order_ID,
	fi.FIAccountID,  
	MAX(t.[DATE_RETREIVED]) as [Latest Date], 
	MIN(t.[TRANSACTION_DATE]) as [Earliest Date],
	(DATEDIFF(dd, MIN(t.[TRANSACTION_DATE]), MAX(t.[DATE_RETREIVED])) + 1) AS [Days History in Bank Account]

FROM FIAccount fi
LEFT JOIN [dbo].[Bank Accounts] t 
ON fi.FIAccountId = t.FIAccountId
INNER JOIN FinancialInstitutionLogin fil 
ON fi.FinancialInstitutionLoginId = fil.Id
LEFT JOIN Order v
ON fi.Order_ID = V.Order_ID

WHERE V.OrderDate >= GETUTCDATE()-60
GROUP BY V.Order_ID, fi.[FIAccountID]
