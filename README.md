# Projet Compilation 2026

Branche "main" du projet.
Branche de travail offrant un exécutable chargé de générer le code assembleur pour éxécuter le programme JS

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

***Version actuelle: c4.0/c4.1/c4.2/c4.3)***
- Version du projet concernant le fragment 4 entier. Le tag c4.3 est utilisé par souci de lisibilité des versions.
- Répartition du travail:
	- Edwin KAMTO: Fragment 4.0 ( _opérateur &&_ ), Fragment 4.1 ( _If_ ), Fragment 4.3 ( _Groupage d'instructions_ )
	- Nino BERNARD: Fragment 4.2 (_do_while__) + _while_
- Ajout de fichiers tests *test_et*, *test_if* et *test_while*
- Modification de *test_var* pour tester l'associativité
- Suppression de l'instruction *Halt* optionnelle en attendant de trouver comment garder sa génération

## Problèmes fixés

- Fix d'une mauvaise gestion de l'associativité de l'opérateur d'assignement ( _=_ )
