SET FEEDBACK OFF;

ACCPET tabla PROMPT 'Módosítani kívánt tábla neve: ';
ACCEPT oszlop PROMPT 'Új oszlop neve: ';
ALTER TABLE &tabla ADD (&oszlop VARCHAR2(15));
TTITLE "Új oszlop hozzáadása"
BTITLE ""
DESC &tabla;

ALTER TABLE &tabla DROP COLUMN &oszlop;