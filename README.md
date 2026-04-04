# Projet Compilation 2026

Branche "code_gen" du projet.
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

***Version actuelle: c3.0/c3.1***
- Double version du concernant les parties p3.0 et p3.1
- Ajout des variables
- Ajout des commentaires simples et multi-lignes
- Modification du main pour imprimer les messages d'erreur dans le terminal et distinguer les erreurs de lexing et de parsing
- Ajout de fichiers tests *test_ast*, *test_commentaires*, *test_flottants_scientifiques* et *test_var* pour tester les différentes parties du projet
- Modifications mineures des fonctions d'affichage de AST.ml
- Le fichier AST.ml n'est plus suivi dans cette branche (il s'agissait d'un ajout superflu sur un commit précédent)
- Ajout de fichiers tests *test_if_then_else*,pour tester les if then else parties du projet
- Ajout du '&&' ET-logique et reconnaissance du if then else fonctionne
- Modification de la grammaire pour integrer les commandes comme bloc de code dans des acollades '{}'
- Reconnaissance de ';' comme commande 
- Modification dans AST.ml pour générer l'abre des nouvelles if_then_else, Et_logique , commande ';' ainsi que le block "{code}" de commande


