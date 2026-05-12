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

***Version actuelle: p6.2***
- Version du parseur concernant le sous-fragment 6.2 (undefined)
- Répartition du travail:
	- Nino BERNARD: Intégralité du sous-fragment.
- Ajout du fichier test test_undefined

## Problèmes fixés

- Suprression d'un token inutilisé (EPSILON)
