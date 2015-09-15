SET FEEDBACK OFF;

ACCEPT megsz PROMPT 'Új megszorítás neve neve: ';
ALTER TABLE termekek ADD CONSTRAINT '&megsz' CHECK (raktaron_darabszam >= 0);
CLEAR COLUMNS;
COLUMN termek_azonosito FORMAT 99 HEADING 'Termék|azonosító';
COLUMN termek_neve FORMAT A15 HEADING 'Termék|neve';
COLUMN gyarto_neve FORMAT A15 HEADING 'Cég|neve';
COLUMN termek_egysegara FORMAT 99999 HEADING 'Termék|egységára';
COLUMN termek_tipusa FORMAT A15 HEADING 'Termék|típusa';
COLUMN gyartasi_ido HEADING 'Gyártási|idõ';
COLUMN raktaron_darabszam FORMAT 99 HEADING 'Raktáron|darabszám';
COLUMN termek_leirasa FORMAT A100 HEADING 'Termék|leírása';
TTITLE "Megszorítás hozzáadása"
BTITLE ""
SELECT CONSTRAINT_NAME AS "Megszorítás Neve", CONSTRAINT_TYPE AS "Megszorítás típusa" FROM USER_CONSTRAINTS WHERE UPPER(TABLE_NAME) IN ('TERMEKEK') AND UPPER(CONSTRAINT_NAME) NOT LIKE '%SYS%';

Clear columns;

ALTER TABLE termekek DROP CONSTRAINT '&megsz';
ALTER TABLE termekek ADD CONSTRAINT '&megsz' CHECK (raktaron_darabszam > -1) ENABLE NOVALIDATE;
TTITLE "Új megszorítás módosítása"
BTITLE ""
SELECT CONSTRAINT_NAME AS "Megszorítás Neve", CONSTRAINT_TYPE AS "Megszorítás típusa" FROM USER_CONSTRAINTS WHERE UPPER(TABLE_NAME) IN ('TERMEKEK') AND UPPER(CONSTRAINT_NAME) NOT LIKE '%SYS%';

ALTER TABLE termekek DROP CONSTRAINT '&megsz';
TTITLE "Új megszorítás törlése"
BTITLE ""
SELECT CONSTRAINT_NAME AS "Megszorítás Neve", CONSTRAINT_TYPE AS "Megszorítás típusa" FROM USER_CONSTRAINTS WHERE UPPER(TABLE_NAME) IN ('TERMEKEK') AND UPPER(CONSTRAINT_NAME) NOT LIKE '%SYS%';