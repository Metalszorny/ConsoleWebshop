SET FEEDBACK OFF;

DROP TABLE megrendelesek;
DROP TABLE termekek;
DROP TABLE gyartok;
DROP TABLE felhasznalok;

ALTER SESSION SET NLS_DATE_LANGUAGE = ENGLISH;
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY.MM.DD';

CREATE TABLE felhasznalok(
felhasznaloi_nev VARCHAR2(15) NOT NULL,
felhasznaloi_jelszo VARCHAR2(15) NOT NULL,
felhasznalo_neve VARCHAR2(20) NOT NULL,
felhasznalo_iranyitoszama NUMBER(4) NOT NULL,
felhasznalo_cime VARCHAR2(25) NOT NULL,
felhasznalo_telefonszama NUMBER(9) NOT NULL,
felhasznalo_email_cime VARCHAR2(30) NOT NULL,
felhasznalo_neme VARCHAR2(5) NOT NULL,
felhasznalo_szuletesi_ideje DATE NOT NULL,
regisztracio_ideje DATE Not Null,
CONSTRAINT kulcs_felhasznalo PRIMARY KEY (felhasznaloi_nev, felhasznaloi_jelszo),
CONSTRAINT megsz_uniq_felhasznalo UNIQUE (felhasznalo_email_cime),
CONSTRAINT megsz_chec_felhasz_email CHECK (INSTR(felhasznalo_email_cime, '@') != 0),
CONSTRAINT megsz_chec_felhasz_regido CHECK (regisztracio_ideje < TO_DATE('2013.10.07', 'YYYY.MM.DD')),
CONSTRAINT megsz_chec_felhasz_szulido CHECK (felhasznalo_szuletesi_ideje < TO_DATE('2013.10.07', 'YYYY.MM.DD')),
CONSTRAINT megsz_chec_felhasz_nem CHECK ((felhasznalo_neme = 'nõ') OR ( felhasznalo_neme = 'férfi')));

CREATE TABLE gyartok(
gyarto_neve VARCHAR2(15) NOT NULL,
ceg_tipusa VARCHAR2(3) NOT NULL,
ceg_alapitasa DATE NOT NULL,
ceg_iranyitoszama NUMBER(5) NOT NULL,
ceg_cime VARCHAR2(30) NOT NULL,
ceg_vezetoje VARCHAR2(20) NOT NULL,
ceg_honlapja VARCHAR2(25) NOT NULL,
ceg_email_cime VARCHAR2(25) NOT NULL,
ceg_telefonszama NUMBER(9) NOT NULL,
CONSTRAINT kulcs_gyartok PRIMARY KEY (gyarto_neve),
CONSTRAINT megsz_uniq_ceg UNIQUE (ceg_email_cime),
CONSTRAINT megsz_chec_ceg_email CHECK (INSTR(ceg_email_cime, '@') != 0),
CONSTRAINT megsz_chec_ceg_alapido CHECK (ceg_alapitasa < TO_DATE('2013.10.07', 'YYYY.MM.DD')));

CREATE TABLE termekek(
termek_azonosito NUMBER(2) NOT NULL,
termek_neve VARCHAR2(40) NOT NULL,
gyarto_neve VARCHAR2(15) NOT NULL,
termek_egysegara NUMBER(5) NOT NULL,
termek_tipusa VARCHAR2(15) NOT NULL,
gyartasi_ido DATE NOT NULL,
raktaron_darabszam NUMBER(5),
termek_leirasa VARCHAR2(100) NOT NULL,
CONSTRAINT kulcs_termekek PRIMARY KEY (termek_azonosito),
CONSTRAINT idegk_termekek FOREIGN KEY (gyarto_neve) REFERENCES gyartok(gyarto_neve),
CONSTRAINT megsz_chec_egysegar CHECK (termek_egysegara > 0),
CONSTRAINT megsz_chec_gyartas CHECK (gyartasi_ido < TO_DATE('2013.10.07', 'YYYY.MM.DD')));

CREATE TABLE megrendelesek(
rendelesi_azonosito NUMBER(2) NOT NULL,
rendelesi_szam NUMBER(2) NOT NULL,
fizetes_modja VARCHAR2(20) NOT NULL,
megrendeles_ideje DATE NOT NULL,
atvetel_futarral VARCHAR2(4) NOT NULL,
vegso_ar NUMBER(10) NOT NULL,
rendelt_darabszam NUMBER(2) NOT NULL,
felhasznaloi_nev VARCHAR2(15) NOT NULL,
felhasznaloi_jelszo VARCHAR2(15) NOT NULL,
termek_azonosito NUMBER(2) NOT NULL,
CONSTRAINT kulcs_megrendelesek PRIMARY KEY (rendelesi_azonosito),
CONSTRAINT idegk_megrendelesek1 FOREIGN KEY (termek_azonosito) REFERENCES termekek(termek_azonosito),
CONSTRAINT idegk_megrendelesek2 FOREIGN KEY (felhasznaloi_nev, felhasznaloi_jelszo) REFERENCES felhasznalok(felhasznaloi_nev, felhasznaloi_jelszo),
CONSTRAINT megsz_chec_megrend_darab CHECK (rendelt_darabszam > 0),
CONSTRAINT megsz_chec_megrend_ar CHECK (vegso_ar > 0),
CONSTRAINT megsz_chec_megrend_rendido CHECK (megrendeles_ideje < TO_DATE('2013.10.07', 'YYYY.MM.DD')));