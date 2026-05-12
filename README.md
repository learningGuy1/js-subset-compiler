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
- Un conflit shift/reduce est présent entre les variables et *undefined*. Il est résolu arbitrairement en modifiant l'ordre des règles de lexing de sorte à prioriser undefined.
- Comportement de *undefined* dans les opérations:
	- Erreur quand utilisé dans des opérateurs arithmétiques car NaN n'est pas autorisé en assembleur
	- Quand utilisé avec des opérateurs booléens/là où un booléen est attendu, cast en *false*.
- **NOTE: le choix de cast *undefined* en *false* est fait pour se rapprocher du vrai fonctionnement de JavaScript, mais nécessite en contrepartie l'utilisation de Drop qui n'est autorisé qu'au fragment 9.0**
- Ajout des fichiers tests *test_undefined1* et *test*undefined2*

## Problèmes fixés

- Suppression d'un token inutilisé (EPSILON)
