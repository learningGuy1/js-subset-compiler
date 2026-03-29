# Projet Compilation 2026


Branche "edwin_perso" du projet.

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

