PROMPT --== Felhaszn�l� telefonsz�m�nak m�dos�t�sa ==--;
SET SERVEROUTPUT ON;
ALTER SESSION SET NLS_DATE_LANGUAGE = ENGLISH;
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY.MM.DD';
ACCEPT felhasz PROMPT 'K�rem a felhaszn�l� nev�t: ';
ACCEPT ujszam PROMPT 'K�rem az �j telefonsz�m�t: ';
DECLARE
	rossz exception;
	felh Varchar2(25);
	ez varchar(30)
BEGIN
	SELECT NVL(felhasznalo_neve, 'nem') INTO felh FROM felhasznalok WHERE felhasznalo_neve = '&felhasz';
	IF (felh = 'nem') THEN
		RAISE rossz;
	ELSE
		UPDATE felhasznalok SET felhasznalo_telefonszama = '&ujszam' where felhasznalo_neve = '&felhasz';
		DBMS_OUTPUT.PUT_LINE('A felhaszn�l� '|| '&felhasz' ||' telefonsz�ma m�dos�tva erre: '||'&ujszam');
	END IF;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('Hiba.');
		WHEN rossz THEN
			DBMS_OUTPUT.PUT_LINE('Nincs ilyen felhaszn�l�.');
END;
/