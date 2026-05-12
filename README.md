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

***Version actuelle: c6.0/c6.1***
- Version du projet implémentant les sous-fragments 6.0 (casts implicites NbToBo) et 6.1 (casts implicites BoToNb)
- Répartition du travail:
	- Nino BERNARD: Intégralité des fragments.
- Ajout des fichiers test *test_type_dynamique1* et *test_type_dynamique2*

