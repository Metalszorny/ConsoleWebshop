SET FEEDBACK OFF;
ALTER SESSION SET NLS_DATE_LANGUAGE = ENGLISH;
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY.MM.DD';

TTITLE "Felhaszn�l�k, akik id�sebbek az �sszes l�nyn�l"
BTITLE ""
COLUMN felhasznalo_neve FORMAT A15 HEADING 'Felhaszn�l�|neve';
COLUMN felhasznalo_szuletesi_ideje HEADING 'Felhaszn�l�|sz�let�si ideje';
SELECT felhasznalo_neve, felhasznalo_szuletesi_ideje FROM felhasznalok WHERE felhasznalo_szuletesi_ideje < ALL (SELECT felhasznalo_szuletesi_ideje FROM felhasznalok WHERE felhasznalo_neme = 'n�') ORDER BY felhasznalo_neve DESC;

TTITLE "A Mucs�r�l sz�rmaz� felhaszn�l�k �s rendel�seinek term�knevei"
BTITLE ""
COLUMN termek_neve FORMAT A15 HEADING 'Term�k|neve';
COLUMN felhasznalo_neve FORMAT A15 HEADING 'Felhaszn�l�|neve';
SELECT f.felhasznalo_neve, t.termek_neve FROM megrendelesek m, termekek t, felhasznalok f WHERE f.felhasznaloi_nev = ANY (SELECT felhasznaloi_nev FROM felhasznalok WHERE felhasznalo_cime LIKE "%Mucsa") AND m.termek_azonosito = t.termek_azonosito AND f.felhasznaloi_nev = m.felhasznaloi_nev ORDER BY f.felhasznalo_neve;

TTITLE "Term�kek, amikb�l nem rendeltek"
BTITLE ""
COLUMN termek_neve FORMAT A15 HEADING 'Term�k|neve';
SELECT termek_neve FROM termekek WHERE termek_azonosito NOT IN (SELECT termek_azonosito FROM termekek, megrendelesek WHERE termekek.termek_azonosito = megrendelesek.termek_azonosito) ORDER BY termek_neve;

TTITLE "Statisztikai adatok a rendelt term�kekb�l t�pusra bontva"
BTITLE ""
COLUMN termek_tipusa FORMAT A25 HEADING 'Term�k|t�pusa';
SELECT t.termek_tipusa, MAX(t.termek_egysegara) AS "Legdr�g�bb", MIN(t.termek_egysegara) AS "Legolcs�bb", ROUND(AVG(t.termek_egysegara)) AS "�tlag�r", SUM(m.rendelt_darabszam) AS "Rendelt darab" FROM termekek t, megrendelesek m WHERE t.termek_azonosito = m.termek_azonosito GROUP BY t.termek_tipusa ORDER BY t.termek_tipusa;

TTITLE "A 2007-ben regisztr�ltak list�ja"
BTITLE ""
COLUMN felhasznalo_neve FORMAT A15 HEADING 'Felhaszn�l�|neve';
COLUMN regisztracio_ideje HEADING 'Regisztr�ci�|ideje';
SELECT felhasznalo_neve, regisztracio_ideje FROM felhasznalok WHERE regisztracio_ideje IN (SELECT regisztracio_ideje FROM felhasznalok WHERE TO_CHAR(regisztracio_ideje) LIKE TO_CHAR('2007.%')) ORDER BY regisztracio_ideje;

CLEAR COLUMNS;
TTITLE OFF;
BTITLE OFF;
SET FEEDBACK ON;