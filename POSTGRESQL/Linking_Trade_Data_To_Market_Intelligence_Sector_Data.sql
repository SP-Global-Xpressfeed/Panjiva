/***********************************************************************************************
Links Trade Data To Market Intelligence Sector Data

Packages Required:
Panjiva Company Cross Ref

Universal Identifiers:
companyId

Primary Columns Used:
tradingItemId
companyId

Database_Type:
POSTGRESQL

Query_Version:
V1

Query_Added_Date:
23/11/2020

DatasetKey:
22

The following sample query links Panjiva trade data to S&P Global Market Intelligence industry sector data

***********************************************************************************************/

select distinct ti.tradingItemId, ti.tickerSymbol, c.companyID, c.companyName
from xfeedpost.xfeedpost.ciqCompany c -- begin with all CIQ companies
 join xfeedpost.xfeedpost.ciqCompanyUltimateParent cup on cup.ultimateParentCompanyId = c.companyId
 join xfeedpost.xfeedpost.ciqSecurity s on s.companyId = c.companyId and s.primaryFlag = 1
 join xfeedpost.xfeedpost.ciqTradingItem ti on ti.securityId = s.securityId and ti.primaryFlag = 1
 join panjivaCompanyCrossRef ccr on ccr.companyId = cup.companyId
 join xfeedpost.xfeedpost.ciqCompanyIndustry ci on ci.companyId = c.companyId
 join xfeedpost.xfeedpost.ciqSubTypeToGICS stg on stg.subTypeId =ci.industryId
where 1 = 1
 and stg.GIC = 25101010 -- GICS auto parts/eqpmt makers only
 and c.countryID = 213 -- US Companies Only