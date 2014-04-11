CREATE TABLE Sharer (
	Password VARCHAR(15) NOT NULL,
	Userid SERIAL NOT NULL,
	Username VARCHAR(20) NOT NULL,
	Email VARCHAR(35) NOT NULL,
	PicURL VARCHAR(256), -- Not sure what the data type should be
	Description VARCHAR(256), -- Not sure what this is either
	PRIMARY KEY (Userid,Username,Email)
);
