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

select
a.hsCodeLevel,
a.hsCodeDescription,
a.hsCode,
case
when a.hsCodeLevel = 2 and len(a.hsCode) = 1 then '0' + a.hsCode + '0000'
when a.hsCodeLevel = 2 and len(a.hsCode) = 2 then a.hsCode + '0000'
when a.hsCodeLevel = 4 and len(a.hsCode) = 3 then '0' + a.hsCode + '00'
when a.hsCodeLevel = 4 and len(a.hsCode) = 4 then a.hsCode + '00'
when a.hsCodeLevel = 6 and len(a.hsCode) = 5 then '0' + a.hsCode
when a.hsCodeLevel = 6 and len(a.hsCode) = 6 then a.hsCode
else null end as hsCodeFull
from panjivaHSClassification a (nolock)
where a.hsCode is not null -- remove 1 record
order by 1, 4
