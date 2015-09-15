SET FEEDBACK OFF;
ALTER SESSION SET NLS_DATE_LANGUAGE = ENGLISH;
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY.MM.DD';

SAVEPOINT mentes;

CLEAR COLUMNS;
COLUMN gyarto_neve FORMAT A15 HEADING 'Cég|neve';
COLUMN ceg_tipusa FORMAT A3 HEADING 'Cég|típusa';
COLUMN ceg_alapitasa HEADING 'Cég|alapítása';
COLUMN ceg_iranyitoszama FORMAT 99999 HEADING 'Cég|irányítószáma';
COLUMN ceg_cime FORMAT A30 HEADING 'Cég|címe';
COLUMN ceg_vezetoje FORMAT A20 HEADING 'Cég|vezetõje';
COLUMN ceg_honlapja FORMAT A25 HEADING 'Cég|honlapja';
COLUMN ceg_email_cime FORMAT A25 HEADING 'Cég|e-mail címe';
COLUMN ceg_telefonszama FORMAT 999999999 HEADING 'Cég|telefonszáma';
ACCEPT neve PROMPT 'Mi legyen az új gyártó neve: ';
INSERT INTO gyartok VALUES ('&neve', 'inc', '2013.01.01', '2345', 'Magyarország, Budapest', 'Medve László', 'www.valami.sql', 'info@valami.sql', '999999999');
TTITLE "Adatbeszúrás"
BTITLE ""
SELECT * FROM gyartok;

ROLLBACK TO SAVEPOINT mentes;
COMMIT;