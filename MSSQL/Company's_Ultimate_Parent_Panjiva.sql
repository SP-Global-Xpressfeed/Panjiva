/***********************************************************************************************
Returns Company And Ultimate Parent

Packages Required:
Panjiva Company Cross Ref
Panjiva HS Classification
Panjiva US Import 2017

Universal Identifiers:
companyId

Primary Columns Used:
hsCode
panjivaRecordId

Database_Type:
MSSQL

Query_Version:
V1

Query_Added_Date:
23/11/2020

DatasetKey:
22

The following sample query displays a companys ultimate parent in S&P Capital IQ data

***********************************************************************************************/

select DISTINCT c.companyid as UltimateParentId
, c.companyname as UltimateParentName
, ccr.companyId as Companyid
, imp2017.conName as CompanyName
, imp2017.billofladingnumber
, imp2017.vessel
, imp2017.vesselvoyageid
, imp2017.arrivaldate
, imp2017.fileDate
, imp2017.quantity
, imp2017.weightKg
, hs2017.hsCode
from xfl_ciq..ciqcompany c
join xfl_ciq..ciqsecurity s on s.companyId = c.companyid
join xfl_ciq..ciqTradingItem ti on ti.securityId = s.securityId
join xfl_ciq..ciqCompanyUltimateParent cup on cup.ultimateParentCompanyId = c.companyId
join panjivaCompanyCrossRef ccr on ccr.companyId = cup.companyid
join panjivaUSImport2017 imp2017 on imp2017.conPanjivaid = ccr.identifiervalue
join panjivaUSImpHSCode2017 hs2017 on hs2017.panjivaRecordId = imp2017.panjivaRecordId
left join panjivaHSClassification hs on hs.hsCode = REPLACE(left(hs2017.hsCode, 7), '.', '')
where 1=1
and ti.tickerSymbol = 'TM' --� Toyota