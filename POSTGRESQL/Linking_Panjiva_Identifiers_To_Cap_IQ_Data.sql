/***********************************************************************************************
Links Panjiva identifiers to Capital IQ data

Packages Required:
Panjiva Company Cross Ref

Universal Identifiers:
companyId

Primary Columns Used:
panjivaRecordId

Database_Type:
POSTGRESQL

Query_Version:
V1

Query_Added_Date:
23/11/2020

DatasetKey:
22

The following sample query links Panjiva identifiers to S&P Capital IQ data. Note: Here TOP 100 are shown for better query execution

***********************************************************************************************/

select  panjivaRecordId, shpPanjivaId, csh.company, csh.ciqID, conPanjivaId, cco.company, cco.ciqID
from panjivaUSImport2019 im
left join (
 SELECT c.companyID as ciqID, c.companyName as company, ccr.identifiervalue
 FROM xfeedpost.xfeedpost.ciqCompany c
 JOIN xfeedpost.xfeedpost.ciqCompanyUltimateParent cup
 ON cup.ultimateParentCompanyId = c.companyId
 JOIN panjivaCompanyCrossRef ccr
 ON ccr.companyId = cup.companyId
 GROUP BY c.companyId, c.companyName, ccr.identifiervalue
 ) csh ON cast(im.shpPanjivaId as VARCHAR) = cast(csh.identifiervalue as VARCHAR)
left join (
 SELECT c.companyID as ciqID, c.companyName as company, ccr.identifiervalue
 FROM xfeedpost.xfeedpost.ciqCompany c
 JOIN xfeedpost.xfeedpost.ciqCompanyUltimateParent cup
 ON cup.ultimateParentCompanyId = c.companyId
 JOIN panjivaCompanyCrossRef ccr
 ON ccr.companyId = cup.companyId
 GROUP BY c.companyId, c.companyName, ccr.identifiervalue
 ) cco ON cast(im.shpPanjivaId as VARCHAR)= cast(cco.identifiervalue as VARCHAR)
 
 limit 100
