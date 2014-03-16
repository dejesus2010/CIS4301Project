CREATE TABLE MediaPost (
	MediaURL VARCHAR(256),
	Pid INT NOT NULL AUTO_INCREMENT,
	Content VARCHAR(256), -- Not sure about data type
	ShareQuota INT, -- Share Count for Deadline
	Deadline DATE, 
	isPermanent BOOLEAN, -- TRUE if quota is met before Deadline
	Goal INT, -- Goal of number of shares
	ShareCount INT,
	FOREIGN KEY (Pid,Content,ShareQuota,Deadline,isPermanent,Goal,ShareCount)
		REFERENCES Post(Pid,Content,ShareQuota,Deadline,isPermanent,Goal,ShareCount)
		ON UPDATE CASCADE
		-- CREATE TRIGGER for DELETEs in Post as well
		-- CREATE TRIGGER for INSERTs
);