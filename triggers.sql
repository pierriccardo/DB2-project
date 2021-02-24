/*ONE POINT FOR EACH ANSWER OF SECTION 1*/
delimiter $$

CREATE TRIGGER point1
AFTER INSERT ON answer
FOR EACH ROW 
BEGIN
	DECLARE my_idUser INT;

	SELECT idUser INTO my_idUser
	FROM questionnaire 
	WHERE new.idQuestionnaire = id AND isSubmitted = 1;

	UPDATE user
	SET score = score + 1 
	WHERE id = my_idUser;
END;$$

delimiter ; 


/*ONE POINT FOR EACH ANSWER OF SECTION 2*/
delimiter $$

CREATE TRIGGER point2
AFTER UPDATE ON questionnaire 
FOR EACH ROW 
BEGIN
	IF (new.sex > 0 AND new.isSubmitted = 1) THEN
		UPDATE user
		SET score = score + 2
		WHERE id = new.idUser;
	END IF;
	IF (new.age > 0 AND new.isSubmitted = 1) THEN
		UPDATE user
		SET score = score + 2
		WHERE id = new.idUser;
	END IF;
	IF (new.expertise_level > 0 AND new.isSubmitted = 1) THEN
		UPDATE user
		SET score = score + 2
		WHERE id = new.idUser;
    END IF;
END;$$

delimiter ; 


/*REMOVE QUESTIONNAIRES OF A PRODUCT*/
delimiter $$

CREATE TRIGGER removeQuestionnaireProduct
BEFORE DELETE ON product
FOR EACH ROW 
BEGIN
	DELETE FROM questionnaire WHERE idProduct = old.id;
END;$$

delimiter ; 


/*REMOVE POINTS OF DELETED QUESTIONNAIRES*/
delimiter $$

CREATE TRIGGER removePoints
BEFORE DELETE ON questionnaire
FOR EACH ROW 
BEGIN
    DECLARE my_score INT;
    
    SELECT count(*) INTO my_score FROM answer WHERE idQuestionnaire = old.id;
    
    IF (old.sex > 0 AND old.isSubmitted = 1) THEN
        /* UPDATE user
        SET score = score - 2
        WHERE id = old.idUser; */
        
        SELECT my_score + 2 INTO my_score;
    END IF;
    IF (old.age > 0 AND old.isSubmitted = 1) THEN
        /* UPDATE user
        SET score = score - 2
        WHERE id = old.idUser; */
        
        SELECT my_score + 2 INTO my_score;
    END IF;
    IF (old.expertise_level > 0 AND old.isSubmitted = 1) THEN
        /*UPDATE user
        SET score = score - 2
        WHERE id = old.idUser; */
        
        SELECT my_score + 2 INTO my_score;
    END IF;
    
    UPDATE user SET score = score - my_score WHERE id = old.idUser;
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
		SIGNAL sqlstate '45001' set message_text = "There can be only one product for a day!";
    END IF;
END;$$

delimiter ; 



/*
show triggers;

DROP TRIGGER point1;
DROP TRIGGER point2;
DROP TRIGGER removeQuestionnaireProduct;
DROP TRIGGER removePoints;
DROP TRIGGER bannedWord;
DROP TRIGGER noMoreThanTwo;
*/
