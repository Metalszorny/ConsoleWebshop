SET FEEDBACK OFF;

SAVEPOINT mentes;

ACCPET tabla PROMPT 'Módosítani kívánt tábla neve: ';
ACCPET ujtabla PROMPT 'Mi legyen a tábla új neve: ';
ACCEPT oszlop PROMPT 'Módosítani kívánt oszlop neve: ';
ACCEPT ujoszlop PROMPT 'Mi legyen az oszlop új neve: ';
ALTER TABLE &tabla RENAME COLUMN &oszlop TO &ujoszlop;
ALTER TABLE &tabla RENAME TO &ujtabla;
TTITLE "Oszlop törlése"
BTITLE ""
DESC &ujtabla;

ROLLBACK TO SAVEPOINT mentes;
COMMIT;