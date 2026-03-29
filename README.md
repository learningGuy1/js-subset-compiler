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

# Changements

- La commande make clean affecte également l'executable
- Fix de la lecture de fichier
- Fix de la grammaire
- Le main peut maintenant lire plusieurs commandes successives
- La generation d'AST fonctionne maintenant aussi sur les booléens et opérateurs associés
- la generation du code assembleur fonctionne pour les instructions assembleur Equals, GrEqNB etc...

