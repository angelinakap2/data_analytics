/*

Cleaning Data in SQL Queries

*/

Select *
From PortfolioProject1.dbo.NashvilleHousing


-- Standardize Date Format
Select SaleDate, CONVERT(Date, SaleDate)
From PortfolioProject1.dbo.NashvilleHousing

-- update does not work
Update NashvilleHousing
SET SaleDate = CONVERT(Date, SaleDate)


-- update does work
ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
SET SaleDateConverted = CONVERT(Date, SaleDate)

Select SaleDateConverted, CONVERT(Date, SaleDate)
From PortfolioProject1.dbo.NashvilleHousing



-- Populate Property Address Data

-- some property addresses are null at the moment
Select *
From PortfolioProject1.dbo.NashvilleHousing
--where PropertyAddress is null
order by ParcelID

-- every ParcelID has a property address, and some are repeated
-- if a property address is null, there is a parcelID to match with it to find the property address



-- ISNULL(a, b): if a is null, populate it with b
Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress
, ISNULL(a.PropertyAddress, b.PropertyAddress)
From PortfolioProject1.dbo.NashvilleHousing a
JOIN PortfolioProject1.dbo.NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID] <> b.[UniqueID]
WHERE a.PropertyAddress is null


Update a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
From PortfolioProject1.dbo.NashvilleHousing a
JOIN PortfolioProject1.dbo.NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID] <> b.[UniqueID]

-- now there are no null PropertyAddress rows



-- Breaking out Address into Individual Columns (Address, City, State)

Select PropertyAddress
From PortfolioProject1.dbo.NashvilleHousing


SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)) as Address,
-- CHARINDEX(',', PropertyAddress): gives a number where the (comma + 1) index is
-- this is the index it cuts off
From PortfolioProject1..NashvilleHousing



SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) as Address
From PortfolioProject1..NashvilleHousing


-- apply changes: address and city separated properly 
ALTER TABLE NashvilleHousing
Add PropertySplitAddress nvarchar(255);

Update NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1)

ALTER TABLE NashvilleHousing
Add PropertySplitCity nvarchar(255);

Update NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))


Select *
From PortfolioProject1.dbo.NashvilleHousing



Select OwnerAddress
From PortfolioProject1.dbo.NashvilleHousing


-- uses parsename to separate address, city, state by replacing comma with period and then parsing
-- last number works in reverse (ex: 1 = last comma)
SELECT
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)
, PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)
, PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
From PortfolioProject1.dbo.NashvilleHousing


ALTER TABLE NashvilleHousing
Add OwnerSplitAddress nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

ALTER TABLE NashvilleHousing
Add OwnerSplitCity nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

ALTER TABLE NashvilleHousing
Add OwnerSplitState nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)


Select *
From PortfolioProject1.dbo.NashvilleHousing



-- Change Y and N to Yes and No in "Sold as Vacant" field

Select Distinct(SoldAsVacant), COUNT(SoldAsVacant)
From PortfolioProject1.dbo.NashvilleHousing
Group by SoldAsVacant
order by 2



Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
		When SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant
		END
From PortfolioProject1..NashvilleHousing


Update NashvilleHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
		When SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant
		END


-- no more double yes or no - all combined
Select Distinct(SoldAsVacant), COUNT(SoldAsVacant)
From PortfolioProject1.dbo.NashvilleHousing
Group by SoldAsVacant
order by 2


-- Remove Duplicates

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
From PortfolioProject1..NashvilleHousing
-- order by ParcelID
)
Select *
From RowNumCTE
Where row_num > 1

-- NO MORE DUPLICATES



-- Delete Unused Columns

Select *
From PortfolioProject1.dbo.NashvilleHousing

ALTER TABLE PortfolioProject1..NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE PortfolioProject1..NashvilleHousing
DROP COLUMN SaleDate

-- data is now much more usable :)