# js-subset-compiler

Compilateur d'un sous-ensemble de JavaScript, écrit en C. Il traduit un programme JS en code assembleur pour une machine virtuelle dédiée (la *mini-JSM*, fournie en cours).

Projet de compilation réalisé en binôme, Université Sorbonne Paris Nord, 2026. Version courante : **c7.1**.

## Pipeline

```text
programme JS → analyse lexicale et syntaxique → AST → vérifications de portée → génération d'assembleur → exécution dans la mini-JSM
```

Le compilateur respecte la sémantique de JavaScript là où le sujet l'exige : priorités et associativité des opérateurs, évaluation paresseuse de `&&`, conversions implicites de types, closures, et hoisting des `let`.

## Fragments couverts

Le sujet découpe le compilateur en grands fragments cumulatifs. Cette version couvre les fragments 1 à 7.1.

| Fragment | Contenu |
|---|---|
| 1 | Expressions arithmétiques (`+`, `-`, `*`, `/`), priorités, nombres entiers et flottants |
| 2 | Booléens, `==`, `>`, `<=`, `!`, notation scientifique, `NaN`, séquences de commandes |
| 3 | Commentaires (une ligne et multilignes), variables globales, évaluation des constantes à la compilation |
| 4 | `&&` paresseux, `if/else`, `while`, `do…while`, blocs, commande vide |
| 5 | Appels de fonctions, déclarations, closures (une closure utilisée comme un autre type fait volontairement échouer le programme) |
| 6 | Conversions implicites (booléens et nombres), type `undefined` |
| 7.1 | `let` avec hoisting (au début du programme, de la fonction ou du bloc), refus de deux `let` identiques dans un même bloc |

Non couvert : objets, exceptions, classes (fragments 8 à 10) et fragments optionnels.

## Instructions de la machine utilisées

Le sujet impose un jeu d'instructions précis, étendu fragment par fragment.

| Catégorie | Instructions |
|---|---|
| Arithmétique | `CsteNb`, `AddiNb`, `SubsNb`, `MultNb`, `ModuNb`, `NegaNb` |
| Booléens et comparaisons | `CsteBo`, `Equals`, `NotEql`, `LoEqNb`, `GrEqNb`, `LoStNb`, `GrStNb`, `Not` |
| Variables | `SetVar`, `GetVar`, `DclVar` |
| Contrôle | `Jump`, `ConJmp`, `Halt` |
| Fonctions | `NewClot`, `DclArg`, `SetArg`, `StCall`, `Call`, `Return`, `Error` |
| Types | `TypeOf`, `BoToNb`, `NbToBo`, `CsteUn`, `Swap`, `Noop` |

## Logiciels requis

- Un compilateur C et `make` (**[À COMPLÉTER : gcc, éventuellement flex/bison ou autre générateur de parser]**)
- La mini-JSM fournie par l'enseignant, non incluse dans ce dépôt

## Compilation et utilisation

```bash
make
./main [FICHIER EN ENTRÉE] [FICHIER EN SORTIE]
```

- Le fichier d'entrée contient une suite de commandes JavaScript.
- Le fichier de sortie contient le code assembleur généré, à exécuter dans la mini-JSM (**[À COMPLÉTER : commande d'exécution]**).
- Si le programme est refusé (par exemple deux `let` identiques dans un même bloc), le compilateur affiche une erreur.

## Exemple

**[À COMPLÉTER : un petit programme JS, l'assembleur généré et son résultat]**

## Tests

Chaque fonctionnalité a ses fichiers de test dédiés, par exemple `test_let1`, `test_let2` et `test_let3` pour le hoisting (**[À COMPLÉTER : nombre total de tests et commande pour les lancer]**).

## Choix techniques et corrections notables

- **Sauts conditionnels :** le calcul des `Jump` / `ConJmp` dans `while` et `do…while` ne tenait pas compte des instructions de vérification et de conversion de type, ce qui décalait les sauts. Corrigé.
- **Fin de programme :** l'instruction `Halt` est rétablie en fin de programme principal.
- **Ordre des arguments :** l'ordre des `DclArg` est inversé pour respecter le comportement réel de la mini-JSM plutôt que celui décrit dans le cours.

Ces deux dernières corrections rendent chaque assembleur généré exécutable tel quel dans la mini-JSM, sans retouche manuelle.

## Organisation du travail

- Deux branches de livraison : `parser` et `main`.
- Chaque fragment livré est tagué, une fois pour le parser (`p_i_j`) et une fois pour le compilateur (`c_i_j`), avec une description de qui a fait quoi.
- Chaque version du compilateur a pour ancêtre la version précédente et le parser correspondant.

## Équipe et contributions

| Membre | Contribution |
|---|---|
| Juimo kamto Claude EDWIN | Fragment 5 en entier (fonctions, déclarations, closures), `if/else`, boucles, expressions booléennes, commentaires sur une ligne et multilignes |
| Nino BERNARD | Sous-fragment 7.1 (hoisting et interdiction de `let` dupliqués), typage dynamique,variables |

## Contexte et crédits

Projet de licence. Le sujet, la machine virtuelle (mini-JSM) et la machine d'exécution JavaScript sont fournis par l'équipe enseignante et ne font pas partie de ce dépôt.

