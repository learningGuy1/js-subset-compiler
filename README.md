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

***Version actuelle: p4.0/p4.1/p4.2/p4.3)***
- Version du parseur concernant le fragment 4 entier. Le tag p4.3 est utilisé par souci de lisibilité des versions.
- Répartition du travail:
	- Edwin KAMTO: Fragment 4.0 ( _opérateur &&_ ), Fragment 4.1 ( _If_ ), Fragment 4.3 ( _Groupage d'instructions_ )
	- Nino BERNARD: Fragment 4.2 (_do_while__) + _while_
- Ajout de fichiers tests *test_et*, *test_if* et *test_while*
- Modification de *test_var* pour tester l'associativité

## Problèmes fixés

- Fix d'une mauvaise gestion de l'associativité de l'opérateur d'assignement ( _=_ )