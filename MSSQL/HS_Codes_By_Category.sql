/***********************************************************************************************
Returns All Levels Of HS Code By Category

Packages Required:
Panjiva HS Classification

Universal Identifiers:
companyId

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

The following sample query displays all levels of HS Code by category

***********************************************************************************************/

select
-- Level 2 Classification
case
when f2.hsCodeLevel = 2 and len(f2.hsCode) = 1 then '0' + f2.hsCode
when f2.hsCodeLevel = 2 and len(f2.hsCode) = 2 then f2.hsCode
else null end as hsCodeFull2,
f2.hsCodeDescription,
-- Level 4 Classification
case
when f4.hsCodeLevel = 4 and len(f4.hsCode) = 3 then '0' + f4.hsCode
when f4.hsCodeLevel = 4 and len(f4.hsCode) = 4 then f4.hsCode
else null end as hsCodeFull4,
f4.hsCodeDescription,
-- Level 6 Classification
case
when f6.hsCodeLevel = 6 and len(f6.hsCode) = 5 then '0' + f6.hsCode
when f6.hsCodeLevel = 6 and len(f6.hsCode) = 6 then f6.hsCode
else null end as hsCodeFull6,
f6.hsCodeDescription
from panjivaHSClassification f6 (nolock)
join panjivaHSClassification f4 (nolock) on f6.hscodeParent = f4.hsCode
join panjivaHSClassification f2 (nolock) on f4.hscodeParent = f2.hsCode
where f6.hsCodeLevel = 6
order by 1