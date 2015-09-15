SET FEEDBACK OFF;

ACCEPT megsz PROMPT '�j megszor�t�s neve neve: ';
ALTER TABLE termekek ADD CONSTRAINT '&megsz' CHECK (raktaron_darabszam >= 0);
CLEAR COLUMNS;
COLUMN termek_azonosito FORMAT 99 HEADING 'Term�k|azonos�t�';
COLUMN termek_neve FORMAT A15 HEADING 'Term�k|neve';
COLUMN gyarto_neve FORMAT A15 HEADING 'C�g|neve';
COLUMN termek_egysegara FORMAT 99999 HEADING 'Term�k|egys�g�ra';
COLUMN termek_tipusa FORMAT A15 HEADING 'Term�k|t�pusa';
COLUMN gyartasi_ido HEADING 'Gy�rt�si|id�';
COLUMN raktaron_darabszam FORMAT 99 HEADING 'Rakt�ron|darabsz�m';
COLUMN termek_leirasa FORMAT A100 HEADING 'Term�k|le�r�sa';
TTITLE "Megszor�t�s hozz�ad�sa"
BTITLE ""
SELECT CONSTRAINT_NAME AS "Megszor�t�s Neve", CONSTRAINT_TYPE AS "Megszor�t�s t�pusa" FROM USER_CONSTRAINTS WHERE UPPER(TABLE_NAME) IN ('TERMEKEK') AND UPPER(CONSTRAINT_NAME) NOT LIKE '%SYS%';

Clear columns;

ALTER TABLE termekek DROP CONSTRAINT '&megsz';
ALTER TABLE termekek ADD CONSTRAINT '&megsz' CHECK (raktaron_darabszam > -1) ENABLE NOVALIDATE;
TTITLE "�j megszor�t�s m�dos�t�sa"
BTITLE ""
SELECT CONSTRAINT_NAME AS "Megszor�t�s Neve", CONSTRAINT_TYPE AS "Megszor�t�s t�pusa" FROM USER_CONSTRAINTS WHERE UPPER(TABLE_NAME) IN ('TERMEKEK') AND UPPER(CONSTRAINT_NAME) NOT LIKE '%SYS%';

ALTER TABLE termekek DROP CONSTRAINT '&megsz';
TTITLE "�j megszor�t�s t�rl�se"
BTITLE ""
SELECT CONSTRAINT_NAME AS "Megszor�t�s Neve", CONSTRAINT_TYPE AS "Megszor�t�s t�pusa" FROM USER_CONSTRAINTS WHERE UPPER(TABLE_NAME) IN ('TERMEKEK') AND UPPER(CONSTRAINT_NAME) NOT LIKE '%SYS%';