Despa Diana Alexandra 321CA

Tema 3 Paradigme de programare - Prolog: cautare intr-un spatiu infinit

	Ideea pe care se bazeaza implementarea temei este parcurgerea in spirala a
spatiului in sensul acelor de ceasornic, cu oprirea in camerele ce contin cutii,
urmata de intoarcerea in origine de catre robot. Cautarea se termina cand
robotul se afla in origine si nu mai are de livrat nicio cutie.
	Parcurgerea se realizeaza astfel: pornesc din origine(0, 0) cu o mutare
spre nord, apoi continui cu una spre est, urmeaza doua mutari consecutive spre
sud, apoi doua spre vest, trei spre nord s.a.m.d. Pentru fiecare portiune
formata dintr-o linie si o coloana de mutari consecutive in aceeasi directie
retin directia de mers, numarul de pasi facuti in linie/coloane, numarul maxim
de pasi si indicele liniei/coloanei din portiune(1 sau 2, maximul fiind 2).
Fiecare mutare este facuta pe baza celei anterioare. Cautarea continua atata
timp cat robotul nu a gasit o cutie.
	Atunci cand robotul se afla intr-o camera cu cutie el realizeaza actiunea
pickBox si actualizez structura ProgramData astfel incat sa indice ca el este
in curs de livrare. Cat timp acel parametru este setat cu valoarea 1, el nu
mai poate livra alte cutii. Mai departe el se deplaseaza catre origine,
mutandu-se pana in dreptul liniei 0 si apoi mergand pe linia 0 pana in origine.
	Dupa ce a livrat cutia la origine, cautarea este reluata in acelasi mod.
	Am implementat predicate auxiliare care determina urmatoarele directii de
miscare in functie de mutarea anterioara.
	Am reprezentat starile problemei in structura ProgramData sub forma unei
liste ce contine pe prima pozitie o pereche de coordonate care sunt actualizate
cu pozitia curenta a robotului, un indicator pentru livrare in curs, o lista
ce caracterizeaza ultima mutare (dintr-o portiune de mutari descrisa mai sus),
si numarul de cutii ce trebuie livrate. In starea initiala, robotul se afla
in origine, nu livreaza nicio cutie, nu exista o mutare anterioara si numarul
de cutii este cel dat ca prim argument predicatului initMyData.

	Persoane cu care am discutat despre tema:
	Bobescu Madalina
	Sima Alexandra