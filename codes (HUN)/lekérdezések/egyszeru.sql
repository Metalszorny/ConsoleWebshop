SET FEEDBACK OFF;

TTITLE "Felhaszn�l�k, akiknek a telefonsz�ma 10-es k�rzetsz�m�"
BTITLE ""
COLUMN felhasznalo_neve FORMAT A15 HEADING 'Felhaszn�l�|neve';
COLUMN felhasznalo_telefonszama FORMAT 999999999 HEADING 'Felhaszn�l�|telefonsz�ma';
SELECT felhasznalo_neve, felhasznalo_telefonszama FROM felhasznalok WHERE felhasznalo_telefonszama LIKE '10%' ORDER BY felhasznalo_neve;

TTITLE "Term�kek, amik j�t�k t�p�s�ak, a nev�k szerint sorbarendezve"
BTITLE ""
COLUMN termek_neve FORMAT A15 HEADING 'Term�k|neve';
SELECT termek_neve AS "Term�k neve" FROM termekek WHERE upper(termek_tipusa) = upper('j�t�k') ORDER BY termek_neve;

TTITLE "Rendel�sek, amelyek �sszege nagyobb, vagy egyenl�, mint 500"
BTITLE ""
COLUMN felhasznaloi_nev FORMAT A15 HEADING 'Felhaszn�l�i|n�v';
COLUMN fizetes_modja FORMAT A20 HEADING 'Fizet�s|m�dja';
SELECT felhasznaloi_nev AS "Felhaszn�l�i n�v", fizetes_modja AS "Fizet�s m�dja" FROM megrendelesek WHERE vegso_ar >= 500 ORDER BY felhasznaloi_nev;

CLEAR COLUMNS;
TTITLE OFF;
BTITLE OFF;
SET FEEDBACK ON;