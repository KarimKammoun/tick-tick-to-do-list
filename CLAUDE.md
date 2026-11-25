# CLAUDE.md — conventions de code et règles de travail

Ce dépôt construit **TaskFlow** (Flutter, Android + Windows) étape par étape. Le cahier des charges fait foi : [`docs/SPEC.md`](docs/SPEC.md) + [`docs/spec/`](docs/spec/), captures dans [`docs/design/`](docs/design/).

## Ordre de priorité en cas de contradiction

**Annexe D > Annexe C (PC) > Annexe B > Annexe A > base (sections 1 à 10).**

## Règles de travail

1. **Avant de coder** : annoncer un plan court (fichiers créés/modifiés, ordre, risques) et attendre le « OK » (sauf pour l'étape 0).
2. **Un commit par sous-étape**, messages en anglais : `feat:`, `fix:`, `test:`, `chore:`, `docs:`.
3. **Rien n'est terminé tant que** : `flutter analyze` sans avertissement, `dart format` appliqué, `flutter test` vert, application vérifiée sur Android **et** Windows dans les **deux thèmes**.
4. **Tests obligatoires** : récurrence, rappels, synchronisation, couche base de données.
5. **Aucune couleur, aucun texte, aucune dimension en dur dans les écrans** : jetons de thème (`lib/core/theme/`) + fichiers ARB (`lib/l10n/`).
6. **Cahier des charges ambigu ou muet** : poser la question, ne rien inventer ; noter la décision dans [`docs/PROGRESS.md`](docs/PROGRESS.md).
7. **Pas de nouvelle dépendance** sans justification en une ligne (dans le `pubspec.yaml` et dans la PR).
8. **Pas de refactoring ni de fonctionnalité** hors de l'étape demandée.
9. **Fin d'étape** : rapport court (fait / comment tester / hypothèses / proposition suivante) puis arrêt.
10. Ne jamais copier la marque, le logo, les icônes ou les illustrations de l'application d'origine : icônes Material Symbols ou Lucide, illustrations propres.

## Architecture

- **Feature-first** : `lib/features/<domaine>/{data,domain,presentation}`.
  - `data` : dépôt Drift + providers Riverpod du domaine.
  - `domain` : modèles immuables, enums (`TaskPriority`, `TaskStatus`, `ListType`...).
  - `presentation` : pages et widgets ; aucune requête SQL, aucun accès `SharedPreferences`.
- **`lib/core/`** : tout ce qui est transverse (thème, réglages, base, i18n, générateur d'ID).
- **`lib/shared/presentation/`** : composants réutilisables (`AppCard`, `TaskCheckbox`, `TaskTile`, `AppBottomSheet`, `PageScaffold`).

## Conventions Dart / Flutter

- Dart 3, null-safety, `analysis_options.yaml` avec `strict-casts` et `strict-raw-types`.
- Toujours typer explicitement les variables locales, les paramètres et les retours : `final String name = ...;`
- Types génériques explicites pour les collections : `<String>[]`, `<String, Object>{}`.
- Immuabilité : `final`, constructeurs `const`, `copyWith` ; pas de `setState` dans les pages, l'état vit dans Riverpod.
- Riverpod 2 : `Provider`, `StreamProvider`, `Notifier`/`NotifierProvider` ; les dépendances de plateforme sont injectées par *provider override* (voir `main.dart`).
- Nommage : fichiers en `snake_case`, classes en `UpperCamelCase`, membres en `lowerCamelCase`, providers suffixés `Provider`.
- Widgets : `StatelessWidget` par défaut, `ConsumerWidget` seulement si l'écran lit un provider.
- Commentaires : en anglais, expliquent le *pourquoi*, jamais le *quoi*.

## Interface et design

- Toute couleur vient de `context.colors` (`AppColorsTheme`, jetons de l'annexe D.2) ou de `Theme.of(context).colorScheme`.
- Toute dimension vient de `AppSpacing`, `AppRadius`, `AppSizes`, `AppBreakpoints`.
- Tout texte visible vient des ARB (`context.l10n.<clé>`) ; ajouter la clé dans **les trois** fichiers `app_en.arb`, `app_fr.arb`, `app_ar.arb` avec sa description `@clé`.
- Contraste minimal **4.5:1** (texte) et **3:1** (graphique) : `Contrast` vérifie et ajuste les jetons, `test/core/theme_test.dart` le contrôle.
- Responsive : `< 700 px` barre du bas à 5 icônes sans texte + tiroir ; `700–1000 px` rail + barre latérale ; `> 1000 px` 4 zones (rail, barre latérale, liste, détail).

## Base de données

- Drift, table déclarée dans `lib/core/database/database_tables.dart` ; toute table synchronisable utilise le mixin `SyncColumns` (`id` UUID, `updated_at`, `deleted_at`).
- Suppression **logique** (`deleted_at`) partout ; les flux (`watch...`) filtrent `deletedAt IS NULL`.
- Après toute modification de table : `dart run build_runner build --delete-conflicting-outputs` (le fichier `*.g.dart` est versionné).
- Chaque dépôt expose une interface (`TaskRepository`) et une implémentation Drift testée avec une base en mémoire.

## Internationalisation

- `flutter gen-l10n` génère `lib/l10n/generated/` (non versionné, produit par la CI et à la génération locale).
- Locales : `fr`, `en`, `ar`. L'arabe se lit de droite à gauche : ne jamais coder `left`/`right` en dur, utiliser `EdgeInsetsDirectional`, `AlignmentDirectional`, ou les helpers directionnels.
- Ne pas s'appuyer sur le texte des captures de référence : le contenu des écrans vient exclusivement des ARB.

## CI

`.github/workflows/ci.yml` : `flutter pub get`, `flutter gen-l10n`, `dart run build_runner build`, `dart format --set-exit-if-changed`, `flutter analyze`, `flutter test`.
