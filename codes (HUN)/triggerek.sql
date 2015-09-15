SET SERVEROUTPUT ON;
DROP TRIGGER termektorles;
CREATE OR REPLACE TRIGGER termektorles
AFTER DELETE ON termekek
	FOR EACH ROW
		BEGIN
			DBMS_OUTPUT.PUT_LINE('A(z) ' || :old.termek_neve ||' nevû termék törölve lett.');
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('A termék nem található.' );
END;
/
SET SERVEROUTPUT ON;
DROP TRIGGER termekupdate;
CREATE OR REPLACE TRIGGER termekupdate
BEFORE UPDATE ON termekek
	FOR EACH ROW
		BEGIN
			IF :new.termek_egysegara <> 0 THEN
				DBMS_OUTPUT.PUT_LINE('Az új ár helyes: ' || :new.termek_egysegara);
			END IF;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('A termék nem található.' );
END;
/
SET SERVEROUTPUT ON;
DROP TRIGGER termektorles;
CREATE OR REPLACE TRIGGER termektorles
	BEFORE DELETE ON termekek
		BEGIN
			DBMS_OUTPUT.PUT_LINE('Ne töröld a terméket, inkább állítsd a darabszámát nullára.');
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('A termék nem található.' );
END;
/