# Projet Compilation 2026

Branche "parser" du projet.  
Branche de travail offrant un exécutable chargé de l'analyse lexicale et syntaxique du code JS en entrée et accepte un code correct dans le fragment implémenté

## Utilisation

- Construction

```bash
make
```

- Execution

```bash
./main [FICHIER EN ENTREE] [FICHIER EN SORTIE]
```
Le fichier en premier argument devra contenir une suite de commandes exécutables en JS.  
Le fichier en second argument contiendra le résultat de l'exécution.

## Changements

***Version actuelle: p8.0_8.1 (INCOMPLET)***
- Version du parseur concernant les sous-fragments 8.0 (null) et 8.1 (objets)
**NOTE: cette version est incomplète et n'est présente que pour attester de l'avancée du projet au moment du rendu**
- Répartition du travail:
	- Edwin KAMTO: Majorité des deux sous-fragments.
	- Nino BERNARD: Tentative de gestion des conflits et ajouts
- Présence de nombreux conflits shift/reduce non résolus
- Ajout du fichier test *test_objets*
