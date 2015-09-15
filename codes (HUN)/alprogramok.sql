PROMPT --== A termékek árának szórása ==--;
SET SERVEROUTPUT ON;
CREATE OR REPLACE FUNCTION atlag (szam1 NUMBER, szam2 NUMBER)
RETURN NUMBER
IS
	cikl NUMBER(6);
	szum NUMBER(6);
	db number(6);
BEGIN
	szum := 0;
	db := 0;
	FOR cikl IN szam1 .. szam2
	LOOP
		szum := szum + cikl;
		db := db + 1;
	END LOOP;
	szum := szum / db;
RETURN szum;
END;
/
CREATE OR REPLACE FUNCTION atlagelt (szam1 NUMBER, szam2 NUMBER, atlag NUMBER)
RETURN NUMBER
IS
	cikl NUMBER(6);
	szum NUMBER(6);
	db NUMBER(6);
BEGIN
	szum := 0;
	db := 0;
	cikl := szam1;
	WHILE cikl < (szam2 + 1)
	LOOP
		IF (atlag - cikl) > 0 THEN
			szum := szum + (atlag - cikl);
		END IF;
		IF (atlag - cikl) < 0 THEN
			szum := szum + (cikl - atlag);
		END IF;
		cikl := cikl + 1;
		db := db + 1;
	END LOOP;
	szum := szum / db;
	RETURN szum;
END;
/
CREATE OR REPLACE PROCEDURE WriteLn (szoveg VARCHAR2)
IS
	szoveg2 VARCHAR2(100);
BEGIN
	szoveg2 := szoveg;
	DBMS_OUTPUT.PUT_LINE(szoveg2);
END;
/
DECLARE
	CURSOR kurzor_a IS SELECT MIN(termek_egysegara) AS termek_egysegara FROM termekek;
	CURSOR kurzor_b IS SELECT MAX(termek_egysegara) AS termek_egysegara FROM termekek;
	rekord_a kurzor_a%ROWTYPE;
	rekord_b kurzor_b%ROWTYPE;
	minimum NUMBER(6);
	maximum NUMBER(6);
	szam NUMBER(6);
BEGIN
	szam := 0;
	IF szam = 0 THEN
		OPEN kurzor_a;
		LOOP
			FETCH kurzor_a INTO rekord_a;
			EXIT WHEN kurzor_a%NOTFOUND;
			IF szam = 0 THEN
				OPEN kurzor_b;
				szam := 1;
				LOOP
					FETCH kurzor_b INTO rekord_b;
					EXIT WHEN kurzor_b%NOTFOUND;
					minimum := rekord_a.termek_egysegara;
					maximum := rekord_b.termek_egysegara;
					WriteLn('Átlagtól való átlagos eltérés(szórás): '||atlagelt(minimum, maximum, atlag(minimum, maximum)));
					CLOSE kurzor_b;
					OPEN kurzor_b;
					CLOSE kurzor_a;
					OPEN kurzor_a;
					EXIT;
				END LOOP;
				CLOSE kurzor_b;
			END IF;
		END LOOP;
		CLOSE kurzor_a;
	END IF;
END;
/