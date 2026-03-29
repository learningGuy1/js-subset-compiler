# Projet Compilation 2026

<<<<<<< HEAD
Branche "main" du projet.
=======
Branche "ast" du projet. Branche de travail portant sur la manipulation des Arbres Syntaxiques Abstraits (Abstract Syntax Tree)
=======
Branche "parser_work" du projet.  
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

# Changements

- La commande make clean affecte également l'executable
- Fix de la lecture de fichier
- Fix de la grammaire
- Le main peut maintenant lire plusieurs commandes successives
- La generation d'AST fonctionne maintenant aussi sur les booléens et opérateurs associés

>>>>>>> ast
