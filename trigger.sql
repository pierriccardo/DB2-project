/*ONE POINT FOR EACH ANSWER OF SECTION 1*/
CREATE TRIGGER point1
AFTER INSERT ON ANSWER
FOR EACH ROW 
BEGIN
    DECLARE x;
    
    SELECT idUser
    INTO x
    FROM QUESTIONNAIRE 
    WHERE new.idQuestionnaire = id ;

    UPDATE USER
    SET score = score + 1 
    WHERE id = x;
END ;

/*ONE POINT FOR EACH ANSWER OF SECTION 1*/
CREATE TRIGGER point1
AFTER DELETE ON ANSWER
FOR EACH ROW 
BEGIN
    DECLARE x;
    
    SELECT idUser
    INTO x
    FROM QUESTIONNAIRE 
    WHERE old.idQuestionnaire = id ;

    UPDATE USER
    SET score = score - 1 
    WHERE id = x;
END ;


/*ONE POINT FOR EACH ANSWER OF SECTION 2*/
CREATE TRIGGER point2
AFTER INSERT ON QUESTIONNAIRE 
FOR EACH ROW 
BEGIN
    IF(new.sex IS NOT NULL)
        UPDATE LEADERBOARD
        SET score = score + 2
        WHERE id = new.idUser;
    
    IF(new.age IS NOT NULL)
        UPDATE LEADERBOARD
        SET score = score + 2
        WHERE id = new.idUser;
    
    IF(new.expertise_level) IS NOT NULL)
        UPDATE LEADERBOARD
        SET score = score + 2
        WHERE id = new.idUser;
END ;

/*ONE POINT FOR EACH ANSWER OF SECTION 2*/
CREATE TRIGGER point2
AFTER DELETE ON QUESTIONNAIRE 
FOR EACH ROW 
BEGIN
    IF(old.sex IS NOT NULL)
        UPDATE LEADERBOARD
        SET score = score - 2
        WHERE id = new.idUser;
    
    IF(old.age IS NOT NULL)
        UPDATE LEADERBOARD
        SET score = score - 2
        WHERE id = new.idUser;
    
    IF(old.expertise_level) IS NOT NULL)
        UPDATE LEADERBOARD
        SET score = score - 2
        WHERE id = new.idUser;
END ;


/*BANNED WORD*/
CREATE TRIGGER banned
BEFORE INSERT ON ANSWER 
FOR EACH ROW
WHEN NOT EXIST (SELECT *
                FROM BANNEDWORD
                WHERE new.text LIKE '%' word '%')
BEGIN
    UPDATE USER
    SET isBanned = true 
    WHERE id = new.id;

    SIGNAL sqlstate '45001' set message_text = "User used a banned word!";
END ;
