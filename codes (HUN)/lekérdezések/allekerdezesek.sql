SET FEEDBACK OFF;
ALTER SESSION SET NLS_DATE_LANGUAGE = ENGLISH;
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY.MM.DD';

TTITLE "Felhasználók, akik idõsebbek az összes lánynál"
BTITLE ""
COLUMN felhasznalo_neve FORMAT A15 HEADING 'Felhasználó|neve';
COLUMN felhasznalo_szuletesi_ideje HEADING 'Felhasználó|születési ideje';
SELECT felhasznalo_neve, felhasznalo_szuletesi_ideje FROM felhasznalok WHERE felhasznalo_szuletesi_ideje < ALL (SELECT felhasznalo_szuletesi_ideje FROM felhasznalok WHERE felhasznalo_neme = 'nõ') ORDER BY felhasznalo_neve DESC;

TTITLE "A Mucsáról származó felhasználók és rendeléseinek terméknevei"
BTITLE ""
COLUMN termek_neve FORMAT A15 HEADING 'Termék|neve';
COLUMN felhasznalo_neve FORMAT A15 HEADING 'Felhasználó|neve';
SELECT f.felhasznalo_neve, t.termek_neve FROM megrendelesek m, termekek t, felhasznalok f WHERE f.felhasznaloi_nev = ANY (SELECT felhasznaloi_nev FROM felhasznalok WHERE felhasznalo_cime LIKE "%Mucsa") AND m.termek_azonosito = t.termek_azonosito AND f.felhasznaloi_nev = m.felhasznaloi_nev ORDER BY f.felhasznalo_neve;

TTITLE "Termékek, amikbõl nem rendeltek"
BTITLE ""
COLUMN termek_neve FORMAT A15 HEADING 'Termék|neve';
SELECT termek_neve FROM termekek WHERE termek_azonosito NOT IN (SELECT termek_azonosito FROM termekek, megrendelesek WHERE termekek.termek_azonosito = megrendelesek.termek_azonosito) ORDER BY termek_neve;

TTITLE "Statisztikai adatok a rendelt termékekbõl típusra bontva"
BTITLE ""
COLUMN termek_tipusa FORMAT A25 HEADING 'Termék|típusa';
SELECT t.termek_tipusa, MAX(t.termek_egysegara) AS "Legdrágább", MIN(t.termek_egysegara) AS "Legolcsóbb", ROUND(AVG(t.termek_egysegara)) AS "Átlagár", SUM(m.rendelt_darabszam) AS "Rendelt darab" FROM termekek t, megrendelesek m WHERE t.termek_azonosito = m.termek_azonosito GROUP BY t.termek_tipusa ORDER BY t.termek_tipusa;

TTITLE "A 2007-ben regisztráltak listája"
BTITLE ""
COLUMN felhasznalo_neve FORMAT A15 HEADING 'Felhasználó|neve';
COLUMN regisztracio_ideje HEADING 'Regisztráció|ideje';
SELECT felhasznalo_neve, regisztracio_ideje FROM felhasznalok WHERE regisztracio_ideje IN (SELECT regisztracio_ideje FROM felhasznalok WHERE TO_CHAR(regisztracio_ideje) LIKE TO_CHAR('2007.%')) ORDER BY regisztracio_ideje;

CLEAR COLUMNS;
TTITLE OFF;
BTITLE OFF;
SET FEEDBACK ON;