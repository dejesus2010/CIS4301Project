CREATE TABLE Contributions (
	Cid INT NOT NULL AUTO_INCREMENT,
	Content VARCHAR(256), -- Not sure on data type
	PRIMARY KEY (Cid),
	FOREIGN KEY (Email)
		REFERENCES Follower(Email)
	
);