SET FEEDBACK OFF;

TTITLE "Felhasználók, akiknek a telefonszáma 10-es körzetszámú"
BTITLE ""
COLUMN felhasznalo_neve FORMAT A15 HEADING 'Felhasználó|neve';
COLUMN felhasznalo_telefonszama FORMAT 999999999 HEADING 'Felhasználó|telefonszáma';
SELECT felhasznalo_neve, felhasznalo_telefonszama FROM felhasznalok WHERE felhasznalo_telefonszama LIKE '10%' ORDER BY felhasznalo_neve;

TTITLE "Termékek, amik játék típúsúak, a nevük szerint sorbarendezve"
BTITLE ""
COLUMN termek_neve FORMAT A15 HEADING 'Termék|neve';
SELECT termek_neve AS "Termék neve" FROM termekek WHERE upper(termek_tipusa) = upper('játék') ORDER BY termek_neve;

TTITLE "Rendelések, amelyek összege nagyobb, vagy egyenlõ, mint 500"
BTITLE ""
COLUMN felhasznaloi_nev FORMAT A15 HEADING 'Felhasználói|név';
COLUMN fizetes_modja FORMAT A20 HEADING 'Fizetés|módja';
SELECT felhasznaloi_nev AS "Felhasználói név", fizetes_modja AS "Fizetés módja" FROM megrendelesek WHERE vegso_ar >= 500 ORDER BY felhasznaloi_nev;

CLEAR COLUMNS;
TTITLE OFF;
BTITLE OFF;
SET FEEDBACK ON;