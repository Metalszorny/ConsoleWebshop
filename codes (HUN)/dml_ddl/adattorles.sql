SET FEEDBACK OFF;

SAVEPOINT mentes;

TTITLE "A 0 darabsz�m� term�kek t�rl�se"
BTITLE ""
CLEAR COLUMNS;
COLUMN termek_azonosito FORMAT 99 HEADING 'Term�k|azonos�t�';
COLUMN termek_neve FORMAT A15 HEADING 'Term�k|neve';
COLUMN gyarto_neve FORMAT A15 HEADING 'C�g|neve';
COLUMN termek_egysegara FORMAT 99999 HEADING 'Term�k|egys�g�ra';
COLUMN termek_tipusa FORMAT A15 HEADING 'Term�k|t�pusa';
COLUMN gyartasi_ido HEADING 'Gy�rt�si|id�';
COLUMN raktaron_darabszam FORMAT 99 HEADING 'Rakt�ron|darabsz�m';
COLUMN termek_leirasa FORMAT A100 HEADING 'Term�k|le�r�sa';
DELETE termekek WHERE raktaron_darabszam < 1;
SELECT * FROM termekek;

TTITLE "A rendel�s ut�ni 0 darabsz�m� term�kek t�rl�se"
BTITLE ""
DELETE termekek WHERE raktaron_darabszam < ANY (SELECT (t.raktaron_darabszam - m.rendelt_darabszam) FROM megrendelesek m, termekek t WHERE t.termek_azonosito = m.termek_azonosito GROUP BY t.termek_azonosito);
SELECT * FROM termekek;

ROLLBACK TO SAVEPOINT mentes;
COMMIT;