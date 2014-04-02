-- SELECTS --
-------------
-- All SparkUsers
SELECT Username 
FROM SparkUsers;


-- Posts By Date
SELECT PostContent, PostedDate
FROM Posts
GROUP BY PostedDate, PostContent;


-- Posts that didn’t meet their Deadline POSTS TO BE REMOVED
SELECT P.PostID
FROM Posts P, ShareQuotas S
WHERE P.PostShareCount < S.SharesRequired AND now()::date >= S.QuotaDeadline AND P.PostShareQuotaID = S.ShareQuotaID;


-- SparkUser with the Post with most Shares
SELECT U.Username, P.PostTitle, P.PostShareCount
FROM SparkUsers U, Posts P
WHERE U.UserID = P.PostUserID AND P.PostShareCount >= ALL 
                                                     (SELECT PS.PostShareCount
                                                      FROM Posts PS);


-- Top 3 Groups based on number of Groups
SELECT GroupName, COUNT(*) AS Number_Of_Members
FROM Groups JOIN GroupMembers
ON Groups.GroupId = GroupMembers.MemberGroupId
GROUP BY GroupName
ORDER BY Number_Of_Members DESC
LIMIT 3;


-- AGGREGATES --
----------------
-- The SparkUser with the most amount of PermanentPosts
SELECT U.Username, COUNT(PermPostUserID)
FROM PermanentPosts PM, SparkUsers U
WHERE U.UserID = PM.PermPostUserID
GROUP BY U.Username
ORDER BY count DESC LIMIT 1;

-- SparkUser with the most Shares
SELECT U.Username, P.PostShareCount
FROM SparkUsers U, Posts P
WHERE U.UserID = P.PostUserID AND P.PostShareCount >= ALL 
                                  (SELECT PS.PostShareCount
                                   FROM Posts PS)
GROUP BY U.Username, P.PostShareCount;


-- JOINS --
-----------
-- JOIN Posts and MediaElemnts to get Posts back with or without Media
SELECT P.PostTitle, P.PostContent, M.MediaURL, P.PostedDate
FROM Posts P, MediaElements M
WHERE (P.PostHasMedia AND M.MediaPostID = P.PostID) OR NOT P.PostHasMedia;

-- Top 3 Posts that have not met their Quota
SELECT Posts.* -- (optional columns) ,ShareQuotaId.SharesRequired, ShareQuotaId.QuotaDeadline
FROM Posts NATURAL JOIN  ShareQuotas
WHERE QuotaMet = FALSE AND (now()::date < QuotaDeadline AND PostShareQuotaID = ShareQuotaID)
ORDER BY PostShareCount DESC 
LIMIT 3;


-- VIEWS --
-----------
-- CREATE VIEW top_15 AS
--           SELECT PostID 
--           FROM Posts
--           ORDER BY PostShareCount DESC LIMIT 15;



-- INDEXES --
-- CREATE INDEX spark_users_user_identification
--       ON SparkUsers (UserID);
-- CREATE INDEX date_posted 
--      ON Posts (PostedDate);



-- TRIGGERS --
--------------
-- If Post(s) are DELETE’d, DELETE the MediaElements and contributions  as well

-- CREATE OR REPLACE FUNCTION remove_media_and_contributions_tuples() RETURNS trigger AS $$
-- BEGIN
-- DELETE FROM MediaElements C
-- 	WHERE OLD.PostID = C.contribpostid;

-- 	IF (OLD.PostHasMedia) THEN
-- 		DELETE FROM MediaElements M
-- 		WHERE OLD.PostID = M.MediaPostId;
--       END IF;    
-- RETURN NULL;
-- END;
-- $$ LANGUAGE plpgsql;
-- CREATE TRIGGER remove_posts_contribution_and_media
-- 	AFTER DELETE ON Posts
-- 	FOR EACH ROW
-- 	EXECUTE PROCEDURE remove_media_and_contributions_tuples();


-- If Contribution(s) are DELETE’d, DELETE the MediaElementsl

-- CREATE OR REPLACE FUNCTION remove_contributions_media() RETURNS trigger AS $$
-- BEGIN
-- 	IF (OLD.ConTribHasMedia) THEN
-- 		DELETE FROM MediaElements M
-- 		WHERE OLD.ContribId = M.MediaPostID;
--       END IF;
--       RETURN NULL;
-- END;
-- $$ LANGUAGE plpgsql;
-- CREATE TRIGGER remove_contributions_media
-- 	AFTER DELETE ON Posts
-- 	FOR EACH ROW
-- 	EXECUTE PROCEDURE remove_contributions_media();


-- TRIGGER on DELETE’ing a Group to DELETE GroupMessages  and group members

-- CREATE OR REPLACE FUNCTION delete_group_messages_and_members() RETURNS trigger AS $$
-- BEGIN
-- -- delete messages intances for all members
-- DELETE FROM messagesDelivered M
-- WHERE M.MessageId IN (SELECT MessageId FROM groupMessages 
--           WHERE MessageGroupId = OLD.GroupId);

-- -- delete the messages sent
-- DELETE FROM GroupMessages M
-- WHERE OLD.GroupID = M.MessageGroupID;

-- -- delete membermships
-- DELETE FROM groupMembers M
-- WHERE OLD.GroupID = M.MemberGroupId;

-- RETURN NULL;
-- END;
-- $$ LANGUAGE plpgsql;
-- CREATE TRIGGER deleting_group_activity
--             AFTER DELETE ON Groups 
--             FOR EACH ROW 
--             EXECUTE PROCEDURE delete_group_messages_and_members();