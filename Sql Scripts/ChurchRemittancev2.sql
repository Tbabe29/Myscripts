Create Database ChurchRemittancev2
Go
Use ChurchRemittancev2

CREATE TABLE Section
(
SectionId int NOT NULL IDENTITY(1,1) Primary key,
Orders tinyint NOT NULL,
Label char(1) NOT NULL,
Title varchar(100) NOT NULL,
TotalAmount smallmoney Not Null 
Default 0,
Descriptions varchar(100) NULL,
IsActive bit NOT NULL
)
----------------------
CREATE TABLE DestinationGroup
(
DestinationGroupId int NOT NULL IDENTITY(1,1)  PRIMARY KEY,
GroupName varchar(100) NOT NULL
)
----------------
CREATE TABLE Destination
(
DestinationId int NOT NULL IDENTITY(1,1)  PRIMARY KEY,
DestinationName varchar(100) NOT NULL,
Descriptions varchar(100) NULL,
DestinationGroupId int NULL
)

ALTER TABLE Destination   
ADD  CONSTRAINT FkGroup 
FOREIGN KEY (DestinationGroupId)
REFERENCES DestinationGroup (DestinationGroupId)
---------------
CREATE TABLE SubSection
(
SubSectionId int NOT NULL IDENTITY(1,1)  PRIMARY KEY,
Orders tinyint NOT NULL,
Label varchar(5) NOT NULL,
Percentage decimal(4, 1) NOT NULL,
DestinationId int NOT NULL,
SectionId int NOT NULL
)

ALTER TABLE SubSection   
ADD  CONSTRAINT FkDestination 
FOREIGN KEY (DestinationId)
REFERENCES Destination (DestinationId)

ALTER TABLE SubSection   
ADD  CONSTRAINT FkSection 
FOREIGN KEY (SectionId)
REFERENCES Section (SectionId)
---------------Stored Procedures--------------
Create Proc InsSection
@Orders tinyint,
@Label char(1),
@Title varchar(100),
@TotalAmount smallmoney = 0,
@Descriptions varchar(100) = NULL,
@IsActive bit
As
Insert Into Section
(Orders,Label,Title,TotalAmount,Descriptions,IsActive)
Values
(@Orders,@Label,@Title,@TotalAmount,@Descriptions,@IsActive)

Select * from Section
-------------------------
Create Proc InsDestinationGroup
@GroupName varchar(100)
As
Insert Into DestinationGroup
(GroupName)
Values
(@GroupName)

Select * from DestinationGroup
--------------------
Create Proc InsDestination
@DestinationName varchar(100),
@Descriptions varchar(100) = NULL,
@DestinationGroupName varchar(100) = Null
As
Declare @DestinationGroupId Int
Select @DestinationGroupId = DestinationGroupId From DestinationGroup where GroupName = @DestinationGroupName
Insert Into Destination
(DestinationName,Descriptions,DestinationGroupId)
Values
(@DestinationName,@Descriptions,@DestinationGroupId)

Select * from Destination
----------------------------
Create Proc InsSubSection
@Orders tinyint,
@Label varchar(5),
@Percentage decimal(4, 1),
@DestinationName varchar(100),
@Title varchar(100)
As
Declare @DestinationId Int,@SectionId Int
Select @DestinationId = DestinationId From Destination where DestinationName = @DestinationName
Select @SectionId = SectionId From Section where Title = @Title
Insert Into SubSection
(Orders,Label,Percentage,DestinationId,SectionId)
Values
(@Orders,@Label,@Percentage,@DestinationId,@SectionId)

Select * from SubSection
--------Insert Section---------
/*Order is a numbering system to order, 
Label is the A,B, C on the form to group the sections broadly, 
Title is the title of the Label e.g Sunday love offering,CRM offering
Note - I think i am supposed to insert all fields living Totalamount to  
updated later alone using another stored procedure*/
------------------
Exec InsSection
@Orders = 1,
@Label = 'A',
@Title = 'Other Tithe Disbursement(Congregation)',
@TotalAmount = 0,
@IsActive = 1

Exec InsSection
@Orders = 2,
@Label = 'B',
@Title = 'Minister''s Tithe',
@TotalAmount = 0,
@IsActive = 1

Exec InsSection
@Orders = 3,
@Label = 'C',
@Title = 'Continental Tithe(Northern Region)',
@TotalAmount = 0,
@IsActive = 1

Exec InsSection
@Orders = 4,
@Label = 'D',
@Title = 'Sunday Love Offering(All Sunday)',
@TotalAmount = 0,
@IsActive = 1

Exec InsSection
@Orders = 5,
@Label = 'E',
@Title = 'Thankgiving Offering',
@TotalAmount = 0,
@IsActive = 1

Exec InsSection
@Orders = 6,
@Label = 'F',
@Title = 'CRM Offering',
@TotalAmount = 0,
@IsActive = 1

Exec InsSection
@Orders = 7,
@Label = 'G',
@Title = 'Junior Church',
@TotalAmount = 0,
@IsActive = 1

Exec InsSection
@Orders = 8,
@Label = 'H',
@Title = 'First Fruit Of Increase',
@TotalAmount = 0,
@IsActive = 1

Exec InsSection
@Orders = 9,
@Label = 'I',
@Title = 'Redemption Of First Born',
@TotalAmount = 0,
@IsActive = 1

Exec InsSection
@Orders = 10,
@Label = 'J',
@Title = 'House Fellowship',
@TotalAmount = 0,
@IsActive = 1

Exec InsSection
@Orders = 11,
@Label = 'K',
@Title = 'Province Foreign Mission',
@TotalAmount = 0,
@IsActive = 1

Exec InsSection
@Orders = 12,
@Label = 'L',
@Title = 'Sunday School Offering',
@TotalAmount = 0,
@IsActive = 1

Exec InsSection
@Orders = 13,
@Label = 'M',
@Title = 'Gospel Fund',
@TotalAmount = 0,
@IsActive = 1

Exec InsSection
@Orders = 14,
@Label = 'N',
@Title = 'National Weekend',
@TotalAmount = 0,
@IsActive = 1

Exec InsSection
@Orders = 15,
@Label = 'O',
@Title = 'Pastor''s Welfare',
@TotalAmount = 0,
@IsActive = 1

Exec InsSection
@Orders = 16,
@Label = 'P',
@Title = 'Csr/Run/Wz/Rc',
@TotalAmount = 0,
@IsActive = 1
--------------Insert DestinationGroup-----------------
--These are the subs(i,ii,iii) under all the sections

Exec InsDestinationGroup
@GroupName = 'National Headquaters'

Exec InsDestinationGroup
@GroupName = 'Regional Headquaters'

Exec InsDestinationGroup
@GroupName = 'Province Office'

Exec InsDestinationGroup
@GroupName = 'Pastor''s Welfare'

Exec InsDestinationGroup
@GroupName = 'G.o Office (First Fruit 90%)'

Exec InsDestinationGroup
@GroupName = 'Remittance To Zone'

Exec InsDestinationGroup
@GroupName = 'Remittance To Area'

Exec InsDestinationGroup
@GroupName = 'Remittance To Parish'

Exec InsDestinationGroup
@GroupName = 'Csr/Run/Wz/Rc'
-----------Insert Destination-------------
Exec InsDestination
@DestinationName = 'TotalAmount'

Exec InsDestination
@DestinationName = 'National Headquaters',
@DestinationGroupName  = 'National Headquaters'

Exec InsDestination
@DestinationName = 'Regional Headquaters',
@DestinationGroupName  = 'Regional Headquaters'

Exec InsDestination
@DestinationName = 'Province Headquaters',
@DestinationGroupName  = 'Province Office'

Exec InsDestination
@DestinationName = 'Zonal Headquaters',
@DestinationGroupName  = 'Remittance To Zone'

Exec InsDestination
@DestinationName = 'Area Headquaters',
@DestinationGroupName  = 'Remittance To Area'

Exec InsDestination
@DestinationName = 'Province joint church planting',
@DestinationGroupName  = 'Province Office'

Exec InsDestination
@DestinationName = 'Retained by parish',
@DestinationGroupName  = 'Remittance To Parish'

Exec InsDestination
@DestinationName = 'Province office',
@DestinationGroupName  = 'Province Office'

Exec InsDestination
@DestinationName = 'Area office',
@DestinationGroupName  = 'Remittance To Area'

Exec InsDestination
@DestinationName = 'Province pastor',
@DestinationGroupName  = 'Province Office'

Exec InsDestination
@DestinationName = 'Area pastor',
@DestinationGroupName  = 'Remittance To Area'

Exec InsDestination
@DestinationName = 'Pastor''s seed',
@DestinationGroupName  = 'Province Office'

Exec InsDestination
@DestinationName = 'Retained by minister',
@DestinationGroupName  = 'Remittance To Parish'

Exec InsDestination
@DestinationName = 'Province coordination',
@DestinationGroupName  = 'Province Office'

Exec InsDestination
@DestinationName = 'Province Foreign Mission',
@DestinationGroupName  = 'Province Office'

Exec InsDestination
@DestinationName = 'Office of the G.o',
@DestinationGroupName  = 'National Headquaters'

Exec InsDestination
@DestinationName = 'Redemption of First Born',
@DestinationGroupName  = 'National Headquaters'

Exec InsDestination
@DestinationName = 'Pastor in charge',
@DestinationGroupName  = 'National Headquaters'

Exec InsDestination
@DestinationName = 'National Weekend',
@DestinationGroupName  = 'National Headquaters'

Exec InsDestination
@DestinationName = 'Housefellowship center'

Exec InsDestination
@DestinationName = 'Pastor''s Welfare',
@DestinationGroupName  = 'Pastor''s Welfare'

Exec InsDestination
@DestinationName = 'Csr/Run/Wz/Rc',
@DestinationGroupName  = 'Csr/Run/Wz/Rc'

---------------Insert Subsection------------------
Exec InsSubSection
@Orders = 1,
@Label = 'i',
@Percentage = 100,
@DestinationName = 'TotalAmount',
@Title = 'Other Tithe Disbursement(Congregation)'

Exec InsSubSection
@Orders = 2,
@Label = 'ii',
@Percentage = 26,
@DestinationName = 'National Headquaters',
@Title = 'Other Tithe Disbursement(Congregation)'

Exec InsSubSection
@Orders = 3,
@Label = 'ii',
@Percentage = 3,
@DestinationName = 'Regional Headquaters',
@Title = 'Other Tithe Disbursement(Congregation)'

Exec InsSubSection
@Orders = 4,
@Label = 'iv',
@Percentage = 31,
@DestinationName = 'Province Headquaters',
@Title = 'Other Tithe Disbursement(Congregation)'

Exec InsSubSection
@Orders = 5,
@Label = 'v',
@Percentage = 2,
@DestinationName = 'Zonal Headquaters',
@Title = 'Other Tithe Disbursement(Congregation)'

Exec InsSubSection
@Orders = 6,
@Label = 'vi',
@Percentage = 2,
@DestinationName = 'Area Headquaters',
@Title = 'Other Tithe Disbursement(Congregation)'

Exec InsSubSection
@Orders = 7,
@Label = 'vii',
@Percentage = 7.2,
@DestinationName = 'Province joint church planting',
@Title = 'Other Tithe Disbursement(Congregation)'

Exec InsSubSection
@Orders = 8,
@Label = 'viii',
@Percentage = 28.8,
@DestinationName = 'Retained by parish',
@Title = 'Other Tithe Disbursement(Congregation)'

--End of section A

Exec InsSubSection
@Orders = 1,
@Label = 'i',
@Percentage = 100,
@DestinationName = 'TotalAmount',
@Title = 'Minister''s Tithe'

Exec InsSubSection
@Orders = 2,
@Label = 'ii',
@Percentage = 52,
@DestinationName = 'National Headquaters',
@Title = 'Minister''s Tithe'

Exec InsSubSection
@Orders = 3,
@Label = 'iii',
@Percentage = 2,
@DestinationName = 'Regional Headquaters',
@Title = 'Minister''s Tithe'

Exec InsSubSection
@Orders = 4,
@Label = 'vi',
@Percentage = 10,
@DestinationName = 'Province Headquaters',
@Title = 'Minister''s Tithe'

Exec InsSubSection
@Orders = 5,
@Label = 'v',
@Percentage = 7.2,
@DestinationName = 'Province joint church planting',
@Title = 'Minister''s Tithe'

Exec InsSubSection
@Orders = 6,
@Label = 'vi',
@Percentage = 28.8,
@DestinationName = 'Retained by parish',
@Title = 'Minister''s Tithe'

--End of Section B
Exec InsSubSection
@Orders = 1,
@Label = 'i',
@Percentage = 100,
@DestinationName = 'TotalAmount',
@Title = 'Continental Tithe(Northern Region)'

Exec InsSubSection
@Orders = 2,
@Label = 'ii',
@Percentage = 100,
@DestinationName = 'Regional Headquaters',
@Title = 'Continental Tithe(Northern Region)'

--End of section C 

Exec InsSubSection
@Orders = 1,
@Label = 'i',
@Percentage = 100,
@DestinationName = 'TotalAmount',
@Title = 'Sunday Love Offering(All Sunday)'

Exec InsSubSection
@Orders = 2,
@Label = 'ii',
@Percentage = 10,
@DestinationName = 'National Headquaters',
@Title = 'Sunday Love Offering(All Sunday)'

Exec InsSubSection
@Orders = 3,
@Label = 'iii',
@Percentage = 20,
@DestinationName = 'Province office',
@Title = 'Sunday Love Offering(All Sunday)'

Exec InsSubSection
@Orders = 4,
@Label = 'vi',
@Percentage = 20,
@DestinationName = 'Area office',
@Title = 'Sunday Love Offering(All Sunday)'

Exec InsSubSection
@Orders = 5,
@Label = 'v',
@Percentage = 50,
@DestinationName = 'Retained by parish',
@Title = 'Sunday Love Offering(All Sunday)'

--End of Section D

Exec InsSubSection
@Orders = 1,
@Label = 'i',
@Percentage = 100,
@DestinationName = 'TotalAmount',
@Title = 'Thankgiving Offering'

Exec InsSubSection
@Orders = 2,
@Label = 'ii',
@Percentage = 70,
@DestinationName = 'National Headquaters',
@Title = 'Thankgiving Offering'

Exec InsSubSection
@Orders = 3,
@Label = 'iii',
@Percentage = 5,
@DestinationName = 'Province Pastor',
@Title = 'Thankgiving Offering'

Exec InsSubSection
@Orders = 4,
@Label = 'vi',
@Percentage = 5,
@DestinationName = 'Area Pastor',
@Title = 'Thankgiving Offering'

Exec InsSubSection
@Orders = 5,
@Label = 'v',
@Percentage = 1,
@DestinationName = 'Pastor''s Seed',
@Title = 'Thankgiving Offering'

Exec InsSubSection
@Orders = 6,
@Label = 'vi',
@Percentage = 19,
@DestinationName = 'Retained by minister',
@Title = 'Thankgiving Offering'

---End of Section E

Exec InsSubSection
@Orders = 1,
@Label = 'i',
@Percentage = 100,
@DestinationName = 'TotalAmount',
@Title = 'CRM Offering'

Exec InsSubSection
@Orders = 2,
@Label = 'ii',
@Percentage = 50,
@DestinationName = 'National Headquaters',
@Title = 'CRM Offering'

Exec InsSubSection
@Orders = 3,
@Label = 'iii',
@Percentage = 25,
@DestinationName = 'Province office',
@Title = 'CRM Offering'

Exec InsSubSection
@Orders = 4,
@Label = 'vi',
@Percentage = 10,
@DestinationName = 'Area Office',
@Title = 'CRM Offering'

Exec InsSubSection
@Orders = 5,
@Label = 'v',
@Percentage = 15,
@DestinationName = 'Retained by Parish',
@Title = 'CRM Offering'

--End of Section F

Exec InsSubSection
@Orders = 1,
@Label = 'i',
@Percentage = 100,
@DestinationName = 'TotalAmount',
@Title = 'Junior Church'

Exec InsSubSection
@Orders = 2,
@Label = 'ii',
@Percentage = 10,
@DestinationName = 'National Headquaters',
@Title = 'Junior Church'

Exec InsSubSection
@Orders = 3,
@Label = 'iii',
@Percentage = 5,
@DestinationName = 'Regional Headquaters',
@Title = 'Junior Church'

Exec InsSubSection
@Orders = 4,
@Label = 'vi',
@Percentage = 20,
@DestinationName = 'Province coordination',
@Title = 'Junior Church'

Exec InsSubSection
@Orders = 5,
@Label = 'v',
@Percentage = 65,
@DestinationName = 'Retained by Parish',
@Title = 'Junior Church'

--End of Section G
Exec InsSubSection
@Orders = 1,
@Label = 'i',
@Percentage = 100,
@DestinationName = 'TotalAmount',
@Title = 'First Fruit Of Increase'

Exec InsSubSection
@Orders = 2,
@Label = 'ii',
@Percentage = 90,
@DestinationName = 'Office of the G.o',
@Title = 'First Fruit Of Increase'

Exec InsSubSection
@Orders = 3,
@Label = 'iii',
@Percentage = 5,
@DestinationName = 'Pastor in charge',
@Title = 'First Fruit Of Increase'

Exec InsSubSection
@Orders = 4,
@Label = 'vi',
@Percentage = 5,
@DestinationName = 'Retained by Parish',
@Title = 'First Fruit Of Increase'

--End of section H

Exec InsSubSection
@Orders = 1,
@Label = 'i',
@Percentage = 100,
@DestinationName = 'TotalAmount',
@Title = 'Redemption Of First Born'

Exec InsSubSection
@Orders = 1,
@Label = 'ii',
@Percentage = 100,
@DestinationName = 'National Headquaters',
@Title = 'Redemption Of First Born'

--End of section I
----------------------------
Exec InsSubSection
@Orders = 1,
@Label = 'i',
@Percentage = 100,
@DestinationName = 'TotalAmount',
@Title = 'House Fellowship'

Exec InsSubSection
@Orders = 2,
@Label = 'ii',
@Percentage = 10,
@DestinationName = 'National Headquaters',
@Title = 'House Fellowship'

Exec InsSubSection
@Orders = 3,
@Label = 'iii',
@Percentage = 10,
@DestinationName = 'Province Headquaters',
@Title = 'House Fellowship'

Exec InsSubSection
@Orders = 4,
@Label = 'vi',
@Percentage = 10,
@DestinationName = 'Area Office',
@Title = 'House Fellowship'

Exec InsSubSection
@Orders = 5,
@Label = 'v',
@Percentage = 20,
@DestinationName = 'Retained by parish',
@Title = 'House Fellowship'

Exec InsSubSection
@Orders = 4,
@Label = 'vi',
@Percentage = 50,
@DestinationName = 'HouseFellowship Center',
@Title = 'House Fellowship'

--End Of Section J

Exec InsSubSection
@Orders = 1,
@Label = 'i',
@Percentage = 100,
@DestinationName = 'TotalAmount',
@Title = 'Province Foreign Mission'

Exec InsSubSection
@Orders = 1,
@Label = 'ii',
@Percentage = 100,
@DestinationName = 'Province Headquaters',
@Title = 'Province Foreign Mission'
--End of section K
----------------------------
Exec InsSubSection
@Orders = 1,
@Label = 'i',
@Percentage = 100,
@DestinationName = 'TotalAmount',
@Title = 'Sunday School Offering'

Exec InsSubSection
@Orders = 2,
@Label = 'ii',
@Percentage = 50,
@DestinationName = 'National Headquaters',
@Title = 'Sunday School Offering'

Exec InsSubSection
@Orders = 3,
@Label = 'iii',
@Percentage = 10,
@DestinationName = 'Regional Headquaters',
@Title = 'Sunday School Offering'

Exec InsSubSection
@Orders = 4,
@Label = 'vi',
@Percentage = 20,
@DestinationName = 'Province Headquaters',
@Title = 'Sunday School Offering'

Exec InsSubSection
@Orders = 5,
@Label = 'v',
@Percentage = 20,
@DestinationName = 'Retained by parish',
@Title = 'Sunday School Offering'

--End of Section L

Exec InsSubSection
@Orders = 1,
@Label = 'i',
@Percentage = 100,
@DestinationName = 'TotalAmount',
@Title = 'Gospel Fund'

Exec InsSubSection
@Orders = 2,
@Label = 'ii',
@Percentage = 25,
@DestinationName = 'National Headquaters',
@Title = 'Gospel Fund'

Exec InsSubSection
@Orders = 3,
@Label = 'iii',
@Percentage = 75,
@DestinationName = 'Retained by Parish',
@Title = 'Gospel Fund'

--End of Section M

Exec InsSubSection
@Orders = 1,
@Label = 'i',
@Percentage = 100,
@DestinationName = 'TotalAmount',
@Title = 'National Weekend'

Exec InsSubSection
@Orders = 1,
@Label = 'i',
@Percentage = 100,
@DestinationName = 'National Headquaters',
@Title = 'National Weekend'

--End of Section N

Exec InsSubSection
@Orders = 1,
@Label = 'i',
@Percentage = 100,
@DestinationName = 'TotalAmount',
@Title = 'Pastor''s Welfare'

Exec InsSubSection
@Orders = 1,
@Label = 'ii',
@Percentage = 100,
@DestinationName = 'Pastor''s Welfare',
@Title = 'Pastor''s Welfare'

--End Of Section O

Exec InsSubSection
@Orders = 1,
@Label = 'i',
@Percentage = 100,
@DestinationName = 'TotalAmount',
@Title = 'Csr/Run/Wz/Rc'

Exec InsSubSection
@Orders = 1,
@Label = 'ii',
@Percentage = 100,
@DestinationName = 'Csr/Run/Wz/Rc',
@Title = 'Csr/Run/Wz/Rc'

--End Of Section P
---------------------------All My Stored Procedures----------------------------------
--Stored procedure for selects---
--This is for update of congregationTithe
Create Proc InsCongregationTithe
As
Begin
Declare @OtherTithe smallmoney,@MinTithe smallmoney
Select @OtherTithe = (0.01 * TotalAmount) from section where Label = 'A'
Select @MinTithe = (0.01 * TotalAmount) from section where Label = 'B'

Update Section 
Set TotalAmount = @OtherTithe+@MinTithe  where  Label = 'C'
End
--Stored procedure for selects---
-----------------------------------------------------
CREATE Proc GenerateRemittanceDetail
As
Select S.Title,S.Label,S.TotalAmount,D.DestinationName,Sb.Percentage,((S.TotalAmount/100) * Sb.Percentage) As figure
From Section S
Join Subsection Sb
On S.SectionId = Sb.SectionId
Join Destination D
On Sb.DestinationId = D.DestinationId
where S.IsActive = 1
Group by S.Label,S.Title,S.TotalAmount,D.DestinationName,Sb.Percentage
------------------------
Create Proc GenerateRemittanceSummary
As
Select GroupName,Sum(figure) As Lastfig
From
(Select S.Title,S.Label,S.TotalAmount,D.DestinationName,Dg.GroupName,Sb.Percentage,((S.TotalAmount/100) * Sb.Percentage) As figure
From Section S
Join Subsection Sb
On S.SectionId = Sb.SectionId
Join Destination D
On Sb.DestinationId = D.DestinationId
Join DestinationGroup Dg
On D.DestinationGroupId = Dg.DestinationGroupId
where S.IsActive = 1
Group by S.Label,S.Title,S.TotalAmount,D.DestinationName,Dg.GroupName,Sb.Percentage)xx
Group by GroupName
--------------------------------
-----This is for  the grand total addition
Create Proc GenerateRemittanceGrandTotal
As
select Sum(Lastfig) As TotalSum
from
(Select GroupName,Sum(figure) As Lastfig
From
(Select S.Title,S.Label,S.TotalAmount,D.DestinationName,Dg.GroupName,Sb.Percentage,((S.TotalAmount/100) * Sb.Percentage) As figure
From Section S
Join Subsection Sb
On S.SectionId = Sb.SectionId
Join Destination D
On Sb.DestinationId = D.DestinationId
Join DestinationGroup Dg
On D.DestinationGroupId = Dg.DestinationGroupId
where S.IsActive = 1
And Dg.DestinationGroupId in (1,2,3,4,5,6,7,9)
Group by S.Label,S.Title,S.TotalAmount,D.DestinationName,Dg.GroupName,Sb.Percentage)xx
Group by GroupName)yy
--------------------------------
---These 2 Above are used in the update Below to have all the result in one stored procedure.
------------Procedure To Update Section-------------------------
Create Proc UpdateSection
@TotalAmountA Smallmoney,
@TotalAmountB Smallmoney,
@TotalAmountD Smallmoney,
@TotalAmountE Smallmoney,
@TotalAmountF Smallmoney,
@TotalAmountG Smallmoney,
@TotalAmountH Smallmoney,
@TotalAmountI Smallmoney,
@TotalAmountJ Smallmoney,
@TotalAmountK Smallmoney,
@TotalAmountL Smallmoney,
@TotalAmountM Smallmoney,
@TotalAmountN Smallmoney,
@PastorWelfare Smallmoney,
@CsrRunWzRc Smallmoney
As
Begin
Update Section
Set TotalAmount = @TotalAmountA
where Label = 'A'

Update Section
Set TotalAmount = @TotalAmountB
where Label = 'B'

Update Section
Set TotalAmount = @TotalAmountD
where Label = 'D'

Update Section
Set TotalAmount = @TotalAmountE
where Label = 'E'

Update Section
Set TotalAmount = @TotalAmountF
where Label = 'F'

Update Section
Set TotalAmount = @TotalAmountG
where Label = 'G'

Update Section
Set TotalAmount = @TotalAmountH
where Label = 'H'

Update Section
Set TotalAmount = @TotalAmountI
where Label = 'I'

Update Section
Set TotalAmount = @TotalAmountJ
where Label = 'J'

Update Section
Set TotalAmount = @TotalAmountK
where Label = 'K'

Update Section
Set TotalAmount = @TotalAmountL
where Label = 'L'

Update Section
Set TotalAmount = @TotalAmountM
where Label = 'M'

Update Section
Set TotalAmount = @TotalAmountN
where Label = 'N'

Update Section
Set TotalAmount = @PastorWelfare
where Label = 'O'

Update Section
Set TotalAmount = @CsrRunWzRc
where Label = 'P'
End
--These two  are used to get the sub(i,ii etc) and the summary all in one proc
Exec InsCongregationTithe

Exec GenerateRemittanceDetail
Exec GenerateRemittanceSummary
Exec GenerateRemittanceGrandTotal
---End of the update procedure
--------------These 100% only is needed to generate all the values for the remittance sheet front and back----------
-----------We will not put continental tithe since it generate it y itself------------
 Exec UpdateSection
@TotalAmountA = 1500,
@TotalAmountB = 6000,
@TotalAmountD = 7570,
@TotalAmountE = 1200,
@TotalAmountF = 1800,
@TotalAmountG = 300, 
@TotalAmountH = 0,
@TotalAmountI = 0,
@TotalAmountJ = 500,
@TotalAmountK = 100,
@TotalAmountL = 700,
@TotalAmountM = 550,
@TotalAmountN = 0,
@PastorWelfare = 0,
@CsrRunWzRc = 2500
-----------------------------


