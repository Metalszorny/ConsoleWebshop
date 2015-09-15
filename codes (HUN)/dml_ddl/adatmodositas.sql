SET FEEDBACK OFF;
ALTER SESSION SET NLS_DATE_LANGUAGE = ENGLISH;
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY.MM.DD';

SAVEPOINT mentes;

TTITLE "Jelsz�m�dos�t�s"
BTITLE ""
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
ACCEPT jelszo PROMPT 'Mi legyen az �j jelsz�: ';
UPDATE felhasznalok SET felhasznaloi_jelszo = '&jelszo' WHERE LOWER(felhasznaloi_jelszo) LIKE '%notreble%';
SELECT * FROM felhasznalok WHERE LOWER(felhasznaloi_jelszo) LIKE LOWER('%&jelszo%');

CLEAR COLUMNS;
COLUMN termek_azonosito FORMAT 99 HEADING 'Term�k|azonos�t�';
COLUMN termek_neve FORMAT A15 HEADING 'Term�k|neve';
COLUMN gyarto_neve FORMAT A15 HEADING 'C�g|neve';
COLUMN termek_egysegara FORMAT 99999 HEADING 'Term�k|egys�g�ra';
COLUMN termek_tipusa FORMAT A15 HEADING 'Term�k|t�pusa';
COLUMN gyartasi_ido HEADING 'Gy�rt�si|id�';
COLUMN raktaron_darabszam FORMAT 99 HEADING 'Rakt�ron|darabsz�m';
COLUMN termek_leirasa FORMAT A100 HEADING 'Term�k|le�r�sa';
TTITLE "Rakt�ri darabsz�m m�dos�t�s rendel�s ut�n"
BTITLE ""
UPDATE termekek SET raktaron_darabszam = (t.raktaron_darabszam - m.rendelt_darabszam) WHERE raktaron_darabszam < ANY (SELECT (t.raktaron_darabszam - m.rendelt_darabszam) FROM megrendelesek m, termekek t WHERE t.termek_azonosito = m.termek_azonosito GROUP BY t.termek_azonosito);
SELECT * FROM termekek;

ROLLBACK TO SAVEPOINT mentes;
COMMIT;