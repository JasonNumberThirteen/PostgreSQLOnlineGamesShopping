CREATE TABLE UserGenders(
	userGenderID SERIAL PRIMARY KEY,
	name VARCHAR(64) NOT NULL
);

CREATE TABLE GameGenres(
	genreID SERIAL PRIMARY KEY,
	name VARCHAR(128) NOT NULL
);

CREATE TABLE GameSeries(
	serieID SERIAL PRIMARY KEY,
	name VARCHAR(128) NOT NULL
);

CREATE TABLE PaymentMethods(
	paymentMethodID SERIAL PRIMARY KEY,
	name VARCHAR(128) NOT NULL
);

CREATE TABLE GameAgeRatings(
	ageRatingID SERIAL PRIMARY KEY,
	name VARCHAR(64) NOT NULL,
	age SMALLINT NOT NULL
);

CREATE TABLE GameCompanies(
	companyID SERIAL PRIMARY KEY,
	name VARCHAR(128) NOT NULL,
	year SMALLINT NOT NULL
);

CREATE TABLE Users(
	userID SERIAL PRIMARY KEY,
	username VARCHAR(128) NOT NULL,
	name VARCHAR(32) NOT NULL,
	surname VARCHAR(32) NOT NULL,
	mail VARCHAR(255) NOT NULL,
	birthDate DATE,
	genderID INTEGER REFERENCES UserGenders(userGenderID),
	paymentMethodID INTEGER REFERENCES PaymentMethods(paymentMethodID)
);

CREATE TABLE Orders(
	orderID SERIAL PRIMARY KEY,
	userID INTEGER REFERENCES Users(userID),
	orderDate DATE NOT NULL
);

CREATE TABLE Games(
	gameID SERIAL PRIMARY KEY,
	title VARCHAR(255) NOT NULL,
	releaseDate DATE NOT NULL,
	price DECIMAL NOT NULL,
	ageRatingID INTEGER REFERENCES GameAgeRatings(ageRatingID),
	producerID INTEGER REFERENCES GameCompanies(companyID),
	publisherID INTEGER REFERENCES GameCompanies(companyID),
	serieID INTEGER REFERENCES GameSeries(serieID)
);

CREATE TABLE OrdersGames(
	orderGameID SERIAL PRIMARY KEY,
	orderID INTEGER,
	gameID INTEGER,
	
	CONSTRAINT FK_OrdersGames_Order FOREIGN KEY (orderID)
		REFERENCES Orders(orderID),
		
	CONSTRAINT FK_OrdersGames_Game FOREIGN KEY (gameID)
		REFERENCES Games(gameID)
);

CREATE TABLE GamesGenres(
	gameGenreID SERIAL PRIMARY KEY,
	gameID INTEGER,
	genreID INTEGER,
	
	CONSTRAINT FK_GamesGenres_Game FOREIGN KEY (gameID)
		REFERENCES Games(gameID),
		
	CONSTRAINT FK_GamesGenres_Genre FOREIGN KEY (genreID)
		REFERENCES GameGenres(genreID)
);

INSERT INTO UserGenders(name)
VALUES ('Male'), ('Female');

INSERT INTO PaymentMethods(name)
VALUES ('PayPal'), ('Online Transfer');

INSERT INTO GameAgeRatings(name, age)
VALUES ('3+', 3), ('7+', 7), ('12+', 12), ('16+', 16), ('18+', 18);

INSERT INTO GameGenres(name)
VALUES ('Platformer'), ('Puzzle'), ('RPG'), ('Racing'), ('FPS'), ('Adventure'), ('Action'), ('Survival'), ('Horror'), ('Incremental'), ('Strategy'), ('War');

INSERT INTO GameSeries(name)
VALUES ('Batman: Arkham'), ('Half-Life'), ('Battlefield');

INSERT INTO GameCompanies(name, year)
VALUES ('Valve', 1996), ('Rocksteady Studios', 2004), ('Ubisoft', 1986), ('Warner Bros. Interactive Entertainment', 2004), ('Nintendo', 1889), ('Electronic Arts', 1982), ('EA DICE', 1992), ('Sierra Entertainment', 1979);

INSERT INTO Users(username, name, surname, mail, birthDate, genderID, paymentMethodID)
VALUES ('test789', 'User', 'Test', 'test789@gmail.com', '1990-09-20', 1, 2);

INSERT INTO Games(title, releaseDate, price, ageRatingID, producerID, publisherID, serieID)
VALUES ('Batman: Arkham City', '2011-10-18', 19.99, 4, 2, 4, 1), ('Battlefield 1942', '2002-09-11', 59.99, 5, 6, 7, 3), ('Battlefield V', '2018-09-04', 49.99, 5, 6, 7, 3), ('Half-Life', '1998-11-19', 9.99, 5, 1, 8, 2);

INSERT INTO GamesGenres(gameID, genreID)
VALUES (1, 7), (1, 6), (1, 1), (2, 7), (2, 5), (2, 11), (2, 12), (3, 7), (3, 5), (3, 11), (3, 12), (4, 7), (4, 1), (4, 5), (4, 2);

INSERT INTO Orders(userID, orderDate)
VALUES (1, '2023-10-06');

INSERT INTO OrdersGames(orderID, gameID)
VALUES (1, 1), (1, 4);