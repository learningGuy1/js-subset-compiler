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

***Version actuelle: c5.0/c5.1***
- Version du projet concernant les fragments 5.0 et 5.1
- Répartition du travail:
	- Edwin KAMTO: Fragment 5.0 ( CALL ), Fragment 5.1 (déclaration de fonctions)
	- Nino BERNARD: Debug et repositionnement des déclarations dans le code assembleur
	
- Ajout de fichiers test *test_fonctions1* et *test_fonctions2*


## Problèmes fixés
- Fix du calcul du offset pour le IfThenElse qui calculait la taille du code else deux fois au lieu de calculer celui du then