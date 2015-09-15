SET FEEDBACK OFF;

TTITLE "Termék típusok, amibõl legalább 3 darab van"
BTITLE ""
COLUMN termek_tipusa FORMAT A15 HEADING 'Termék|típusa';
SELECT termek_tipusa, COUNT(termek_tipusa) AS "Darab" FROM termekek GROUP BY termek_tipusa HAVING COUNT(termek_tipusa) >= 3;

TTITLE "Feltörhetetlen jelszavú felhasználók"
BTITLE ""
COLUMN felhasznalo_neve FORMAT A15 HEADING 'Felhasználó|neve';
SELECT felhasznalo_neve, LENGTH(felhasznaloi_jelszo) AS "hossz" FROM felhasznalok WHERE LENGTH(felhasznaloi_jelszo) > 10;

TTITLE "Felhasználók, akik 2009.01.01 és 2012.12.31 között leadott rendelésében a terméket legalább két példányban rendelte meg"
BTITLE ""
COLUMN felhasznaloi_nev FORMAT A15 HEADING 'Felhasználói|név';
COLUMN rendelt_darabszam FORMAT 99 HEADING 'Rendelt|darabszám';
SELECT felhasznaloi_nev, SUM(rendelt_darabszam) As "Darab" FROM megrendelesek WHERE megrendeles_ideje BETWEEN TO_DATE('2009.01.01', 'YYYY.MM.DD') AND TO_DATE('2012.12.31', 'YYYY.MM.DD') GROUP BY felhasznaloi_nev HAVING SUM(rendelt_darabszam) > 1 ORDER BY felhasznaloi_nev;

CLEAR COLUMNS;
TTITLE OFF;
BTITLE OFF;
SET FEEDBACK ON;