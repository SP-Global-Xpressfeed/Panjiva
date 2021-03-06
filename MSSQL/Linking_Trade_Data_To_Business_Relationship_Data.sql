/***********************************************************************************************
Links Panjiva Trade Data To Business Relationships Data

Packages Required:
Panjiva Company Cross Ref

Universal Identifiers:
companyId

Primary Columns Used:
companyId

Database_Type:
MSSQL

Query_Version:
V1

Query_Added_Date:
23/11/2020

DatasetKey:
22

The following sample query links Panjiva trade data to S&P Capital IQ Business Relationships data, by creating temporary table

***********************************************************************************************/

with cte as (
 select distinct
 cCust.companyId customerCompanyId,
 cCust.companyName customerCompanyName,
 cSupp.companyId supplierCompanyId,
 cSupp.companyName supplierCompanyName
 from  xfl_ciq..ciqBusinessRel (nolock) br
 join  xfl_ciq..ciqBusinessRelType (nolock) brt on br.businessRelTypeId = brt.businessRelTypeId
 join  xfl_ciq..ciqCompany (nolock) cSupp on br.parentCompanyId = cSupp.companyId
 and br.businessRelTypeId in (1,2) -- Supplier/Customer business relationships
 join  xfl_ciq..ciqCompany (nolock) cCust on cCust.companyId = br.childCompanyId
 where cCust.companyId = 106335 -- customer Ford
)
select cte.customerCompanyId, cte.customerCompanyName,
cte.supplierCompanyId, cte.supplierCompanyName,
pccr.identifierValue panjivaId, pccr.primaryFlag
into #companyList_PAN
from
cte
left join panjivaCompanyCrossRef (nolock) pccr on cte.supplierCompanyId = pccr.companyId
 and pccr.primaryFlag = 1 -- remove non-primary
order by cte.supplierCompanyName, pccr.primaryFlag desc

SELECT * FROM #companyList_PAN