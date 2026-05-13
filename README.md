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

***Version actuelle: p7.0***
- Version du parseur concernant le sous-fragment 7.0 (let \_;)
- Répartition du travail:
	- Nino BERNARD: Intégralité du sous-fragment.
- Un conflit shift/reduce est présent entre les variables et le mot-clé let. Il est résolu arbitrairement en modifiant l'ordre des règles de lexing de sorte à prioriser let.
- Ajout du fichier test *test_let*