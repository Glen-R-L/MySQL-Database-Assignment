
Create Database Breakdown_Company;
Use Breakdown_Company;


-- Task 1 - Create Tables, Fields, and Keys

Create Table Member(memberID Varchar(10) Primary Key, MFName Varchar(20), MLName Varchar(20), MLocation Varchar(20));
Create Table Vehicle(VehReg Varchar(10) Primary Key, VehMake Varchar(10), VehModel Varchar(10), memberID Varchar(10));
Create Table Engineer(engID INT Primary Key, EFName Varchar(20), ELName Varchar(20));
Create Table EngVan(VanReg Varchar(10) Primary Key, VanMake Varchar(10), VanModel Varchar(10), engID INT, VMileage INT);
Create Table Breakdown(BDID INT(10) Primary Key, VehReg Varchar(10), VanReg Varchar(10), BDDate Date, BDTime Time, BDLocation Varchar(20));

Alter Table Vehicle Add Foreign Key(memberID) References Member(memberID);
Alter Table EngVan Add Foreign Key(engID) References Engineer(engID);

Alter Table Breakdown Add Foreign Key(VehReg) References Vehicle(VehReg), Add Foreign Key(VanReg) References EngVan(VanReg);


-- Task 2 - Insert Data

Insert Into Member(memberID, MFName, MLName, MLocation) Values ('D3868', 'Geoff', 'Crane', 'Loughborough'), ('B2965', 'Rebert', 'Lemin', 'Southampton'), ('U2938', 'James', 'Gregs', 'Dorchester'), ('J2829', 'Yosef', 'Delma', 'Stratford'), ('I2958', 'Peter', 'Hoyston', 'Winchester'); 

Insert Into Vehicle(VehReg, VehMake, VehModel) Values ('GY39 YIF', 'Ford', 'Focus'), ('DY38 HJN', 'Vauxhall', 'Corsa'), ('DN34 UHS', 'Ford', 'Galaxy'), ('HS38 UDF', 'Nissan', 'Pretel'), ('DG73 HFA', 'Fiat', 'Panda'), ('RD29 DIY', 'Nissan', 'Prudence'), ('FR74 USD', 'Ford', 'Pocahontas'), ('RY98 WGS', 'Vauxhall', 'Pria');

Insert Into Engineer(engID, EFName, ELName) Values (286, 'Lewis', 'Manis'), (338, 'Frank', 'Diamin'), (483, 'Terry', 'Figs');

Insert Into EngVan(VanReg, VanMake, VanModel, VMileage) Values ('TK39 IOR', 'Ford', 'Maxi', 26047), ('DF72 AWO', 'Vauxhall', 'Prefect', 35784), ('YI32 EQC', 'Nissan', 'Woofman', 52127), ('DC12 UVZ', 'Talbot', 'Waiter', 17834), ('DM39 QET', 'Fiat', 'Noona', 8923);

Insert Into Breakdown(BDID, VehReg, VanReg, BDDate, BDTime, BDLocation) Values
(358, 'FR74 USD', 'DF72 AWO', '2022-03-21', '20:15:23', 'Chatham'), 
(289, 'RD29 DIY', 'DC12 UVZ', '2021-07-13', '07:29:56', 'Gloucester'), 
(683, 'DG73 HFA', 'TK39 IOR', '2019-08-28', '17:10:28', 'Reading'), 
(521, 'DY38 HJN', 'YI32 EQC', '2020-02-09', '21:12:33', 'Nottingham'), 
(892, 'GY39 YIF', 'YI32 EQC', '2018-09-18', '09:56:02', 'Coventry'), 
(347, 'FR74 USD', 'DC12 UVZ', '2021-01-14', '14:48:41', 'Leeds'), 
(209, 'RD29 DIY', 'DM39 QET', '2021-07-27', '11:32:52', 'Reading'), 
(590, 'RY98 WGS', 'TK39 IOR', '2017-11-23', '20:15:43', 'Tonbridge'), 
(279, 'DY38 HJN', 'DF72 AWO', '2021-07-13', '20:15:52', 'Worthing'), 
(744, 'HS38 UDF', 'YI32 EQC', '2020-10-29', '20:15:59', 'Exeter'), 
(935, 'DN34 UHS', 'DM39 QET', '2018-08-11', '20:15:38', 'London'), 
(481, 'FR74 USD', 'TK39 IOR', '2019-05-28', '20:15:23', 'Wigan');


-- Task 3 - Perform Queries

Select MFName, MLName, MLocation From Member Where MLocation = 'Southampton'; 

Select VehReg, VehMake, VehModel From Vehicle Where VehMake = 'Ford'; 

Select Count(engID) From Engineer;

Select Count(memberID) From Member;

-- Query to return any breakdowns after 1st January 2021
Select BDID, VehReg, VanReg, BDDate, BDTime, BDLocation From Breakdown Where BDDate > '2021:01:01';

-- Query to return all breakdowns between 1st and 31st July 2021
 Select BDID, VehReg, VanReg, BDDate, BDTime, BDLocation From Breakdown Where BDDate >= '2021:07:01' And BDDate <= '2021:07:31';
 
 Select Count(vehReg) From Breakdown Where vehReg = 'FR74 USD';

Select vehReg, Count(*) From Breakdown Group By vehReg Having Count(*) > 1;


-- Task 4 - Create New Table

Create Table MshipType(MemTypeID Int Primary Key, MemType Varchar(6), MemPrice Decimal(4,2));

Insert Into MshipType(MemTypeID, MemType, MemPrice) Values (1, 'Gold', 99.99), (2, 'Silver', 59.99), (3, 'Bronze', 39.99);


-- Task 5 - Alter/Update Table

Alter Table Vehicle Add MemTypeID Int;
Alter Table Vehicle Add Foreign Key(MemTypeID) References MshipType(MemTypeID);

Update Vehicle Set MemTypeID = 1 Where VehReg = 'GY39 YIF';
Update Vehicle Set MemTypeID = 3 Where VehReg = 'DY38 HJN';
Update Vehicle Set MemTypeID = 2 Where VehReg = 'DN34 UHS';
Update Vehicle Set MemTypeID = 3 Where VehReg = 'HS38 UDF';
Update Vehicle Set MemTypeID = 2 Where VehReg = 'DG73 HFA';
Update Vehicle Set MemTypeID = 1 Where VehReg = 'RD29 DIY';
Update Vehicle Set MemTypeID = 1 Where VehReg = 'FR74 USD';
Update Vehicle Set MemTypeID = 3 Where VehReg = 'RY98 WGS';


-- Task 6 - Further Queries

Update Vehicle Set memberID = 'J2829' Where VehReg = 'GY39 YIF';
Update Vehicle Set memberID = 'J2829' Where VehReg = 'FR74 USD';

Update Vehicle Set memberID = 'D3868' Where VehReg = 'DY38 HJN';
Update Vehicle Set memberID = 'D3868' Where VehReg = 'DG73 HFA';

Update Vehicle Set memberID = 'B2965' Where VehReg = 'DN34 UHS';
Update Vehicle Set memberID = 'B2965' Where VehReg = 'RY98 WGS';

Update Vehicle Set memberID = 'U2938' Where VehReg = 'HS38 UDF';

Update Vehicle Set memberID = 'I2958' Where VehReg = 'RD29 DIY';


Select VehReg As Rebert_Lemin_Vehicles From Vehicle Where memberID = 'B2965';  -- All the vehicles a member owns - Rebert Lemin from Southampton (memberID: B2965)

Select memberID, Count(*) As memberNumOfVehicles From Vehicle Group By memberID Order By memberNumOfVehicles Desc; -- Number of vehicles held by each member in descending order

Update EngVan Set engID = '338' Where VanReg = 'DF72 AWO';
Update EngVan Set engID = '286' Where VanReg = 'DM39 QET';
Update EngVan Set engID = '483' Where VanReg = 'TK39 IOR';
Update EngVan Set engID = '338' Where VanReg = 'YI32 EQC';
Update EngVan Set engID = '483' Where VanReg = 'DC12 UVZ';

Select engID, Count(*) As terryFigsNumOfVans From EngVan Where engID = '483'; -- Number of vans driven by a particular engineer: Terry Figs (engID 483)

Select Breakdown.BDID, Breakdown.BDLocation, Breakdown.VehReg, Vehicle.memberID, Member.MFName, Member.MLName, Member.MLocation
From ( (Breakdown
Inner Join Vehicle On Breakdown.VehReg = Vehicle.VehReg) Inner Join Member On Vehicle.memberID = Member.memberID)
Where Breakdown.BDLocation = 'Reading'; -- Vehicles which have broken down in a particular location (Reading) with member details

Select Breakdown.BDID, Breakdown.BDLocation, Breakdown.VehReg, Vehicle.memberID, Member.MFName, Member.MLName, Member.MLocation, Breakdown.VanReg, EngVan.engID, Engineer.EFName, Engineer.ELName
From Breakdown 
Inner Join EngVan On Breakdown.VanReg = EngVan.VanReg 
Inner Join Engineer On EngVan.engID = Engineer.engID
Inner Join Vehicle On Breakdown.VehReg = Vehicle.VehReg 
Inner Join Member On Vehicle.memberID = Member.memberID; -- All Vehicles which have broken down with member details and engineer who attended

Select Breakdown.BDID, Breakdown.BDLocation, Breakdown.BDDate, Breakdown.VehReg, Vehicle.memberID, Member.MFName, Member.MLName, Member.MLocation, Breakdown.VanReg, EngVan.engID, Engineer.EFName, Engineer.ELName
From Breakdown 
Inner Join EngVan On Breakdown.VanReg = EngVan.VanReg 
Inner Join Engineer On EngVan.engID = Engineer.engID
Inner Join Vehicle On Breakdown.VehReg = Vehicle.VehReg 
Inner Join Member On Vehicle.memberID = Member.memberID
Where  Breakdown.BDDate >= '2020:01:01' And Breakdown.BDDate <= '2022:12:31'; -- All Vehicles which have broken down with member details and engineer details between 2 Dates: From the start of 2020 to the end of 2022

-- A further 3 queries which are meaningful to the company

Select Vehicle.VehMake, Vehicle.VehModel, Breakdown.VehReg, Breakdown.BDID, Breakdown.BDDate, Breakdown.BDTime, Breakdown.BDLocation
From Breakdown 
Left Join Vehicle 
On Breakdown.VehReg = Vehicle.VehReg
Order By Vehicle.VehReg;

Select MshipType.MemTypeID, MshipType.MemType, MshipType.MemPrice, Vehicle.VehReg, Vehicle.VehMake, Vehicle.VehModel
From Vehicle
Right Join MshipType 
On Vehicle.MemTypeID = MshipType.MemTypeID
Order By Vehicle.VehReg;

Select MLocation As All_Locations, memberID As Member_Or_Breakdown From Member
Union
Select BDLocation, VehReg From Breakdown;


-- Task 7 - Explore functions with examples on a different database

Create Database By_Numbers;
Use By_Numbers;
Create Table Counties(countyID Int Auto_Increment Primary Key, countyName Varchar(20), population Int);

Insert Into Counties(countyName, population) Values ('Hampshire', 247941), ('Kent', 573828), ('Lincolnshire', 189375), ('Staffordshire', 492837), ('Dorset', 139282), ('Cheshire', 388292), ('Merseyside', 633834), ('Greater London', 739378), ('Northumberland', 89393), ('Devon', 118328);

Select Avg(population) As averagePopulation From Counties; -- Avg Method

Select Max(population) As highestPopulation From Counties; -- Max Method

Select Min(population) As lowestPopulation From Counties; -- Min Method

Select Sum(population) As aggregatePopulation From Counties; -- Sum Method


-- Task 8 - Setting conditions for: 

-- Whether a member has more than one company vehicle. If they do, give them a multicar policy. 

Select memberID,
	If (Count(memberID) >= 2, 'MultiCar Policy', 'Single Car Policy') as 'Policy Type'
From Vehicle Group By memberID;


-- How many times a vehicle has broken down with premium increase or discount applied accordingly

Insert Into Vehicle(VehReg, VehMake, VehModel) Values ('QS80 ALF', 'Honda', 'Soprano');

Select Vehicle.VehReg, Count(Breakdown.BDID) As 'Breakdown Count',
Case
	When Count(Breakdown.BDID) > 2 Then 'Premium increase by 10%'
    When Count(Breakdown.BDID) = 2 Then 'Premium increase by 5%'
    When Count(Breakdown.BDID) = 1 Then 'No increase'
    Else '10% Discount' -- See Dialog Below
End As 'Premium Increase / Discount'
From Vehicle
Left Join Breakdown On Vehicle.VehReg = Breakdown.VehReg
Group By Vehicle.VehReg;


-- END
