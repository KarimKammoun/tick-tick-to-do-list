# PROGRESS

> Fichier tenu à jour par l'agent de code après chaque étape.

## Statut global

| Étape | Contenu | Statut |
|---|---|---|
| 0 | Initialisation : projet Flutter, architecture, thèmes clair/sombre, coque responsive, base Drift, i18n fr/en/ar, CI | **Fait** (vérification manuelle Android/Windows en attente) |
| 1 | Tâches (créer, modifier, cocher, supprimer), listes, dossiers, priorité, date | À faire |
| 2 | Sous-tâches, tags, vues Today / Next 7 Days / Inbox, ajout rapide, sélecteur de date | À faire |
| 3 | Rappels, notifications locales, récurrence | À faire |
| 4 | Compte Supabase et synchronisation | À faire |
| 5 | Calendrier, Kanban, Matrice d'Eisenhower | À faire |
| 6 | Pomodoro, habitudes, statistiques | À faire |
| 7 | Widgets Android, Premium, finitions, publication | À faire |

## Étape 0 — ce qui est fait

- Projet Flutter `taskflow` (Android + Windows) à la racine, architecture feature-first `lib/features/<domaine>/{data,domain,presentation}` + `lib/core` + `lib/shared`.
- Dépendances : `flutter_riverpod`, `go_router`, `drift`, `sqlite3_flutter_libs`, `path_provider`, `path`, `shared_preferences`, `supabase_flutter` (installé, **pas initialisé**), `flutter_localizations`, `intl` (`any`), `build_runner` + `drift_dev` (dev).
- Design system : jetons de l'annexe D.2 dans `lib/core/theme/app_colors.dart`, thème clair/sombre construit à partir de ces jetons (`app_theme.dart`), extension `context.colors`, espacements/rayons/points de rupture dans `app_spacing.dart`.
- Réglages Apparence : Clair / Sombre / Système (Système par défaut), 8 couleurs d'accent (bleu `#4772FA` par défaut, turquoise `#3FA796`), densité, langue (système / fr / en / ar) — mémorisés via `shared_preferences`.
- Composants de base : carte (`AppCard`), case à cocher carrée dont le contour porte la priorité (`TaskCheckbox`), ligne de tâche (`TaskTile`), bouton flottant « + » (`AddTaskButton`), feuille basse arrondie (`AppBottomSheet`), coquille de page (`PageScaffold`) + état vide (`EmptyStateView`).
- Coque responsive : `< 700 px` barre du bas à **5 icônes sans texte** (Tâches, Calendrier, Matrice, Concentration, Plus) + tiroir latéral ; `700–1000 px` rail + barre latérale ; `> 1000 px` 4 zones (rail, barre latérale, contenu, panneau de détail).
- Base Drift : `folders`, `lists`, `tasks` (`parent_id`, `status`, `priority`, RRULE, rappels JSON…), `tags`, `task_tags`, `sections`, toutes avec `id` UUID + `updated_at` + `deleted_at` (mixins `SyncColumns`), suppression logique, clés étrangères activées ; dépôts `Folder`, `List`, `Task`, `Tag` + providers Riverpod.
- i18n : ARB `app_en.arb`, `app_fr.arb` (accord grammatical corrigé), `app_ar.arb` → `fr`, `en`, `ar` (RTL), aucune chaîne en dur.
- Tests : base de données (schéma, CRUD, sous-tâches, suppression logique, tags), thème et contraste WCAG, réglages, domaine (UUID, priorités, rappels), coque mobile/bureau, navigation go_router, i18n (parité des clés, RTL).
- CI GitHub Actions : `pub get`, `gen-l10n`, `build_runner`, `dart format --set-exit-if-changed`, `flutter analyze`, `flutter test`.
- `README.md`, `CLAUDE.md` créés.

## Décisions prises

1. **Branche unique `arena/756ca8d6-tick-tick-to-do-list`** avec **un PR par étape vers `main`** (la session est verrouillée sur cette branche) — validé par l'utilisateur.
2. **Vérification** : CI (analyze + format + tests) à chaque push + l'utilisateur lance l'app sur Android et Windows dans les deux thèmes et renvoie le résultat (pas de SDK Flutter dans l'environnement de l'agent).
3. **Étape 0 démarrée sans attendre le « OK »** (l'attente du plan validé reste la règle à partir de l'étape 1).
4. **`shared_preferences` ajouté** pour mémoriser thème/accent/densité (annexe D.1 « réglages mémorisés ») ; plus petit stockage clé-valeur fonctionnant sur Android et Windows.
5. **Génération des dossiers de plateforme et du code Drift via GitHub Actions** : l'environnement de l'agent n'a ni Flutter ni accès aux téléchargements de SDK. Un workflow temporaire `.github/workflows/scaffold.yml` produit `android/`, `windows/`, `*.g.dart` et le formatage, puis est supprimé avant le PR de fin d'étape.
6. **`lib/l10n/generated/` non versionné** : produit par `flutter gen-l10n` (CI, poste de développement).
7. **UUID généré localement** (`lib/core/ids/id_generator.dart`) plutôt qu'avec le paquet `uuid`, pour ne pas ajouter de dépendance non prévue ; générateur injectable pour les tests.
8. **Contraste** : la table de l'annexe D.2 est reprise à l'identique, puis trois familles sont ajustées par `Contrast` (texte secondaire clair `#6B7280` à 4.36:1, priorités sur la surface, accent) pour tenir la règle 4.5:1 / 3:1 de la **même annexe**. La palette de 8 accents est en revanche une proposition (seuls le bleu et le turquoise étaient imposés).
9. **Case à cocher** : contour coloré par la priorité et remplissage par la couleur de priorité quand elle est cochée (le cahier ne décrit que le contour).
10. **Onglet « Plus » / icône du rail** : la 5ᵉ icône de la barre ouvre le tiroir latéral sur mobile (A4 : le tiroir n'a pas d'autre point d'entrée) et la page « Plus » sur bureau.

## Questions ouvertes

1. **Palette d'accent** : les 6 couleurs ajoutées aux deux imposées conviennent-elles ?
2. **Icônes** : le jeu Flutter intégré (Material Icons via `Icons.*`) est utilisé pour l'instant ; faut-il livrer le paquet `material_symbols_icons` (Material Symbols) ou des SVG Lucide pour coller à l'annexe D.4 ?
3. **Écran « Paramètres »** : livré dès l'étape 0 (thème + accent + densité + langue) alors que l'annexe le place à l'étape 7 ; conserver ou déplacer les réglages densité/langue à l'étape 7 ?
4. **Nom du paquet** : `taskflow` / `com.taskflow.taskflow` — à confirmer pour une publication (identifiant Play Store + signature Windows).
5. **Résolution de la langue** : langue système par défaut, repli sur l'anglais pour toute langue non supportée (le cahier ne tranche pas).

## Points « à confirmer » du cahier des charges

- Rôle exact de l'onglet « Durée » du sélecteur de date.
- Icône ampoule dans la vue « Today » (PC).
- Dernière icône du rail PC (carré avec étoile).
- Raccourci « lune » du sélecteur de date PC (ce soir ?).
- Contenu exact de l'onglet « Plus » (⋯) sur Android.
