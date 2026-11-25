# PROMPTS : à donner à l'agent de code, étape par étape

## Avant de commencer

1. Outils installés sur le PC : **Git**, **Flutter SDK**, **Android Studio** (avec le SDK Android), **Visual Studio** avec la charge « Desktop development with C++ » (pour compiler Windows).
2. Comptes : **GitHub** (dépôt) et **Supabase** (backend, utilisé à partir de l'étape 4).
3. Dépôt cloné en local, ce dossier `docs/` copié à la racine du dépôt, puis un premier commit (`docs: add specification and design references`).
4. Agent de code lancé **dans le dossier du dépôt**.
5. Donner **un seul prompt à la fois**. Tester sur le téléphone et sur le PC avant de passer au suivant.

---

## PROMPT 1 : Étape 0, initialisation (à copier)

```
Tu es un développeur senior Flutter. Ce dépôt ne contient que le dossier docs/. Tu vas y construire, étape par étape, une application de gestion de tâches (Android + Windows) appelée "TaskFlow" (nom provisoire).

CONTEXTE
- Le cahier des charges est dans docs/SPEC.md (index) et docs/spec/. Commence par lire docs/SPEC.md puis chaque fichier de docs/spec/ en entier.
- Les captures d'écran de référence sont dans docs/design/android/ et docs/design/pc/ (index : docs/design/README.md). Consulte-les avant de construire chaque écran.
- Ordre de priorité en cas de contradiction : Annexe D > Annexe C > Annexe B > Annexe A > base.
- Ne copie jamais la marque, le logo, les icônes ou les illustrations de l'application d'origine. Utilise des icônes libres (Material Symbols ou Lucide) et ses propres visuels.

ÉTAPE 0 : INITIALISATION (c'est la seule étape à faire maintenant)
1. Réponds-moi d'abord par un résumé de 10 lignes maximum de ce que tu as compris, avec la liste de tes hypothèses et de tes questions (max 5). Si tu n'as pas de question bloquante, continue sans attendre.
2. Crée le projet Flutter (plateformes : android et windows) à la racine du dépôt, avec une architecture "feature-first" propre (présentation / domaine / données).
3. Dépendances : Riverpod (état), go_router (navigation), Drift + SQLite (base locale), supabase_flutter (installé mais pas encore utilisé), flutter_localizations / intl.
4. Système de design (annexe D) :
   - thèmes clair ET sombre générés à partir de jetons de couleur (aucune couleur en dur dans les écrans) ;
   - choix du thème Clair / Sombre / Système et couleur d'accent configurable (bleu #4772FA par défaut, turquoise #3FA796 en option), mémorisés localement ;
   - typographie, espacements, rayons, et composants de base : case à cocher carrée (contour selon la priorité), ligne de tâche, bouton flottant "+", feuille basse (bottom sheet) à coins arrondis, carte blanche.
5. Coque d'application responsive :
   - mobile (< 700 px) : barre du bas à 5 icônes sans texte (Tâches, Calendrier, Matrice, Concentration, Plus) + menu latéral ;
   - bureau (> 1000 px) : 4 zones (rail d'icônes, barre latérale, liste, panneau de détail) ;
   - les écrans peuvent être des pages vides pour l'instant, mais la navigation doit fonctionner.
6. Base de données Drift : tables folders, lists, tasks (avec sous-tâches via parent_id), tags, task_tags, sections selon la section 4 du cahier, avec UUID, updated_at et deleted_at. Ajoute des tests unitaires de la couche données.
7. Internationalisation dès le départ : français, anglais, arabe (avec RTL), via fichiers ARB. Aucune chaîne en dur dans l'interface.
8. Crée : README.md à la racine (lancer le projet sur Android et Windows), CLAUDE.md à la racine (conventions de code et règles de travail de l'annexe D.4), et mets à jour docs/PROGRESS.md.
9. Ajoute une CI GitHub Actions qui exécute "flutter analyze" et "flutter test".

RÈGLES DE TRAVAIL
- Un commit clair par sous-étape (messages en anglais, format "feat: ...", "chore: ...").
- Avant de conclure : "flutter analyze" sans erreur, tests verts, l'application démarre sur Windows et sur Android avec les deux thèmes.
- N'implémente PAS encore la création de tâches, les rappels, la synchronisation ni les autres écrans.

LIVRAISON
Termine par un rapport court : ce qui est fait, comment lancer et tester, ce que tu as supposé, et ce que tu proposes pour l'étape 1. Puis ARRÊTE-TOI et attends ma validation.
```

---

## Les prompts suivants (modèle)

Pour chaque étape, utiliser ce modèle en remplaçant `<ÉTAPE>` :

```
Étape précédente validée. Passe à l'ÉTAPE <N> : <titre>.
Relis docs/PROGRESS.md, les sections concernées de docs/spec/ et les captures listées ci-dessous avant de coder.
Objectifs : <liste>.
Captures à consulter : <fichiers de docs/design/>.
Même règles : un commit par sous-étape, flutter analyze + tests verts, thèmes clair et sombre, textes dans les fichiers ARB, mise à jour de docs/PROGRESS.md.
Termine par un rapport court (fait / comment tester / hypothèses) puis ARRÊTE-TOI.
```

| Étape | Titre | Objectifs principaux | Captures |
|---|---|---|---|
| 1 | Tâches et listes | Créer, modifier, cocher, supprimer des tâches ; listes, dossiers, priorité, date ; menu latéral / barre latérale avec compteurs | android/01, 02 ; pc/01, 04 |
| 2 | Vues et saisie | Sous-tâches, tags (pastilles), vues Today / Next 7 Days / Inbox, feuille d'ajout rapide, sélecteur de date, détail de tâche (feuille mobile, panneau PC) | android/09, 10, 11 ; pc/02, 03, 05, 06, 07, 10 |
| 3 | Rappels et récurrence | Rappels, notifications locales (boutons Terminer / Reporter), récurrence complète, tests automatiques | android/11 ; pc/06 |
| 4 | Compte et synchronisation | Auth Supabase, synchro hors ligne d'abord, gestion des conflits, indicateur de synchro | pc/01 (rail bas) |
| 5 | Calendrier, Kanban, Matrice | Calendrier (bande semaine mobile ; semaine/année PC), Kanban, Timeline, Matrice d'Eisenhower, menu de vues et tri | android/03, 04 ; pc/08, 09, 11, 12 |
| 6 | Pomodoro, habitudes, stats | Minuteur + historique, habitudes (séries, carte thermique), statistiques | android/05, 12 ; pc/13, 14 |
| 7 | Widgets, Premium, finitions | Widgets Android, limites gratuit/Premium (9 listes, calendrier Premium), paramètres complets, gamification, publication | android/06, 07, 08, 13 |

## Conseils

- Si l'agent se trompe sur un écran, **donne-lui le nom du fichier de capture** et la section de l'annexe concernée.
- Si une décision n'est pas dans le cahier, il doit **poser la question** plutôt que d'inventer.
- Après chaque étape, ouvre l'application sur ton téléphone **et** sur ton PC, dans les **deux thèmes**.
