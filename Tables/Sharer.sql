CREATE TABLE Sharer (
	Password VARCHAR(15) NOT NULL,
	Userid INT NOT NULL AUTO_INCREMENT,
	Username VARCHAR(20),
	Email VARCHAR(35),
	PicURL ..., -- Not sure what the data type should be
	Description VARCHAR(256), -- Not sure what this is either
	PRIMARY KEY (Userid,Username,Email)
);