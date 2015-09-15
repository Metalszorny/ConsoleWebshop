SET FEEDBACK OFF;

ACCEPT lista PROMPT 'Melyik táblát listázzam: ';
TTITLE "Tábla tartalmának listázása"
BTITLE ""
SELECT * FROM &lista;