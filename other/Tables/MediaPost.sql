CREATE TABLE MediaPost (
	Pid SERIAL NOT NULL REFERENCES Post(Pid),
	MediaURL VARCHAR(256) NOT NULL, -- A JOIN would give us the 'content' from the Post table
	FOREIGN KEY (Pid),
	-- CREATE TRIGGER for DELETEs in Post as well
	-- CREATE TRIGGER for INSERTs " "
);
