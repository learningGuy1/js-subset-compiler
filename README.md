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

# Changements

- Double version du parseur concernant les parties p3.0 et p3.1
- Ajout des variables
- Ajout des commentaires simples et multi-lignes
- Modification du main pour imprimer les messages d'erreur dans le terminal et distinguer les erreurs de lexing et de parsing
- Ajout de fichiers tests *test_ast*, *test_commentaires*, *test_flottants_scientifiques* et *test_var* pour tester les différentes parties du projet
- Le fichier AST.ml n'est plus suivi dans cette branche (il s'agissait d'un ajout superflu sur un commit précédent)
