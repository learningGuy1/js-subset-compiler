# Projet Compilation 2026

Branche "code_gen" du projet.
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

***Version actuelle: c2.1/c2.2***
- Ajout de la notation scientifique des flottants et de NaN
- Modification de la regexp des flottants pour plus de flexibilité
- Ajout de Halt à la fin du code assembleur généré
- Le fragment 2.2 ayant été implémenté dès le fragment 2.0, **la présente version sert aussi bien de fragment 2.2 que de fragment 2.3**.
- Les Drop non impératifs ne sont (pour l'instant) pas implémentés.