SET FEEDBACK OFF;

SAVEPOINT mentes;

ACCEPT tabla PROMPT 'Módosítani kívánt tábla neve: ';
ACCEPT oszlop PROMPT 'Törlendõ oszlop neve: ';
ALTER TABLE &tabla DROP COLUMN &oszlop;
TTITLE "Oszlop törlése"
BTITLE ""
DESC &tabla;

ROLLBACK TO SAVEPOINT mentes;
COMMIT;