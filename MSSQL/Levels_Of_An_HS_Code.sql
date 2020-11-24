/***********************************************************************************************
Returns Three Levels Of An HS Code

Packages Required:
Panjiva HS Classification

Universal Identifiers:
NULL

Primary Columns Used:
hsCode

Database_Type:
MSSQL

Query_Version:
V1

Query_Added_Date:
23/11/2020

DatasetKey:
22

The following sample query displays all three levels of an HS Code in order to create a full six digit view

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