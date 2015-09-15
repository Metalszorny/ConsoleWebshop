DROP TABLE parositas;
PROMPT --== Ugyan azon gyártótól származó termékek párosítása ==--;
CREATE TABLE parositas AS SELECT * FROM termekek;
ALTER TABLE parositas ADD (par VARCHAR2(40));
SET SERVEROUTPUT ON;
DECLARE
	CURSOR kurzor_a IS SELECT * FROM parositas FOR UPDATE;
	CURSOR kurzor_b IS SELECT * FROM parositas FOR UPDATE;
	rekord_a kurzor_a%ROWTYPE;
	rekord_b kurzor_b%ROWTYPE;
BEGIN
	OPEN kurzor_a;
	LOOP
		FETCH kurzor_a INTO rekord_a;
		EXIT WHEN kurzor_a%NOTFOUND;
		IF rekord_a.par IS NULL THEN
			OPEN kurzor_b;
			LOOP
				FETCH kurzor_b INTO rekord_b;
				EXIT WHEN kurzor_b%NOTFOUND;
				IF rekord_a.gyarto_neve = rekord_b.gyarto_neve AND rekord_b.par IS NULL AND rekord_a.par IS NULL AND rekord_a.termek_neve <> rekord_b.termek_neve THEN
					DBMS_OUTPUT.PUT_LINE(rekord_a.termek_neve || ' ==> ' || rekord_b.termek_neve);
					UPDATE parositas SET par = rekord_a.termek_neve WHERE CURRENT OF kurzor_b;
					UPDATE parositas SET par = rekord_b.termek_neve WHERE CURRENT OF kurzor_a;
				END IF;
			END LOOP;
			CLOSE kurzor_b;
		END IF;
	END LOOP;
	CLOSE kurzor_a;
END;
/