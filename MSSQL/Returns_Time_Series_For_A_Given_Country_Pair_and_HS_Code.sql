/***********************************************************************************************
Returns Time Series Of Trade For A Given Country Pair and HS Code
Packages Required:
Panjiva Macro Reference Data
Panjiva Macro UN Comtrade Data

Universal Identifiers:
companyId

Primary Columns Used:
keyHS
keyMacroComtradeUnit
keyShipmentDirection
panjivaCountry

Database_Type:
MSSQL

Query_Version:
V1

Query_Added_Date:
23/11/2020

DatasetKey:
NULL

The following sample query returns time series of trade for a given country pair & HS Code
***********************************************************************************************/

SELECT top 100
pcor.countryName as ReportingCountry
, pcop.countryName as PartnerCountry
, psd.shipmentdirection
, pun.tradeDataYear, pun.tradeDataMonth
, phs.HSCode, phs.HSCodeName
, pun.tradeValue, pun.keyCurrency
, pun.tradeWeight
, pun.unitQuantity, punit.panjivaComtradeUnit
 FROM panjivaMacroUNComtrade pun
 left join panjivahscodes phs on phs.keyhs = pun.keyhs
 left join panjivaCountry pcor on pcor.panjivaCountry = pun.panjivaCountryReporting
 left join panjivaCountry pcop on pcop.panjivaCountry = pun.panjivaCountryPartner
 left join panjivaMacroComtradeUnit punit on punit.keyMacroComtradeUnit = pun.keyMacroComtradeUnit
 join panjivaShipmentDirection psd on psd.keyShipmentDirection = pun.keyShipmentDirection
 where pcor.countryName = 'united states' --reporting country
 and pcop.countryName = 'south korea' --partner country
 and phs.hsCode = '760410' --aluminum bars & rods
 order by ReportingCountry, PartnerCountry, shipmentdirection, tradeDataYear desc, TradeDataMonth desc, hscode