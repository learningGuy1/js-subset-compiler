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

***Version actuelle: c5.2***
- Version du projet concernant le sous-fragment 5.2 (Cas d'erreur lors d'utilisation de fonctions)
- **NOTE:** l'instruction TypeOf a ici été utilisée, bien que seulement autorisée au fragment suivant, à défaut d'avoir trouvé un moyen de la contourner
- Répartition du travail:
	- Nino BERNARD: Intégralité du fragment.
- Ajout du fichier test *test_fonctions3*
