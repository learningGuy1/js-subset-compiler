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

***Version actuelle: c3.2***
- Modification de AST.ml pour permettre une optimisation au moment de la compilation
- Ce fragment ne nécessitant pas de modification d'autres fichiers, aucun tag p3.2 n'a été fait puisque le lexeur et le parseur n'ont pas été changés depuis la version précédente.
- Ajout du fichier test *test_opti* pour tester l'optimisation implémentée.
