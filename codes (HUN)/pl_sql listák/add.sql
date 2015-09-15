PROMPT --== �j felhaszn�l� hozz�ad�sa =--;
SET SERVEROUTPUT ON;
ALTER SESSION SET NLS_DATE_LANGUAGE = ENGLISH;
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY.MM.DD';
ACCEPT felhasznaloinev PROMPT 'felhaszn�l�i n�v: ';
ACCEPT felhasznaloijelszo PROMPT 'felhaszn�l�i jelsz�: ';
ACCEPT felhasznaloneve PROMPT 'felhaszn�l� neve: ';
ACCEPT felhasznaloiranyitoszama PROMPT 'felhaszn�l� ir�ny�t�sz�ma: ';
ACCEPT felhasznalocime PROMPT 'felhaszn�l� c�me: ';
ACCEPT felhasznalotelefonszama PROMPT 'felhaszn�l� telefonsz�ma: ';
ACCEPT felhasznaloemailcime PROMPT 'felhaszn�l� e-mail c�me: ';
ACCEPT felhasznaloneme PROMPT 'felhaszn�l� neme: ';
ACCEPT felhasznaloszuletesiideje PROMPT 'felhaszn�l� sz�let�si ideje: ';
ACCEPT regisztracioideje PROMPT 'regisztr�ci� ideje: ';
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
			DBMS_OUTPUT.PUT_LINE('Nincs ilyen felhaszn�l�.');
END;
/
CLEAR COLUMNS;
COLUMN felhasznaloi_nev FORMAT A15 HEADING 'Felhaszn�l�i|n�v';
COLUMN felhasznaloi_jelszo FORMAT A15 HEADING 'Felhaszn�l�i|jelsz�';
COLUMN felhasznalo_neve FORMAT A15 HEADING 'Felhaszn�l�|neve';
COLUMN felhasznalo_iranyitoszama FORMAT 9999 HEADING 'Felhaszn�l�|ir�ny�t�sz�ma';
COLUMN felhasznalo_telefonszama FORMAT 999999999 HEADING 'Felhaszn�l�|telefonsz�ma';
COLUMN felhasznaloi_email_cime FORMAT A25 HEADING 'Felhaszn�l�|e-mail c�me';
COLUMN felhasznaloi_neme FORMAT A5 HEADING 'Felhaszn�l�|neme';
COLUMN felhasznalo_szuletesi_ideje HEADING 'Felhaszn�l�|sz�let�si ideje';
COLUMN regisztracio_ideje HEADING 'Regisztr�ci�|ideje';
SET PAGESIZE 30;
SET LINESIZE 150;
SELECT * FROM felhasznalok;