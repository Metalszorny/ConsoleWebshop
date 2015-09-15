SET FEEDBACK OFF;
ALTER SESSION SET NLS_DATE_LANGUAGE = ENGLISH;
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY.MM.DD';

SAVEPOINT mentes;

CLEAR COLUMNS;
COLUMN gyarto_neve FORMAT A15 HEADING 'C�g|neve';
COLUMN ceg_tipusa FORMAT A3 HEADING 'C�g|t�pusa';
COLUMN ceg_alapitasa HEADING 'C�g|alap�t�sa';
COLUMN ceg_iranyitoszama FORMAT 99999 HEADING 'C�g|ir�ny�t�sz�ma';
COLUMN ceg_cime FORMAT A30 HEADING 'C�g|c�me';
COLUMN ceg_vezetoje FORMAT A20 HEADING 'C�g|vezet�je';
COLUMN ceg_honlapja FORMAT A25 HEADING 'C�g|honlapja';
COLUMN ceg_email_cime FORMAT A25 HEADING 'C�g|e-mail c�me';
COLUMN ceg_telefonszama FORMAT 999999999 HEADING 'C�g|telefonsz�ma';
ACCEPT neve PROMPT 'Mi legyen az �j gy�rt� neve: ';
INSERT INTO gyartok VALUES ('&neve', 'inc', '2013.01.01', '2345', 'Magyarorsz�g, Budapest', 'Medve L�szl�', 'www.valami.sql', 'info@valami.sql', '999999999');
TTITLE "Adatbesz�r�s"
BTITLE ""
SELECT * FROM gyartok;

ROLLBACK TO SAVEPOINT mentes;
COMMIT;