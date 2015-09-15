SET FEEDBACK OFF;

TTITLE "Felhasználók rendeléseinek végösszege"
BTITLE ""
COLUMN felhasznalo_neve FORMAT A15 HEADING 'Felhasználó|neve';
SELECT f.felhasznalo_neve, SUM(m.vegso_ar) AS "Végösszeg" FROM felhasznalok f, megrendelesek m WHERE f.felhasznaloi_nev = m.felhasznaloi_nev GROUP BY f.felhasznalo_neve ORDER BY SUM(m.vegso_ar);

TTITLE "A gyártók forgalmazott termékeinek száma"
BTITLE ""
COLUMN gyarto_neve FORMAT A15 HEADING 'Cég|neve';
SELECT gy.gyarto_neve, COUNT(t.termek_neve) AS "Termék", SUM(raktaron_darabszam) AS "Termékek száma" FROM gyartok gy, termekek t WHERE gy.gyarto_neve = t.gyarto_neve GROUP BY gy.gyarto_neve ORDER BY gy.gyarto_neve;

TTITLE "Melyik gyártótól mennyit rendeltek a felhasználók"
BTITLE ""
COLUMN gyarto_neve FORMAT A15 HEADING 'Cég|neve';
SELECT gy.gyarto_neve, COUNT(t.gyarto_neve) AS "Felhasználók száma" FROM gyartok gy, (SELECT f.gyarto_neve FROM termekek f, megrendelesek m WHERE f.termek_azonosito = m.termek_azonosito ORDER BY f.termek_neve) t WHERE t.gyarto_neve = gy.gyarto_neve GROUP BY gy.gyarto_neve ORDER BY gy.gyarto_neve;

CLEAR COLUMNS;
TTITLE OFF;
BTITLE OFF;
SET FEEDBACK ON;