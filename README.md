# Projet Compilation 2026

Branche "ast" du projet. Branche de travail portant sur la manipulation des Arbres Syntaxiques Abstraits (Abstract Syntax Tree)

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

- Double version du parseur concernant les parties p3.0 et p3.1
- Ajout des variables
- Ajout des commentaires simples et multi-lignes
- Modification du main pour imprimer les messages d'erreur dans le terminal et distinguer les erreurs de lexing et de parsing
- Ajout de fichiers tests *test_ast*, *test_commentaires*, *test_flottants_scientifiques* et *test_var* pour tester les différentes parties du projet
- Modifications mineures des fonctions d'affichage de AST.ml
