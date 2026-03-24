# Projet Compilation 2026

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

- La commande make clean efface maintenant bien tous les fichiers hors main créés à la construction
- Passage à la manipulation de fichiers en entrée/sortie
- Ajout des Booléens
