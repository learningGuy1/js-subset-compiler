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

***Version actuelle: p4.0/p4.1/p4.2/p4.3)***
- Début de typage dynamique: cast automatique en booléen dans les opérateurs booléens

## Problèmes fixés

- Fix du calcul du ConJump dans le code du IfThenElse qui sautait jusque-là aussi le else
