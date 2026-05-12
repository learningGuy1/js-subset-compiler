# Projet Compilation 2026

Branche "main" du projet.
Branche de travail offrant un exécutable chargé de générer le code assembleur pour exécuter le programme JS

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

***Version actuelle: c6.2***
- Version du parseur concernant le sous-fragment 6.2 (undefined)
- Répartition du travail:
	- Nino BERNARD: Intégralité du sous-fragment.
- Un conflit shift/reduce est présent entre les variables et Undefined. Il est résolu arbitrairement en modifiant l'ordre des règles de lexing de sorte à prioriser undefined.
- Ajout du fichier test *test_undefined*
- Ajout des fichiers tests *test_fonctions1*, *test_fonctions2*, *test_fonctions2*, *test_opti*, *test_type_dynamique1* et *test_type dynamique2* jusque-là absents de la branche parser.

## Problèmes fixés

- Suppression d'un token inutilisé (EPSILON)
