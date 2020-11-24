/***********************************************************************************************
Returns First Instance Of The Fully Matching HS Code For A Given PanjivaRecordId

Packages Required:
Panjiva HS Classification
Panjiva US Export 2017

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

The following sample query displays the first instance of the fully matching HS Code for a given panjivaRecordId

***********************************************************************************************/

select use17.panjivaRecordId
, use17.shpmtDate
, use17.shpmtDestination
, use17.shpName
, use17.weightKg
,left(useHS17.hsCode
,len(left(useHS17.hsCode,charindex(';',useHS17.hsCode)))-1) as firstHsCode
,hsc.hsCodeDescription

from panjivaUSExport2017 use17 (nolock)

join panjivaUSExpHSCode2017 useHS17 (nolock) on use17.panjivaRecordId = useHS17.panjivaRecordId

join panjivaHSClassification hsc (nolock)

on left(useHS17.hsCode,len(left(useHS17.hsCode,charindex(';',useHS17.hsCode)))-1) = hsc.hsCode

where use17.panjivaRecordId = 25998457