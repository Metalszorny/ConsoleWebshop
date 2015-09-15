SET FEEDBACK OFF;

TTITLE "Term�k t�pusok, amib�l legal�bb 3 darab van"
BTITLE ""
COLUMN termek_tipusa FORMAT A15 HEADING 'Term�k|t�pusa';
SELECT termek_tipusa, COUNT(termek_tipusa) AS "Darab" FROM termekek GROUP BY termek_tipusa HAVING COUNT(termek_tipusa) >= 3;

TTITLE "Felt�rhetetlen jelszav� felhaszn�l�k"
BTITLE ""
COLUMN felhasznalo_neve FORMAT A15 HEADING 'Felhaszn�l�|neve';
SELECT felhasznalo_neve, LENGTH(felhasznaloi_jelszo) AS "hossz" FROM felhasznalok WHERE LENGTH(felhasznaloi_jelszo) > 10;

TTITLE "Felhaszn�l�k, akik 2009.01.01 �s 2012.12.31 k�z�tt leadott rendel�s�ben a term�ket legal�bb k�t p�ld�nyban rendelte meg"
BTITLE ""
COLUMN felhasznaloi_nev FORMAT A15 HEADING 'Felhaszn�l�i|n�v';
COLUMN rendelt_darabszam FORMAT 99 HEADING 'Rendelt|darabsz�m';
SELECT felhasznaloi_nev, SUM(rendelt_darabszam) As "Darab" FROM megrendelesek WHERE megrendeles_ideje BETWEEN TO_DATE('2009.01.01', 'YYYY.MM.DD') AND TO_DATE('2012.12.31', 'YYYY.MM.DD') GROUP BY felhasznaloi_nev HAVING SUM(rendelt_darabszam) > 1 ORDER BY felhasznaloi_nev;

CLEAR COLUMNS;
TTITLE OFF;
BTITLE OFF;
SET FEEDBACK ON;