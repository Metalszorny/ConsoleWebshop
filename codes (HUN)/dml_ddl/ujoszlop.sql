SET FEEDBACK OFF;

ACCPET tabla PROMPT 'M�dos�tani k�v�nt t�bla neve: ';
ACCEPT oszlop PROMPT '�j oszlop neve: ';
ALTER TABLE &tabla ADD (&oszlop VARCHAR2(15));
TTITLE "�j oszlop hozz�ad�sa"
BTITLE ""
DESC &tabla;

ALTER TABLE &tabla DROP COLUMN &oszlop;