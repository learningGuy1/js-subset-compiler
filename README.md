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

***Version actuelle: c7.1***
- Version du projet concernant le sous-fragment 7.1 (hoisting + interdiction d'avoir deux mêmes let dans un même bloc)
- Répartition du travail:
	- Nino BERNARD: Intégralité du sous-fragment.
- Renommage du fichier_test *test_let* en *test_let1*
- Ajout des fichiers tests *test_let2* et *test_let3*

## Problèmes fixés

- Fix du calcul des Jump/ConJmp dans les instructions conditionnelles While et DoWhile qui ne prennaient pas en compte les check/cast. 
- Rétablissement de l'instruction Halt en fin du programme principal
- Inversement de l'ordre des DclArg afin de respecter le fonctionnement de la mini-JSM plutôt que celui du cours

**NOTE: les deux derniers points rendent chaque code assembleur obtenu après execution lançable dans la mini-JSM sans modification manuelle préalable**
