SET FEEDBACK OFF;

SAVEPOINT mentes;

ACCEPT tabla PROMPT 'M�dos�tani k�v�nt t�bla neve: ';
ACCEPT oszlop PROMPT 'T�rlend� oszlop neve: ';
ALTER TABLE &tabla DROP COLUMN &oszlop;
TTITLE "Oszlop t�rl�se"
BTITLE ""
DESC &tabla;

ROLLBACK TO SAVEPOINT mentes;
COMMIT;