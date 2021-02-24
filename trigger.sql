/*ONE POINT FOR EACH ANSWER OF SECTION 1*/
delimiter $$

CREATE TRIGGER point1
AFTER INSERT ON answer
FOR EACH ROW 
BEGIN
    DECLARE x int;
    
    SELECT idUser
    INTO x
    FROM questionnaire 
    WHERE new.idQuestionnaire = id ;

    UPDATE user
    SET score = score + 1 
    WHERE id = x;
END;$$

delimiter ; 


/*ONE POINT FOR EACH ANSWER OF SECTION 1*/
delimiter $$

CREATE TRIGGER point1Remove
AFTER DELETE ON answer
FOR EACH ROW 
BEGIN
    DECLARE x int;
    
    SELECT idUser
    INTO x
    FROM questionnaire 
    WHERE old.idQuestionnaire = id ;

    UPDATE user
    SET score = score - 1 
    WHERE id = x;
END;$$

delimiter ; 


/*ONE POINT FOR EACH ANSWER OF SECTION 2*/
delimiter $$

CREATE TRIGGER point2
AFTER INSERT ON questionnaire 
FOR EACH ROW 
BEGIN
    IF(new.sex IS NOT NULL) then
        UPDATE user
        SET score = score + 2
        WHERE id = new.idUser;
    end if;
    IF(new.age IS NOT NULL) then
        UPDATE user
        SET score = score + 2
        WHERE id = new.idUser;
    end if;
    IF(new.expertise_level IS NOT NULL) then
        UPDATE user
        SET score = score + 2
        WHERE id = new.idUser;
    end if;
END;$$

delimiter ; 


/*ONE POINT FOR EACH ANSWER OF SECTION 2*/
delimiter $$

CREATE TRIGGER point2Remove
AFTER DELETE ON questionnaire 
FOR EACH ROW 
BEGIN
    IF(old.sex IS NOT NULL) then
        UPDATE user
        SET score = score - 2
        WHERE id = old.idUser;
    end if;
    IF(old.age IS NOT NULL) then
        UPDATE user
        SET score = score - 2
        WHERE id = old.idUser;
    end if;
    IF(old.expertise_level IS NOT NULL) then
        UPDATE user
        SET score = score - 2
        WHERE id = old.idUser;
    end if;

END;$$

delimiter ; 

/*BANNED WORD*/
delimiter $$

CREATE TRIGGER bannedWord
BEFORE INSERT ON answer 
FOR EACH ROW
BEGIN
if (SELECT count(*)
                FROM blacklist_word
                WHERE new.text LIKE CONCAT('%', word, '%')) > 0 then


    DELETE questionnaire
    WHERE new.idQuestionnaire = id;

    SIGNAL sqlstate '45001' set message_text = "User used a banned word!";
    
    end if;
END;$$

delimiter ; 


/*ONE PRODUCT PER DAY*/
delimiter $$

CREATE TRIGGER noMoreThanTwo
BEFORE INSERT ON product 
FOR EACH ROW
BEGIN
if (SELECT count(*)
                FROM product
                WHERE new.date = date) then

    SIGNAL sqlstate '45002' set message_text = "There can be only one product for a day!";
    
    end if;
END;$$

delimiter ; 
