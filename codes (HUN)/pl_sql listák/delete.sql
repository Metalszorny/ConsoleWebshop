PROMPT --== Megrendel�s t�rl�se ==--
SET SERVEROUTPUT ON;
ALTER SESSION SET NLS_DATE_LANGUAGE = ENGLISH;
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY.MM.DD';
ACCEPT nev PROMPT 'Add meg a t�rlend� rendel�sekhez tartoz� felhaszn�l�i nevet:  ';
DECLARE
	rossz EXCEPTION;
	aneve VARCHAR2(20);
	ez VARCHAR2(20);
BEGIN
	SELECT NVL(felhasznaloi_nev, 'nincs') INTO aneve FROM megrendelesek WHERE felhasznaloi_nev = '&nev';
	IF (aneve != '&nev') THEN
		RAISE rossz;
	ELSE
		SELECT COUNT(felhasznaloi_nev) INTO ez FROM megrendelesek WHERE felhasznaloi_nev = '&nev';
		DELETE megrendelesek WHERE felhasznaloi_nev = '&nev';
		DBMS_OUTPUT.PUT_LINE('Rekord t�r�lve(db): '|| ez);
	END IF;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('Hiba.');
		WHEN rossz THEN
			DBMS_OUTPUT.PUT_LINE('Nincs ilyen felhaszn�l�i n�v, vagy rendel�s.');
END;
/