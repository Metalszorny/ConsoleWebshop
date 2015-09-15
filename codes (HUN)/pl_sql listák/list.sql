PROMPT --== Megrendel�sek kilist�z�sa a megadott �vsz�mok k�z�tt ==--
SET SERVEROUTPUT ON;
CLEAR COLUMNS;
COLUMN rendelesi_azonosito FORMAT 99 HEADING 'Rendel�si|azonos�t�';
COLUMN rendelesi_szam FORMAT 99 HEADING 'Rendel�si|sz�m';
COLUMN fizetes_modja FORMAT A20 HEADING 'Fizet�s|m�dja';
COLUMN megrendeles_ideje HEADING 'Megrendel�s|ideje';
COLUMN atvetel_futarral FORMAT A4 HEADING '�tv�tel|fut�rral';
COLUMN vegso_ar FORMAT 9999999999 HEADING 'V�gs�|�r';
COLUMN rendelt_darabszam FORMAT 99 HEADING 'Rendelt|darabsz�m';
COLUMN felhasznaloi_nev FORMAT A15 HEADING 'Felhaszn�l�i|n�v';
COLUMN felhasznaloi_jelszo FORMAT A15 HEADING 'Felhaszn�l�i|jelsz�';
COLUMN termek_azonosito FORMAT 99 HEADING 'Term�k|azonos�t�';
SET PAGESIZE 30;
SET LINESIZE 150;
ALTER SESSION SET NLS_DATE_LANGUAGE = ENGLISH;
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY.MM.DD';
ACCEPT elso PROMPT 'K�rem az els� �vsz�mot: ';
ACCEPT masodik PROMPT 'K�rem a m�sodik �vsz�mot: ';
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
			DBMS_OUTPUT.PUT_LINE('A k�t megadott �vsz�m egyenl�.');
END;
/