/*ONE POINT FOR EACH ANSWER OF SECTION 1*/
delimiter $$

CREATE TRIGGER point1
AFTER INSERT ON answer
FOR EACH ROW 
BEGIN
    DECLARE my_idUser int;
    
    SELECT idUser INTO my_idUser
    FROM questionnaire 
    WHERE new.idQuestionnaire = id;

    UPDATE user
    SET score = score + 1 
    WHERE id = my_idUser;
END;$$

delimiter ; 


/*ONE POINT FOR EACH ANSWER OF SECTION 1*/
delimiter $$

CREATE TRIGGER point1Remove
AFTER DELETE ON answer
FOR EACH ROW 
BEGIN
    DECLARE my_idUser int;
    
    SELECT idUser INTO my_idUser
    FROM questionnaire 
    WHERE old.idQuestionnaire = id ;

    UPDATE user
    SET score = score - 1 
    WHERE id = my_idUser;
END;$$

delimiter ; 


/*ONE POINT FOR EACH ANSWER OF SECTION 2*/
delimiter $$

CREATE TRIGGER point2
AFTER INSERT ON questionnaire 
FOR EACH ROW 
BEGIN
    IF (new.sex IS NOT NULL) THEN
        UPDATE user
        SET score = score + 2
        WHERE id = new.idUser;
    END IF;
    IF (new.age IS NOT NULL) THEN
        UPDATE user
        SET score = score + 2
        WHERE id = new.idUser;
    END IF;
    IF (new.expertise_level IS NOT NULL) THEN
        UPDATE user
        SET score = score + 2
        WHERE id = new.idUser;
    END IF;
END;$$

delimiter ; 


/*ONE POINT FOR EACH ANSWER OF SECTION 2*/
delimiter $$

CREATE TRIGGER point2Remove
AFTER DELETE ON questionnaire 
FOR EACH ROW 
BEGIN
    IF (old.sex IS NOT NULL) THEN
        UPDATE user
        SET score = score - 2
        WHERE id = old.idUser;
    END IF;
    IF (old.age IS NOT NULL) THEN
        UPDATE user
        SET score = score - 2
        WHERE id = old.idUser;
    END IF;
    IF (old.expertise_level IS NOT NULL) THEN
        UPDATE user
        SET score = score - 2
        WHERE id = old.idUser;
    END IF;
END;$$

delimiter ; 


/*BANNED WORD*/
delimiter $$

CREATE TRIGGER bannedWord
BEFORE INSERT ON answer 
FOR EACH ROW
BEGIN
	IF ((SELECT count(*) 
		FROM blacklist_word 
		WHERE new.text LIKE CONCAT('%', word, '%')) > 0) 
	THEN
		DELETE FROM questionnaire WHERE new.idQuestionnaire = id;
		SIGNAL sqlstate '45001' set message_text = "User used a banned word!";
	END IF;
END;$$

delimiter ; 


/*ONE PRODUCT PER DAY*/
delimiter $$

CREATE TRIGGER noMoreThanTwo
BEFORE INSERT ON product 
FOR EACH ROW
BEGIN
	IF (SELECT count(*)
		FROM product
		WHERE new.date = date) 
		
	THEN
		SIGNAL sqlstate '45002' set message_text = "There can be only one product for a day!";
	END IF;
END;$$

delimiter ;
