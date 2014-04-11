CREATE TABLE Contributions (
	Cid SERIAL NOT NULL,
	Userid SERIAL NOT NULL,
	Username VARCHAR(20) NOT NULL,
	Email VARCHAR(35) NOT NULL,
	Pid SERIAL,
	Content VARCHAR(256), -- Not sure on data type
	PRIMARY KEY (Cid),
	FOREIGN KEY (Userid,Username,Email)
		REFERENCES Sharer(Userid,Username,Email),
	FOREIGN KEY (Pid)
		REFERENCES Post(Pid)
);
