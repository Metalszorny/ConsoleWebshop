PROMPT --== Megrendelések kilistázása a megadott évszámok között ==--
SET SERVEROUTPUT ON;
CLEAR COLUMNS;
COLUMN rendelesi_azonosito FORMAT 99 HEADING 'Rendelési|azonosító';
COLUMN rendelesi_szam FORMAT 99 HEADING 'Rendelési|szám';
COLUMN fizetes_modja FORMAT A20 HEADING 'Fizetés|módja';
COLUMN megrendeles_ideje HEADING 'Megrendelés|ideje';
COLUMN atvetel_futarral FORMAT A4 HEADING 'Átvétel|futárral';
COLUMN vegso_ar FORMAT 9999999999 HEADING 'Végsõ|ár';
COLUMN rendelt_darabszam FORMAT 99 HEADING 'Rendelt|darabszám';
COLUMN felhasznaloi_nev FORMAT A15 HEADING 'Felhasználói|név';
COLUMN felhasznaloi_jelszo FORMAT A15 HEADING 'Felhasználói|jelszó';
COLUMN termek_azonosito FORMAT 99 HEADING 'Termék|azonosító';
SET PAGESIZE 30;
SET LINESIZE 150;
ALTER SESSION SET NLS_DATE_LANGUAGE = ENGLISH;
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY.MM.DD';
ACCEPT elso PROMPT 'Kérem az elsõ évszámot: ';
ACCEPT masodik PROMPT 'Kérem a második évszámot: ';
DECLARE
	rossz EXCEPTION;
	temp NUMBER(15);
	cikl DATE;
BEGIN
	IF ('&elso' = '&masodik') THEN
		RAISE rossz;
	ELSE
		IF ('&masodik' > '&elso') THEN
			FOR cikl IN '&masodik' .. '&elso'
				LOOP
					SELECT * FROM megrendelesek WHERE megrendeles_idje = cikl;
				END LOOP;
		ELSE
			FOR cikl IN '&elso' .. '&masodik'
				LOOP
					SELECT * FROM megrendelesek WHERE megrendeles_idje = cikl;
				ND LOOP;
		END IF;
	END IF;
	 EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE ('Hiba.');
		WHEN rossz THEN
			DBMS_OUTPUT.PUT_LINE('A két megadott évszám egyenlõ.');
END;
/