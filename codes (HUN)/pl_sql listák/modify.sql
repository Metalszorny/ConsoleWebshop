PROMPT --== Felhasználó telefonszámának módosítása ==--;
SET SERVEROUTPUT ON;
ALTER SESSION SET NLS_DATE_LANGUAGE = ENGLISH;
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY.MM.DD';
ACCEPT felhasz PROMPT 'Kérem a felhasználó nevét: ';
ACCEPT ujszam PROMPT 'Kérem az új telefonszámát: ';
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
		DBMS_OUTPUT.PUT_LINE('A felhasználó '|| '&felhasz' ||' telefonszáma módosítva erre: '||'&ujszam');
	END IF;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('Hiba.');
		WHEN rossz THEN
			DBMS_OUTPUT.PUT_LINE('Nincs ilyen felhasználó.');
END;
/