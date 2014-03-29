CREATE DATABASE sprkShare;

-- Users data 
CREATE TABLE sparkUsers (
	UserId SERIAL,
	Username VARCHAR(250),
	UserPassword VARCHAR(250),
	UserEmail VARCHAR(250),
	UserPicURL VARCHAR(1000) DEFAULT 'imgs/defaultAvatar.PNG',
	UserDescription VARCHAR(500),
	UserRegistrationDate timestamp NOT NULL DEFAULT CURRENT_DATE,
	PRIMARY KEY (Userid)
);

CREATE TABLE followers (
	FollowershipId SERIAL,
	FollowerId integer REFERENCES sparkUsers(UserId),
	FollowedUserId integer REFERENCES sparkUsers(UserId),
	PRIMARY KEY (FollowershipId)
);

-- Posts data
CREATE TABLE mediaElements (
	MediaId SERIAL,
	MediaPostId integer REFERENCES Posts(PostId),
	MediaURL VARCHAR(1000) NOT NULL,
	PRIMARY KEY (MediaId)
);

CREATE TABLE shareQuotas (
	ShareQuotaId SERIAL,
	SharesRequired integer,
	QuotaDeadline date,
	QuotaMet boolean, 
	PRIMARY KEY (ShareQuotaId)
);

CREATE TABLE posts (
	PostId SERIAL,
	PostUserid integer REFERENCES SparkUsers(UserId), 
	PostTitle VARCHAR(250) NOT NULL,
	PostContent VARCHAR(1000),
	PostShareQuotaId integer REFERENCES ShareQuotas(ShareQuotaId),
	PostShareCount integer,
	PostHasMedia boolean,
	PostedDate date,
	PRIMARY KEY (PostId)
);

CREATE TABLE contributions (
	ConTribId SERIAL,
	ContribPostId integer REFERENCES Posts(PostId), 
	ContribUserId integer REFERENCES sparkUsers(UserId),
	ContribContent VARCHAR(1000) NOT NULL,
	ConTribHasMedia boolean,
	ContributedDate date,
	PRIMARY KEY (ConTribId)
);

CREATE TABLE permanentPosts (
	PermPostId SERIAL,
	PermPostUserid integer REFERENCES sparkUsers(UserId),
	PermPostContent VARCHAR(1000) NOT NULL,
	PermPostShareCount integer,
	PermPostHasMedia boolean,
	PRIMARY KEY (PermPostId)
);

-- Groups data
CREATE TABLE groups (
	GroupId SERIAL,
	GroupPermPostId integer REFERENCES PermanentPosts(PermPostId),
	GroupName VARCHAR(250),
	GroupMainGoal VARCHAR(1000),
	PRIMARY KEY (GroupId)		
);

CREATE TABLE goals (
	GoalId SERIAL,
	GoalgroupID integer REFERENCES Groups(GroupId),
	GoalDescription VARCHAR(500),
	GoalDeadline DATE,
	PRIMARY KEY (GoalId)
);

CREATE TABLE events (
	EventId SERIAL,
	EventGroupId integer REFERENCES Groups(GroupId),
	EventDate date,
	EventLocation VARCHAR(500),
	EventPurpose VARCHAR(500),
	PRIMARY KEY (EventId)
);

CREATE TABLE groupMembers(
	MembershipId SERIAL,
	MemberUserId integer REFERENCES sparkUsers(UserId),
	MemberGroupId integer REFERENCES Groups(GroupId),
	PRIMARY KEY (MembershipId)
);

CREATE TABLE groupMessages (
	MessageId SERIAL,
	MessageGroupId integer REFERENCES Groups(GroupId),
	MessageContent VARCHAR(500),
	PRIMARY KEY (MessageId)
);

-- This is actually user data but it was place here due to dependencies.
CREATE TABLE messagesDelivered (
	MessageInstanceId SERIAL,
	MessageId integer REFERENCES GroupMessages(MessageId),
	MessageRecipientId integer REFERENCES sparkUsers(UserId),
	MessageRead boolean
);