create database Toysgroup; -- creo DB
use Toysgroup; -- Lo uso

-- creo le tabelle

create table Categories (
CategoryId Int Primary key
, CategoryName varchar (50)
);
create table Regions (
RegionID int Primary key
, RegionName varchar (50)
);
create table Products (
ProductID int primary key
, Price decimal (6,2)
, ProductName varchar (50)
, CategoryID int
, Foreign key (CategoryID) references Categories(CategoryID)
);
create table States (
StateID int primary key
, StateName varchar (50)
, RegionID int
, Foreign key (RegionID) references Regions(RegionID)
);
create table Sales (
SalesID int primary key
, OrderDate date
, Quantity int
, StateID int
, ProductID int
, foreign key (StateID) references States(StateID)
, foreign key (ProductID) references Products(ProductID)
);

 -- inserisco valori al loro interno

insert into Categories values (1, "Videogame");
insert into Categories values (2, "Soldatini");
insert into Categories values (3, "Mattoncini");
insert into Categories values (4, "Bambole");
insert into Regions values (1, "Europa");
insert into Regions values (2, "Asia");
insert into Regions values (3, "America");
insert into Regions values (4, "Oceania");
insert into States values (1, "Italia", 1);
insert into States values (2, "Germania", 1);
insert into States values (3, "Francia", 1);
insert into States values (4, "Giappone", 2);
insert into States values (5, "Cina", 2);
insert into States values (6, "Brasile", 3);
insert into States values (7, "Argentina", 3);
insert into States values (8, "USA", 3);
insert into States values (9, "Australia", 4);
insert into Products values (1, 60.00, "Red Dead Redemption 2", 1);
insert into Products values (2, 45.00, "Pokémon Rosso Fuoco", 1);
insert into Products values (3, 15.99, "Set WWII da collezione 1", 2);
insert into Products values (4, 15.99, "Set WWII da collezione 2", 2);
insert into Products values (5, 18.99, "Set WWII da collezione 3", 2);
insert into Products values (6, 78.99, "OGEL Architect - Torre di Pisa", 3);
insert into Products values (7, 48.99, "Play Libom - Draghi e soldati", 3);
insert into Products values (8, 18.99, "Bebè per tutte le età", 4);
insert into Products values (9, 18.99, "Uomo d'azione", 4);
insert into Sales(SalesID, OrderDate, ProductID, StateID, Quantity) values (1, '2018-10-26', 1, 1, 500);
insert into Sales(SalesID, OrderDate, ProductID, StateID, Quantity) values (2, '2024-12-1', 2, 4, 1);
insert into Sales(SalesID, OrderDate, ProductID, StateID, Quantity) values (3, '2023-08-09', 6, 5, 5);
insert into Sales(SalesID, OrderDate, ProductID, StateID, Quantity) values (4, '2023-07-15', 8, 4, 12);
insert into Sales(SalesID, OrderDate, ProductID, StateID, Quantity) values (5, '2023-06-30', 3, 7, 9);
insert into Sales(SalesID, OrderDate, ProductID, StateID, Quantity) values (6, '2023-05-12', 2, 9, 20);
insert into Sales(SalesID, OrderDate, ProductID, StateID, Quantity) values (7, '2023-04-23', 5, 3, 7);
insert into Sales(SalesID, OrderDate, ProductID, StateID, Quantity) values (8, '2023-03-19', 7, 8, 15);
insert into Sales(SalesID, OrderDate, ProductID, StateID, Quantity) values (9, '2023-09-05', 4, 2, 10);
insert into Sales(SalesID, OrderDate, ProductID, StateID, Quantity) values (10, '2023-02-25', 6, 6, 8);
insert into Sales(SalesID, OrderDate, ProductID, StateID, Quantity) values (11, '2023-11-11', 1, 1, 3);
insert into Sales(SalesID, OrderDate, ProductID, StateID, Quantity) values (12, '2023-01-08', 9, 5, 18);
insert into Sales(SalesID, OrderDate, ProductID, StateID, Quantity) values (13, '2023-10-20', 3, 4, 12);
insert into Sales(SalesID, OrderDate, ProductID, StateID, Quantity) values (14, '2023-12-14', 8, 7, 11);
insert into Sales(SalesID, OrderDate, ProductID, StateID, Quantity) values (15, '2023-08-01', 5, 9, 14);
insert into Sales(SalesID, OrderDate, ProductID, StateID, Quantity) values (16, '2023-07-07', 2, 6, 6);
insert into Sales(SalesID, OrderDate, ProductID, StateID, Quantity) values (17, '2023-04-10', 7, 3, 19);
insert into Sales(SalesID, OrderDate, ProductID, StateID, Quantity) values (18, '2023-06-18', 4, 8, 13);
insert into Sales(SalesID, OrderDate, ProductID, StateID, Quantity) values (19, '2023-03-11', 6, 2, 9);
insert into Sales(SalesID, OrderDate, ProductID, StateID, Quantity) values (20, '2023-05-27', 9, 7, 16);
insert into Sales(SalesID, OrderDate, ProductID, StateID, Quantity) values (21, '2023-09-15', 1, 5, 4);
insert into Sales(SalesID, OrderDate, ProductID, StateID, Quantity) values (22, '2023-02-20', 8, 4, 10);
insert into Sales(SalesID, OrderDate, ProductID, StateID, Quantity) values (23, '2023-10-05', 3, 6, 7);
insert into Sales(SalesID, OrderDate, ProductID, StateID, Quantity) values (25, '2023-02-25', 5, 7, 10);

-- Faccio Join per poter verificare il fatturato annuo fra Sales e Products
select p.ProductName, YEAR(s.OrderDate) as SaleYear, SUM(s.Quantity) as Quantity, p.Price, p.Price*SUM(s.Quantity) as TotalSales 
FROM Sales as s LEFT JOIN Products as p ON p.ProductId = s.ProductId 
GROUP BY p.ProductID, YEAR(s.OrderDate) 
ORDER BY YEAR(s.OrderDate), p.ProductID;

-- doppia join perché mi servono istanze di più tabelle
SELECT st.StateName,YEAR(s.OrderDate) AS SaleYear, SUM(p.Price * s.Quantity) AS TotalSales 
FROM Sales AS s INNER JOIN States as st on s.StateID = st.StateID 
INNER JOIN Products AS p ON s.ProductID = p.ProductID
GROUP BY st.StateName, YEAR(s.OrderDate)
ORDER BY SaleYear ASC, TotalSales DESC;

-- Prodotto più richiesto dal mercato?
Select p.ProductName, SUM(s.Quantity) as TotalQuantity
FROM Products as P INNER JOIN Sales as s on p.ProductID = s.ProductID
GROUP BY p.ProductName
order by TotalQuantity DESC;
-- RED DEAD REDEMPTION 2!!!

-- Categoria più richiesta del mercato?
Select c.CategoryName, SUM(s.Quantity) as TotalQuantity
FROM Categories as C Inner join Products as p on C.CategoryID = P.CategoryID
INNER JOIN Sales as s on p.ProductID = s.ProductID
group by c.CategoryName
order by TotalQuantity DESC;
-- I videogiochi sono i più venduti!

-- ultima vendita di un prodotto
Select p.ProductName, MAX(s.OrderDate) as lastSell
From Products as p INNER JOIN sales as s on p.ProductID = s.ProductID
Group by p.ProductName
Order by LastSell Desc;

-- in rifierimento alla domanda 5. :
-- Il DB è stato creato con relazioni, in questo caso per la tabella products, o:n
-- dunque i prodotti invenduti saranno chiaramente presenti nel database, ricercandoli da una query di left join, dove 
-- poi andrò a scoprire i valori NULL intesi come prodotti invenduti.
-- Un altro metodo potrebbe essere creare una regione ed uno stato fantoccio dove andrò a mettere i miei prodotti 
-- invenduti, cosicché li possa ritrovare direttamente facendo riferimento a quello stato o quella regione.







