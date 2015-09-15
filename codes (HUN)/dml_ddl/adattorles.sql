SET FEEDBACK OFF;

SAVEPOINT mentes;

TTITLE "A 0 darabszámú termékek törlése"
BTITLE ""
CLEAR COLUMNS;
COLUMN termek_azonosito FORMAT 99 HEADING 'Termék|azonosító';
COLUMN termek_neve FORMAT A15 HEADING 'Termék|neve';
COLUMN gyarto_neve FORMAT A15 HEADING 'Cég|neve';
COLUMN termek_egysegara FORMAT 99999 HEADING 'Termék|egységára';
COLUMN termek_tipusa FORMAT A15 HEADING 'Termék|típusa';
COLUMN gyartasi_ido HEADING 'Gyártási|idõ';
COLUMN raktaron_darabszam FORMAT 99 HEADING 'Raktáron|darabszám';
COLUMN termek_leirasa FORMAT A100 HEADING 'Termék|leírása';
DELETE termekek WHERE raktaron_darabszam < 1;
SELECT * FROM termekek;

TTITLE "A rendelés utáni 0 darabszámú termékek törlése"
BTITLE ""
DELETE termekek WHERE raktaron_darabszam < ANY (SELECT (t.raktaron_darabszam - m.rendelt_darabszam) FROM megrendelesek m, termekek t WHERE t.termek_azonosito = m.termek_azonosito GROUP BY t.termek_azonosito);
SELECT * FROM termekek;

ROLLBACK TO SAVEPOINT mentes;
COMMIT;