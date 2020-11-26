/***********************************************************************************************
Links Panjiva identifiers to Capital IQ data

Packages Required:
Panjiva Company Cross Ref

Universal Identifiers:
companyId

Primary Columns Used:
panjivaRecordId

Database_Type:
MSSQL

Query_Version:
V1

Query_Added_Date:
23/11/2020

DatasetKey:
22

The following sample query links Panjiva identifiers to S&P Capital IQ data. Note: Here TOP 100 are shown for better query execution

***********************************************************************************************/

select Top 100 panjivaRecordId, shpPanjivaId, csh.company, csh.ciqID, conPanjivaId, cco.company, cco.ciqID
from panjivaUSImport2019 im
left join (
 SELECT c.companyID as ciqID, c.companyName as company, ccr.identifiervalue
 FROM xfl_ciq.dbo.ciqCompany c
 JOIN xfl_ciq.dbo.ciqCompanyUltimateParent cup
 ON cup.ultimateParentCompanyId = c.companyId
 JOIN xfl_panjiva.dbo.panjivaCompanyCrossRef ccr
 ON ccr.companyId = cup.companyId
 GROUP BY c.companyId, c.companyName, ccr.identifiervalue
 ) csh ON im.shpPanjivaId = csh.identifiervalue
left join (
 SELECT c.companyID as ciqID, c.companyName as company, ccr.identifiervalue
 FROM xfl_ciq.dbo.ciqCompany c
 JOIN xfl_ciq.dbo.ciqCompanyUltimateParent cup
 ON cup.ultimateParentCompanyId = c.companyId
 JOIN xfl_panjiva.dbo.panjivaCompanyCrossRef ccr
 ON ccr.companyId = cup.companyId
 GROUP BY c.companyId, c.companyName, ccr.identifiervalue
 ) cco ON im.shpPanjivaId = cco.identifiervalue
