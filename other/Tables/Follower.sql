CREATE TABLE Follower ( -- Is-A User
	Userid SERIAL NOT NULL,
	Username VARCHAR(20) NOT NULL,
	Email VARCHAR(35) NOT NULL,
	Pid INT,
	FOREIGN KEY (Pid)
		REFERENCES Post(Pid),
	FOREIGN KEY (Userid,Username,Email)
		REFERENCES Sharer(Userid,Username,Email)
);
