SET FEEDBACK OFF;

ACCEPT lista PROMPT 'Melyik t�bl�t list�zzam: ';
TTITLE "T�bla tartalm�nak list�z�sa"
BTITLE ""
SELECT * FROM &lista;