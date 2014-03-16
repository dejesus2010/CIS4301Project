CREATE TABLE Post (
	Pid INT NOT NULL AUTO_INCREMENT,
	Content VARCHAR(256), -- Not sure about data type
	ShareQuota INT, -- Share Count for Deadline
	Deadline DATE, 
	isPermanent BOOLEAN, -- TRUE if quota is met before Deadline
	Goal INT, -- Goal of number of shares
	ShareCount INT,
	PRIMARY KEY(Pid)
); 