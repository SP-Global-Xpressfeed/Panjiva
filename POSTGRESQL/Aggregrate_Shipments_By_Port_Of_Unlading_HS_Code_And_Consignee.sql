/***********************************************************************************************
Returns Aggregate shipments by port of unlading, HS Code, and consignee

Packages Required:
Panjiva US Import 2017

Universal Identifiers:
NULL

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

The following sample query displays aggregate shipments by port of unlading, HS Code, and consignee. It displays associated weights and shipment counts

***********************************************************************************************/

select imp2017.portOfUnlading
, imp2017.conName
, hs2017.hsCode
, sum(imp2017.weightKg) as totalKG
, count(imp2017.panjivarecordid) as NumShipments
--, imp2017.quantity
from panjivaUSImport2017 imp2017
join panjivaUSImpHSCode2017 hs2017 on hs2017.panjivaRecordId = imp2017.panjivaRecordId
where 1=1
and imp2017.conName is not null
group by imp2017.portOfUnlading, hs2017.hsCode, imp2017.conName
order by imp2017.portOfUnlading, imp2017.conName, hs2017.hsCode
limit 100