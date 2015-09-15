SET FEEDBACK OFF;

TTITLE "Felhaszn�l�k rendel�seinek v�g�sszege"
BTITLE ""
COLUMN felhasznalo_neve FORMAT A15 HEADING 'Felhaszn�l�|neve';
SELECT f.felhasznalo_neve, SUM(m.vegso_ar) AS "V�g�sszeg" FROM felhasznalok f, megrendelesek m WHERE f.felhasznaloi_nev = m.felhasznaloi_nev GROUP BY f.felhasznalo_neve ORDER BY SUM(m.vegso_ar);

TTITLE "A gy�rt�k forgalmazott term�keinek sz�ma"
BTITLE ""
COLUMN gyarto_neve FORMAT A15 HEADING 'C�g|neve';
SELECT gy.gyarto_neve, COUNT(t.termek_neve) AS "Term�k", SUM(raktaron_darabszam) AS "Term�kek sz�ma" FROM gyartok gy, termekek t WHERE gy.gyarto_neve = t.gyarto_neve GROUP BY gy.gyarto_neve ORDER BY gy.gyarto_neve;

TTITLE "Melyik gy�rt�t�l mennyit rendeltek a felhaszn�l�k"
BTITLE ""
COLUMN gyarto_neve FORMAT A15 HEADING 'C�g|neve';
SELECT gy.gyarto_neve, COUNT(t.gyarto_neve) AS "Felhaszn�l�k sz�ma" FROM gyartok gy, (SELECT f.gyarto_neve FROM termekek f, megrendelesek m WHERE f.termek_azonosito = m.termek_azonosito ORDER BY f.termek_neve) t WHERE t.gyarto_neve = gy.gyarto_neve GROUP BY gy.gyarto_neve ORDER BY gy.gyarto_neve;

CLEAR COLUMNS;
TTITLE OFF;
BTITLE OFF;
SET FEEDBACK ON;