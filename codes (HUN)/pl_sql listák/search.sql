PROMPT --== Termék keresése ==--;
SET SERVEROUTPUT ON;
ALTER SESSION SET NLS_DATE_LANGUAGE = ENGLISH;
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY.MM.DD';
ACCEPT termek PROMPT 'Kérem a keresendõ termék nevét: ';
DECLARE
	rossz EXCEPTION;
	aneve VARCHAR2(20);
	ez VARCHAR(30);
BEGIN
	SELECT NVL(termek_neve, 'nincs ilyen') INTO aneve FROM termekek WHERE LOWER(termek_neve) LIKE LOWER('%&termek%');
	IF (aneve = 'nincs ilyen') THEN
		RAISE rossz;
	ELSE
		SELECT termek_neve INTO ez FROM termekek WHERE LOWER(termek_neve) LIKE LOWER('%&termek%');
		DBMS_OUTPUT.PUT_LINE('A termék neve: '||ez);
	END IF;
	 EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('Hiba.');
		WHEN rossz THEN
			DBMS_OUTPUT.PUT_LINE('Nincs ilyen nevû termék.');
END;
/