SET FEEDBACK OFF;

SAVEPOINT mentes;

ACCPET tabla PROMPT 'M�dos�tani k�v�nt t�bla neve: ';
ACCPET ujtabla PROMPT 'Mi legyen a t�bla �j neve: ';
ACCEPT oszlop PROMPT 'M�dos�tani k�v�nt oszlop neve: ';
ACCEPT ujoszlop PROMPT 'Mi legyen az oszlop �j neve: ';
ALTER TABLE &tabla RENAME COLUMN &oszlop TO &ujoszlop;
ALTER TABLE &tabla RENAME TO &ujtabla;
TTITLE "Oszlop t�rl�se"
BTITLE ""
DESC &ujtabla;

ROLLBACK TO SAVEPOINT mentes;
COMMIT;