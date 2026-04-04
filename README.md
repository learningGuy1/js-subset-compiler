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

***Version actuelle: c3.0/c3.1***
- Double version du concernant les parties p3.0 et p3.1
- Ajout des variables
- Ajout des commentaires simples et multi-lignes
- Modification du main pour imprimer les messages d'erreur dans le terminal et distinguer les erreurs de lexing et de parsing
- Ajout de fichiers tests *test_ast*, *test_commentaires*, *test_flottants_scientifiques* et *test_var* pour tester les différentes parties du projet
- Modifications mineures des fonctions d'affichage de AST.ml
- Le fichier AST.ml n'est plus suivi dans cette branche (il s'agissait d'un ajout superflu sur un commit précédent)
***Version actuelle: c3.2***
- Modification de AST.ml pour permettre une optimisation au moment de la compilation
- Ce fragment ne nécessitant pas de modification d'autres fichiers, aucun tag p3.2 n'a été fait puisque le lexeur et le parseur n'ont pas été changés depuis la version précédente.
- Ajout du fichier test *test_opti* pour tester l'optimisation implémentée.
***Version actuelle: c4.0***
- Génération de code assembleur du ifthenelse
- Génération de code assembleur du Et-logique

- Modification dans AST.ml pour générer l'abre des nouvelles if_then_else, Et_logique , commande ';' ainsi que le block "{code}" de commande
