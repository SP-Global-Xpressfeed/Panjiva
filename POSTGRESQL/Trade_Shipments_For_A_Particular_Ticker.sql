/***********************************************************************************************
Returns Trade Shipments For A Particular Ticker

Packages Required:
Panjiva Company Cross Ref
Panjiva US Import 2017

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

The following sample query below displays U.S. import and export shipments for a particular ticker

***********************************************************************************************/

select c.companyid
, c.companyname
, imp2017.arrivaldate
, imp2017.fileDate
, imp2017.quantity
, imp2017.weightKg
, hs2017.hsCode
from xfeedpost.xfeedpost.ciqcompany c
join xfeedpost.xfeedpost.ciqsecurity s on s.companyId = c.companyid and s.primaryFlag =1
join xfeedpost.xfeedpost.ciqTradingItem ti on ti.securityId = s.securityId and ti.primaryFlag = 1
join panjivaCompanyCrossRef ccr on ccr.companyId = c.companyid
join panjivaUSImport2017 imp2017 on cast(imp2017.conPanjivaid as VARCHAR) = cast(ccr.identifiervalue as VARCHAR)
join panjivaCompanyCrossRef ccr_shp on cast(ccr_shp.identifierValue as VARCHAR)= cast(imp2017.shpPanjivaId as VARCHAR)
join panjivaUSImpHSCode2017 hs2017 on hs2017.panjivaRecordId = imp2017.panjivaRecordId
where ti.tickerSymbol = 'UAA'