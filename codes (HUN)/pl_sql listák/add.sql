PROMPT --== Új felhasználó hozzáadása =--;
SET SERVEROUTPUT ON;
ALTER SESSION SET NLS_DATE_LANGUAGE = ENGLISH;
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY.MM.DD';
ACCEPT felhasznaloinev PROMPT 'felhasználói név: ';
ACCEPT felhasznaloijelszo PROMPT 'felhasználói jelszó: ';
ACCEPT felhasznaloneve PROMPT 'felhasználó neve: ';
ACCEPT felhasznaloiranyitoszama PROMPT 'felhasználó irányítószáma: ';
ACCEPT felhasznalocime PROMPT 'felhasználó címe: ';
ACCEPT felhasznalotelefonszama PROMPT 'felhasználó telefonszáma: ';
ACCEPT felhasznaloemailcime PROMPT 'felhasználó e-mail címe: ';
ACCEPT felhasznaloneme PROMPT 'felhasználó neme: ';
ACCEPT felhasznaloszuletesiideje PROMPT 'felhasználó születési ideje: ';
ACCEPT regisztracioideje PROMPT 'regisztráció ideje: ';
DECLARE
	rossz EXCEPTION;
	felh VARCHAR2(30);
BEGIN
	SELECT NVL(felhasznaloi_nev, 'ilyen nincs') INTO felh FROM felhasznalok WHERE felhasznaloi_nev = '&felhasznaloinev';
	IF (felh = 'ilyen nincs') THEN
		RAISE rossz;
	ELSE
		INSERT INTO felhasznalok VALUES ('&felhasznaloinev', '&felhasznaloijelszo', '&felhasznaloneve', '&felhasznaloiranyitoszama', '&felhasznalocime', '&felhasznalotelefonszama', '&felhasznaloemailcime', '&felhasznaloneme', '&felhasznaloszuletesiideje', '&regisztracioideje');
	END IF;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('Hiba.');
		WHEN rossz THEN
			DBMS_OUTPUT.PUT_LINE('Nincs ilyen felhasználó.');
END;
/
CLEAR COLUMNS;
COLUMN felhasznaloi_nev FORMAT A15 HEADING 'Felhasználói|név';
COLUMN felhasznaloi_jelszo FORMAT A15 HEADING 'Felhasználói|jelszó';
COLUMN felhasznalo_neve FORMAT A15 HEADING 'Felhasználó|neve';
COLUMN felhasznalo_iranyitoszama FORMAT 9999 HEADING 'Felhasználó|irányítószáma';
COLUMN felhasznalo_telefonszama FORMAT 999999999 HEADING 'Felhasználó|telefonszáma';
COLUMN felhasznaloi_email_cime FORMAT A25 HEADING 'Felhasználó|e-mail címe';
COLUMN felhasznaloi_neme FORMAT A5 HEADING 'Felhasználó|neme';
COLUMN felhasznalo_szuletesi_ideje HEADING 'Felhasználó|születési ideje';
COLUMN regisztracio_ideje HEADING 'Regisztráció|ideje';
SET PAGESIZE 30;
SET LINESIZE 150;
SELECT * FROM felhasznalok;