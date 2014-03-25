CREATE TABLE Grp (
	Gid SERIAL NOT NULL,
	Name VARCHAR(20),
	MainGoal VARCHAR(256), -- What the group is going to do
	PRIMARY KEY (Gid)
);
