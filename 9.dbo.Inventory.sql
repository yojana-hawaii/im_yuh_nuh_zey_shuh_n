
create table dbo.Inventory(
LotNumber_ID nvarchar(255) not null,
TotalPurchased int null,
TotalUsed int null,
Remaining int null,
WarningLevel int null,
)

/* Probably need multiple table 

- lotNumber_ID from VaccineLotNumber table
- hospital  purchased vaccine with that lot number and there was 500 vaccines
- hospital can have 1 or more building. this exampel we have 3
- buiding 1 got 100 of 500 vaccines, building 2 got 150 and building 3 got 250
- track how many vaccines used in each building and entire hospital
- track how many vaccines remaining in each building and entire hospital
- if building 1 has 0 vaccine and building 3 has 100 remaining, building 3 can transfer 50 vaccines > track this

- warning option 1 > hospital can set warning level
	- if building 1 has less that 10 flu vaccine then warning
	- if building 2 has less that 2 hep B vaccine then warning > maybe flu is used more than hep b so different warning level
	- warning for company as a whole > less than 30 flu vaccine in all building then warning

- warning option 2 > look at historic consumption and figure out when to warn


 */