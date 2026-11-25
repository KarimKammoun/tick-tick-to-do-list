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
- Réglages Apparence : Clair / Sombre / Système (Système par défaut), 8 couleurs d'accent (bleu `#4772FA` par défaut, turquoise `#3FA796`), densité (confortable / compacte) et langue (système / fr / en / ar) — les quatre sont **mémorisés** via `shared_preferences` et réellement appliqués : la densité change `ThemeData.visualDensity`, la langue passe par `appLocaleProvider` lu depuis les réglages, donc le choix survit au redémarrage.
- Composants de base : carte (`AppCard`), case à cocher carrée dont le contour porte la priorité (`TaskCheckbox`), ligne de tâche (`TaskTile`), bouton flottant « + » (`AddTaskButton`), feuille basse arrondie (`AppBottomSheet`), coquille de page (`PageScaffold`) + état vide (`EmptyStateView`).
- Coque responsive : `< 700 px` barre du bas à **5 icônes sans texte** (Tâches, Calendrier, Matrice, Concentration, Plus) + tiroir latéral ; `700–1000 px` rail + barre latérale ; `> 1000 px` 4 zones (rail, barre latérale, contenu, panneau de détail).
- Base Drift : `folders`, `lists`, `tasks` (`parent_id`, `status`, `priority`, RRULE, rappels JSON…), `tags`, `task_tags`, `sections`, toutes avec `id` UUID + `updated_at` + `deleted_at` (mixins `SyncColumns`), suppression logique, clés étrangères activées ; dépôts `Folder`, `List`, `Task`, `Tag` + providers Riverpod.
- i18n : ARB `app_en.arb`, `app_fr.arb` (accord grammatical corrigé), `app_ar.arb` → `fr`, `en`, `ar` (RTL), aucune chaîne en dur.
- Tests : base de données (schéma, CRUD, sous-tâches, suppression logique, tags), thème et contraste WCAG, réglages, domaine (UUID, priorités, rappels), coque mobile/bureau, navigation go_router, i18n (parité des clés, RTL).
- Prérequis de version explicites dans `pubspec.yaml` : `sdk: ^3.8.0` et `flutter: ">=3.35.0"` (première stable exposant `AppBarThemeData` / `InputDecorationThemeData`, utilisés par le thème).
- Dossiers `android/` (Kotlin, Gradle 9.5, AGP 9.3.1, `com.taskflow.taskflow`) et `windows/` (CMake + runner C++) générés depuis les templates officiels Flutter 3.50.1, icône applicative dessinée pour le projet (aucune reprise de la marque d'origine).
- CI : deux workflows **actifs** — `.github/workflows/ci.yml` (format, analyze, test) et `.github/workflows/main.yml` (**APK Android** + **bundle Windows x64** en artefacts). Ils ont été copiés depuis `docs/ci/` par le propriétaire du dépôt, le jeton de l'agent n'ayant pas la permission « workflows » (voir décisions 11 et 17).
- `README.md`, `CLAUDE.md` créés.

## Décisions prises

1. **Branche unique `arena/756ca8d6-tick-tick-to-do-list`** avec **un PR par étape vers `main`** (la session est verrouillée sur cette branche) — validé par l'utilisateur.
2. **Vérification** : CI (analyze + format + tests) à chaque push + l'utilisateur lance l'app sur Android et Windows dans les deux thèmes et renvoie le résultat (pas de SDK Flutter dans l'environnement de l'agent).
3. **Étape 0 démarrée sans attendre le « OK »** (l'attente du plan validé reste la règle à partir de l'étape 1).
4. **`shared_preferences` ajouté** pour mémoriser thème/accent/densité (annexe D.1 « réglages mémorisés ») ; plus petit stockage clé-valeur fonctionnant sur Android et Windows.
5. **Dossiers de plateforme écrits depuis les templates officiels** : l'environnement de génération n'a ni Flutter, ni Java, ni SDK Android, ni accès aux téléchargements de SDK (storage.googleapis.com et pub.dev sont bloqués). `android/` et `windows/` ont donc été reconstruits à partir des templates Flutter 3.50.1 (`packages/flutter_tools/templates/app`) et de l'archive du Gradle wrapper 9.5.0 ; ils n'ont pas encore été compilés, la première compilation se fera sur la machine de l'utilisateur.
6. **Génération de code versionnée** : `app_database.g.dart` et `lib/l10n/generated/*.dart` sont commités (voir décisions 11 et 12).
7. **UUID généré localement** (`lib/core/ids/id_generator.dart`) plutôt qu'avec le paquet `uuid`, pour ne pas ajouter de dépendance non prévue ; générateur injectable pour les tests.
8. **Contraste** : la table de l'annexe D.2 est reprise à l'identique, puis quatre familles sont ajustées par `Contrast` (texte secondaire clair `#6B7280` à 4.36:1, priorités sur la surface, accent, et **rail teinté par l'accent** — le turquoise `#3FA796` ne portait que 3.84:1 avec des icônes blanches) pour tenir la règle 4.5:1 / 3:1 de la **même annexe**. Le test de thème vérifie les 8 accents, en clair et en sombre. La palette de 8 accents est en revanche une proposition (seuls le bleu et le turquoise étaient imposés).
9. **Case à cocher** : contour coloré par la priorité et remplissage par la couleur de priorité quand elle est cochée (le cahier ne décrit que le contour).
10. **Onglet « Plus » / icône du rail** : la 5ᵉ icône de la barre ouvre le tiroir latéral sur mobile (A4 : le tiroir n'a pas d'autre point d'entrée) et la page « Plus » sur bureau.
11. **Workflows copiés par l'utilisateur** : le jeton disponible dans l'environnement de génération ne peut ni pousser `.github/workflows/` (« refusing to allow a GitHub App to create or update workflow ») ni déclencher un workflow. Les fichiers sources restent donc dans `docs/ci/` et c'est l'utilisateur qui les copie sous `.github/workflows/` ; ils y sont désormais (`ci.yml`, `main.yml`) et tournent à chaque push.
12. **Sept clés ARB supprimées** (`appTagline`, `shellOpenMenu`, `shellCloseMenu`, `navFolders`, `commonAdd`, `commonCancel`, `commonClose`) : elles décrivaient des écrans pas encore écrits et n'étaient lues nulle part. `test/app/localization_test.dart` vérifie désormais que **chaque** clé de `app_en.arb` est lue dans `lib/` ou `test/`, donc une clé morte fait échouer les tests. Elles reviendront à l'étape qui en a besoin (le tiroir mobile a son propre bouton de fermeture fourni par `Drawer`).
13. **Code généré** : `lib/l10n/generated/app_localizations*.dart` reste versionné, `app_database.g.dart` **ne l'est plus** et `tool/generate_drift_code.py` est supprimé. Raison : le fichier Drift avait été écrit à la main faute de SDK, et la première exécution de la CI a montré qu'il ne correspondait pas à la sortie de `drift_dev` (il déclarait `icon` en `String` au lieu de `Value<String>` dans `ListsCompanion.insert`), ce qui cassait les deux builds. Les workflows régénèrent le fichier avant d'analyser, de tester et de compiler : c'est le générateur qui fait foi.

14. **Densité et langue appliquées puis mémorisées** : ces deux réglages existaient dans l'écran Paramètres mais n'avaient aucun effet (la densité était figée à `VisualDensity.standard` dans le thème, et la langue vivait dans un `StateProvider` perdu au redémarrage). Ils passent désormais par `AppSettings` (`density`, `languageCode`), donc par `shared_preferences` ; `AppSettings.languageCode` accepte `null` = langue du système, d'où le drapeau `clearLanguage` de `copyWith` (un `null` explicite est sinon indistinguable d'un paramètre omis).
15. **`strict-casts` / `strict-raw-types` reportés à l'étape 1** : `CLAUDE.md` les annonçait, `analysis_options.yaml` ne les active pas. Les activer sans pouvoir lancer `flutter analyze` reviendrait à livrer un fichier non vérifié ; ils seront activés à la première exécution réelle de l'analyseur, avec le reste du code sous les yeux.

16. **Workflows de fabrication** : `.github/workflows/main.yml` (copié de `docs/ci/build.yml`) construit l'APK Android (runner Linux, SDK Android, `flutter build apk --release`) et le bundle Windows x64 (runner Windows, toolchain C++ fourni par `windows-latest`, `flutter build windows --release` puis zip). Flutter est **épinglé à 3.50.1** dans le workflow, la version dont les templates ont servi à écrire `android/` et `windows/` : la monter en même temps que ces dossiers. L'APK est signé avec la clé de **debug** (voir le `TODO` de `android/app/build.gradle.kts`) : installable et testable, mais pas publiable sur le Play Store — la configuration d'une vraie clé est reportée à l'étape 7 (publication).
17. **Correctifs issus du premier run de CI** : le premier passage réel a révélé cinq erreurs de compilation, toutes corrigées — collision de noms `DatabaseConnection` (drift ≥ 2.28 exporte le sien, notre interface devient `AppDatabaseConnection`), `barrierColor` inexistant dans `BottomSheetThemeData` (le voile est passé par `AppBottomSheet.show`), `SmartView.all` manquant dans le `switch` de `AppRoutes.smartView`, et le `Value<String>` de l'erreur ci-dessus. Leçon retenue : l'audit statique ne remplace pas un compilateur, ces quatre-là étaient invisibles à la lecture.

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
