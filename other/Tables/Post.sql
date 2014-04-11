CREATE TABLE Post (
	Pid SERIAL NOT NULL,
	Userid SERIAL,
	Username VARCHAR(20),
	Email VARCHAR(35),
	Content VARCHAR(256), -- Not sure about data type
	ShareQuota INT, -- Share Count for Deadline
	Deadline DATE, 
	isPermanent BOOLEAN, -- TRUE if quota is met before Deadline
	Goal INT, -- Goal of number of shares
	ShareCount INT,
	PRIMARY KEY(Pid),
	FOREIGN KEY (Userid,Username,Email)
		REFERENCES Sharer(Userid,Username,Email)
); 
