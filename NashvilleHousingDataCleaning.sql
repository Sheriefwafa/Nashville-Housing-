/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [UniqueID ]
      ,[ParcelID]
      ,[LandUse]
      ,[PropertyAddress]
      ,[SaleDate]
      ,[SalePrice]
      ,[LegalReference]
      ,[SoldAsVacant]
      ,[OwnerName]
      ,[OwnerAddress]
      ,[Acreage]
      ,[TaxDistrict]
      ,[LandValue]
      ,[BuildingValue]
      ,[TotalValue]
      ,[YearBuilt]
      ,[Bedrooms]
      ,[FullBath]
      ,[HalfBath]
  FROM [SQL Tutorial].[dbo].[Nashville Housing]


  SELECT *
  FROM [SQL Tutorial].[dbo].[Nashville Housing]



  SELECT SaleDate
  FROM [SQL Tutorial].[dbo].[Nashville Housing]


 --## let`s begin with converting the Date 


 --SELECT SaleDateconverted , CONVERT(Date,SaleDate) AS Date
 --FROM [SQL Tutorial].[dbo].[Nashville Housing]


 --UPDATE Nashville Housing
 --SET SaleDate = CONVERT(Date, SaleDate)


 --ALTER TABLE [SQL Tutorial].[dbo].[Nashville Housing]
 --ADD SaleDateconverted Date;
  

 --SELECT SaleDateconverted , CONVERT(Date,SaleDate)
 --FROM [SQL Tutorial].[dbo].[Nashville Housing]



 SELECT SaleDate,CONVERT(Date,SaleDATE)
 FROM [SQL Tutorial].[dbo].[Nashville Housing]


 ALTER TABLE [SQL Tutorial].[dbo].[Nashville Housing]
 ADD SaleDateconverted2 Date;

 
 SELECT SaleDateconverted2,CONVERT(Date,SaleDATE) AS Date 
 FROM [SQL Tutorial].[dbo].[Nashville Housing]



 --Populate Property Address

  SELECT PropertyAddress
 FROM [SQL Tutorial].[dbo].[Nashville Housing]
 WHERE PropertyAddress is NULL


   SELECT *
 FROM [SQL Tutorial].[dbo].[Nashville Housing]
 WHERE PropertyAddress is NULL
 ORDER BY ParcelID


 SELECT  A.ParcelID, A.PropertyAddress, B.ParcelID, B.PropertyAddress, ISNULL( A.PropertyAddress, B.PropertyAddress)
 FROM [SQL Tutorial].[dbo].[Nashville Housing] A
 jOIN [SQL Tutorial].[dbo].[Nashville Housing] B
 ON A.ParcelID = b.ParcelID
 AND A.UniqueID <> B. UniqueID
 WHERE A.PropertyAddress is NULL


 UPDATE A
 SET PropertyAddress =  ISNULL( A.PropertyAddress, B.PropertyAddress)
 FROM [SQL Tutorial].[dbo].[Nashville Housing] A
 jOIN [SQL Tutorial].[dbo].[Nashville Housing] B
 ON A.ParcelID = b.ParcelID
 AND A.UniqueID <> B. UniqueID
 WHERE A.PropertyAddress is NULL


--Breaking out Address into individual columns (city,state,address)


  SELECT PropertyAddress
 FROM [SQL Tutorial].[dbo].[Nashville Housing]
 --WHERE PropertyAddress is NULL


 SELECT
 SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) AS address
 FROM [SQL Tutorial].[dbo].[Nashville Housing]


 SELECT
 SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

From [SQL Tutorial].[dbo].[Nashville Housing]



  ALTER TABLE [SQL Tutorial].[dbo].[Nashville Housing]
 ADD PropertysplitAddress NVARCHAR(255);

 UPDATE [SQL Tutorial].[dbo].[Nashville Housing]
 SET PropertysplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) 
 --From [SQL Tutorial].[dbo].[Nashville Housing]


   ALTER TABLE [SQL Tutorial].[dbo].[Nashville Housing]
 ADD PropertysplitCity NVARCHAR(255);

 UPDATE [SQL Tutorial].[dbo].[Nashville Housing]
 SET PropertysplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) 
 --From [SQL Tutorial].[dbo].[Nashville Housing]

 SELECT*
 FROM [SQL Tutorial].[dbo].[Nashville Housing]




SELECT OwnerAddress
 FROM [SQL Tutorial].[dbo].[Nashville Housing]




 


Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From [SQL Tutorial].[dbo].[Nashville Housing]

ALTER TABLE [SQL Tutorial].[dbo].[Nashville Housing]
ADD Ownersplitaddress NVARCHAR(255);

UPDATE [SQL Tutorial].[dbo].[Nashville Housing]
SET Ownersplitaddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE [SQL Tutorial].[dbo].[Nashville Housing]
ADD OwnersplitCity NVARCHAR(255);

UPDATE [SQL Tutorial].[dbo].[Nashville Housing]
SET OwnersplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE [SQL Tutorial].[dbo].[Nashville Housing]
ADD OwnersplitState NVARCHAR(255);

UPDATE [SQL Tutorial].[dbo].[Nashville Housing]
SET OwnersplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)


SELECT *

From [SQL Tutorial].[dbo].[Nashville Housing]


--Change Y & N to YES & NO in sold as vacant field

SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
From [SQL Tutorial].[dbo].[Nashville Housing]
GROUP BY SoldAsVacant
ORDER BY 2


SELECT SoldAsVacant
, CASE WHEN SoldAsVacant = 'Y' THEN 'YES' 
       WHEN SoldAsVacant = 'N' THEN 'NO'
	   ELSE SoldAsVacant
	   END
From [SQL Tutorial].[dbo].[Nashville Housing]



UPDATE [SQL Tutorial].[dbo].[Nashville Housing]
SET  SoldAsVacant =  CASE WHEN SoldAsVacant = 'Y' THEN 'YES' 
       WHEN SoldAsVacant = 'N' THEN 'NO'
	   ELSE SoldAsVacant
	   END
From [SQL Tutorial].[dbo].[Nashville Housing]



SELECT SoldAsVacant, COUNT(SoldAsVacant)
From [SQL Tutorial].[dbo].[Nashville Housing]
GROUP BY SoldAsVacant




--Remove Duplicates 



WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From [SQL Tutorial].[dbo].[Nashville Housing]
--order by ParcelID
)
SELECT *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress



--DELETE UNUSED COLUMNS

ALTER TABLE [SQL Tutorial].[dbo].[Nashville Housing]
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate













































