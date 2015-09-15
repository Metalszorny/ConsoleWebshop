SET FEEDBACK OFF;
ALTER SESSION SET NLS_DATE_LANGUAGE = ENGLISH;
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY.MM.DD';

SAVEPOINT mentes;

TTITLE "Jelszómódosítás"
BTITLE ""
CLEAR COLUMNS;
COLUMN felhasznaloi_nev FORMAT A15 HEADING 'Felhasználói|név';
COLUMN felhasznaloi_jelszo FORMAT A15 HEADING 'Felhasználói|jelszó';
COLUMN felhasznalo_neve FORMAT A15 HEADING 'Felhasználó|neve';
COLUMN felhasznalo_iranyitoszama FORMAT 9999 HEADING 'Felhasználó|irányítószáma';
COLUMN felhasznalo_telefonszama FORMAT 999999999 HEADING 'Felhasználó|telefonszáma';
COLUMN felhasznaloi_email_cime FORMAT A25 HEADING 'Felhasználó|e-mail címe';
COLUMN felhasznaloi_neme FORMAT A5 HEADING 'Felhasználó|neme';
COLUMN felhasznalo_szuletesi_ideje HEADING 'Felhasználó|születési ideje';
COLUMN regisztracio_ideje HEADING 'Regisztráció|ideje';
ACCEPT jelszo PROMPT 'Mi legyen az új jelszó: ';
UPDATE felhasznalok SET felhasznaloi_jelszo = '&jelszo' WHERE LOWER(felhasznaloi_jelszo) LIKE '%notreble%';
SELECT * FROM felhasznalok WHERE LOWER(felhasznaloi_jelszo) LIKE LOWER('%&jelszo%');

CLEAR COLUMNS;
COLUMN termek_azonosito FORMAT 99 HEADING 'Termék|azonosító';
COLUMN termek_neve FORMAT A15 HEADING 'Termék|neve';
COLUMN gyarto_neve FORMAT A15 HEADING 'Cég|neve';
COLUMN termek_egysegara FORMAT 99999 HEADING 'Termék|egységára';
COLUMN termek_tipusa FORMAT A15 HEADING 'Termék|típusa';
COLUMN gyartasi_ido HEADING 'Gyártási|idõ';
COLUMN raktaron_darabszam FORMAT 99 HEADING 'Raktáron|darabszám';
COLUMN termek_leirasa FORMAT A100 HEADING 'Termék|leírása';
TTITLE "Raktári darabszám módosítás rendelés után"
BTITLE ""
UPDATE termekek SET raktaron_darabszam = (t.raktaron_darabszam - m.rendelt_darabszam) WHERE raktaron_darabszam < ANY (SELECT (t.raktaron_darabszam - m.rendelt_darabszam) FROM megrendelesek m, termekek t WHERE t.termek_azonosito = m.termek_azonosito GROUP BY t.termek_azonosito);
SELECT * FROM termekek;

ROLLBACK TO SAVEPOINT mentes;
COMMIT;