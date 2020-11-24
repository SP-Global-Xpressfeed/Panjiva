/***********************************************************************************************
Data In Countries That Do Not Have A Data Source

Packages Required:
Panjiva India Import 2019

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

The following sample query finds data in countries that do not have a data source

***********************************************************************************************/

select *
from (
select panjivaRecordId, shpmtOrigin
from panjivaUSImport2019
union all
select panjivaRecordId, shpmtOrigin
from panjivaUSImport2018
union all
select panjivaRecordId, shpmtOrigin
from panjivaBRImport2019
union all
select panjivaRecordId, shpmtOrigin
from panjivaBRImport2018
union all
select panjivaRecordId, shpmtOrigin
from panjivaINImport2019
) sub
where shpmtOrigin = 'Palau'