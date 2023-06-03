USE DemoApp;

CREATE TABLE People (
  Id INT IDENTITY PRIMARY KEY,
  Name NVARCHAR(50) NOT NULL,
  Surname NVARCHAR(50) NOT NULL,
  PhoneNumber NVARCHAR(20),
  Email NVARCHAR(100),
  Age INT,
  Gender NVARCHAR(10),
  HasCitizenship BIT
);

CREATE TABLE Countries (
  Id INT IDENTITY PRIMARY KEY,
  Name NVARCHAR(50) NOT NULL,
  Area DECIMAL(10, 2)
);

CREATE TABLE Cities (
  Id INT IDENTITY PRIMARY KEY,
  Name NVARCHAR(50) NOT NULL,
  Area DECIMAL(10, 2)
);

ALTER TABLE People
ADD CityId INT FOREIGN KEY (CityId) REFERENCES Cities(Id);

INSERT INTO People (Name, Surname, PhoneNumber, Email, Age, Gender, HasCitizenship)
VALUES ('Mark', 'Bruh', '123456789', 'mark.br@example.com', 25, 'Male', 1),
       ('Jack', 'Bruh', '987654321', 'jack.br@example.com', 30, 'Male', 0),
       ('MIke', 'Bruh', '555555555', 'mike.br@example.com', 35, 'Male', 1);

ALTER TABLE Cities
ADD CountryId INT FOREIGN KEY (CountryId) REFERENCES Countries(Id);

INSERT INTO Countries (Name, Area)
VALUES ('United States', 9629091),
       ('Canada', 9976140),
       ('Australia', 7692024);

INSERT INTO Cities (Name, Area, CountryId)
VALUES ('New York', 783.8, 1),
       ('Toronto', 630.2, 2),
       ('Sydney', 2058.0, 3);

SELECT p.Id, p.Name, p.Surname, c.Name AS CountryName, ct.Name AS CityName
FROM People p
JOIN Cities ct ON p.CityId = ct.Id
JOIN Countries c ON ct.CountryId = c.Id;


SELECT * FROM Countries
ORDER BY Area;


SELECT * FROM Cities
ORDER BY Name;

SELECT COUNT(*) AS NumberOfCountries
FROM Countries
WHERE Area > 20000;


SELECT TOP 1 Name, Area
FROM Countries
WHERE Name LIKE 'I%'
ORDER BY Area DESC;
GO

SELECT Name, NULL AS Area
FROM Countries
UNION
SELECT Name, NULL AS Area
FROM Cities;
GO

SELECT ct.Name AS CityName, COUNT(p.Id) AS NumberOfPeople
FROM Cities ct
JOIN People p ON p.CityId = ct.Id
GROUP BY ct.Name;
GO

SELECT ct.Name AS CityName, COUNT(p.Id) AS NumberOfPeople
FROM Cities ct
JOIN People p ON p.CityId = ct.Id
GROUP BY ct.Name
HAVING COUNT(p.Id) > 50000;
GO
