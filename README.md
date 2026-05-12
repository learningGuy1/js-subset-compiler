# Projet Compilation 2026

Branche "ast" du projet. Branche de travail portant sur la manipulation des Arbres Syntaxiques Abstraits (Abstract Syntax Tree)

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
- Prend également en compte les changements du Fragment 5 (fonctions) qui ont par erreur été effectués dans parser_work
- Répartition du travail:
<<<<<<< HEAD
	- Edwin KAMTO: Fragment 4.0 ( _opérateur &&_ ), Fragment 4.1 ( _Ifthenelse_ ), Fragment 4.3 ( _Groupage d'instructions_ )
	- Nino BERNARD: Fragment 4.2 (_do_while__) + _while_
- Ajout de fichiers tests *test_et*, *test_if* et *test_while*
- Modification de *test_var* pour tester l'associativité

## Problèmes fixés

- Fix d'une mauvaise gestion de l'associativité de l'opérateur d'assignement ( _=_ )
=======
-
=======
	- Nino BERNARD: Intégralité du sous-fragment.
- Ajout du fichier test *test_undefined*
- Ajout des fichiers tests *test_fonctions1*, *test_fonctions2*, *test_fonctions2*, *test_opti*, *test_type_dynamique1* et *test_type dynamique2* jusque-là absents de la branche parser.

## Problèmes fixés

- Suppression d'un token inutilisé (EPSILON)
>>>>>>> parser
