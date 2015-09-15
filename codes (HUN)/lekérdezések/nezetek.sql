SET FEEDBACK OFF;

TTITLE "L�nyok �s rendel�seik"
BTITLE ""
COLUMN felhasznalo_neve FORMAT A15 HEADING 'Felhaszn�l�|neve';
COLUMN termek_neve FORMAT A15 HEADING 'Term�k|neve';
CREATE OR REPLACE VIEW lanyok AS (SELECT felhasznaloi_nev, felhasznalo_neve FROM felhasznalok WHERE lower(felhasznalo_neme) = lower('n�')) WITH READ ONLY;
SELECT f.felhasznalo_neve, t.termek_neve FROM lanyok f, termekek t, megrendelesek m WHERE f.felhasznaloi_nev = m.felhasznaloi_nev AND t.termek_azonosito = m.termek_azonosito ORDER BY f.felhasznalo_neve;
DROP VIEW lanyok;

TTITLE "A fi� �s l�ny j�t�kosok sz�ma"
BTITLE ""
COLUMN felhasznalo_neme FORMAT A15 HEADING 'Felhaszn�l�|neme';
CREATE OR REPLACE VIEW jatekosok AS (SELECT m.felhasznaloi_nev FROM megrendelesek m, termekek t WHERE m.termek_azonosito = t.termek_azonosito AND t.termek_tipusa = 'j�t�k') WITH READ ONLY;
SELECT f.felhasznalo_neme, COUNT(f.felhasznalo_neme) FROM felhasznalok f, jatekosok j where f.felhasznaloi_nev = j.felhasznaloi_nev;
DROP VIEW jatekosok;

TTITLE "Mennyi id�s volt a felhaszn�l�, mikor leadta a rendel�s�t"
BTITLE ""
COLUMN felhasznalo_neve FORMAT A15 HEADING 'Felhaszn�l�|neve';
CREATE OR REPLACE VIEW rendelt AS (SELECT felhasznaloi_nev, megrendeles_ideje FROM megrendelesek) WITH READ ONLY;
SELECT f.felhasznalo_neve, (TO_DATE(f.regisztracio_ideje, 'YYYY') - TO_DATE(r.megrendeles_ideje, 'YYYY')) AS "Kor" FROM felhasznalok f, rendelt r WHERE r.felhasznaloi_nev = f.felhasznaloi_nev GROUP BY f.felhasznalo_neve ORDER BY (TO_DATE(f.regisztracio_ideje, 'YYYY') - TO_DATE(r.megrendeles_ideje, 'YYYY')) DESC;
DROP VIEW rendelt;

CLEAR COLUMNS;
TTITLE OFF;
BTITLE OFF;
SET FEEDBACK ON;