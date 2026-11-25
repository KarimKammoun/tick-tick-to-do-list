# TaskFlow

Application de gestion de tâches **Android + Windows** (Flutter), inspirée de TickTick sans en copier la marque, le logo, les icônes ni les illustrations. Le cahier des charges complet est dans [`docs/SPEC.md`](docs/SPEC.md), l'avancement dans [`docs/PROGRESS.md`](docs/PROGRESS.md).

| | |
|---|---|
| Plateformes | Android, Windows (une seule base de code Flutter) |
| État | Riverpod · Navigation go_router · Base locale Drift/SQLite · Backend Supabase (étape 4) |
| Langues | Français, anglais, arabe (RTL) |
| Thèmes | Clair et sombre, accent configurable (`#4772FA` par défaut, `#3FA796` en option) |

## Prérequis

- **Flutter** stable ≥ 3.35 (Dart ≥ 3.8) : <https://docs.flutter.dev/get-started/install>
  — 3.35 est la première version stable qui expose `AppBarThemeData` et
  `InputDecorationThemeData`, utilisés par `lib/core/theme/app_theme.dart`.
- **Android** : Android Studio + SDK Android + un appareil ou un émulateur
- **Windows** : Visual Studio 2022 avec la charge « Desktop development with C++ »
- Vérifier l'installation : `flutter doctor`

## Installation

```bash
git clone https://github.com/KarimKammoun/tick-tick-to-do-list.git
cd tick-tick-to-do-list
flutter pub get
```

## Lancer l'application

### Android

```bash
flutter devices              # vérifier que le téléphone/émulateur est détecté
flutter run -d <device-id>
```

### Windows

```bash
flutter config --enable-windows-desktop   # une seule fois si nécessaire
flutter run -d windows
```

### Vérifier les deux thèmes

1. Ouvrir l'application, appuyer sur l'icône la plus à droite de la barre du bas (« Plus ») → **Paramètres**.
2. Dans **Apparence**, choisir **Clair**, puis **Sombre**, puis **Système**.
3. Vérifier la couleur d'accentuation (bleu par défaut, turquoise en option).
4. Passer la **densité** en *Compacte* : les listes et les barres se resserrent.
5. Choisir une **langue** (français, anglais, arabe) : l'interface se traduit, l'arabe passe en RTL.
6. Survivre à un redémarrage : les quatre choix sont mémorisés.

Les captures de référence se trouvent dans `docs/design/` (index : [`docs/design/README.md`](docs/design/README.md)).

## Vérifications et tests

```bash
flutter analyze                 # aucune erreur ni avertissement
dart format --set-exit-if-changed lib test
flutter test                    # tests unitaires (base de données, thèmes, i18n, navigation)
flutter gen-l10n                # régénère lib/l10n/generated/ après édition des ARB
dart run build_runner build --delete-conflicting-outputs   # régénère la partie Drift
```

Les `flutter test` couvrent la couche données (schéma, dossiers, listes, étiquettes, tâches), les thèmes et le contraste, la persistance des réglages, les modèles du domaine, la navigation et la coque responsive (mobile, tablette, bureau).

Les workflows prêts à l'emploi (CI et fabrication de l'APK + de l'exécutable
Windows) sont dans `docs/ci/` (voir plus bas).

## Structure

```
lib/
├── app/                  # TaskFlowApp, routeur go_router
├── core/                 # socle transverse : thème, réglages, base, i18n, IDs
│   ├── database/         # tables Drift, connexions, providers
│   ├── localization/     # locales supportées, extension context.l10n
│   ├── settings/         # AppSettings + persistance (thème, accent, densité, langue)
│   └── theme/            # jetons Annexe D, thème, contraste WCAG
├── features/<domaine>/   # feature-first : data / domain / presentation
│   ├── tasks/  lists/  folders/  tags/
│   ├── shell/            # coque responsive (barre du bas / 4 zones bureau)
│   ├── calendar/  matrix/  focus/  more/  settings/
├── l10n/                 # app_en.arb, app_fr.arb, app_ar.arb
└── shared/presentation/  # composants de base (carte, case, ligne, feuille)
```

Chaque fonctionnalité suit `data` (Drift + providers), `domain` (modèles) et `presentation` (écrans) ; les écrans ne contiennent ni couleur ni texte en dur (voir `CLAUDE.md`).

## GitHub Actions : APK Android et exécutable Windows

Deux workflows prêts à l'emploi sont fournis dans `docs/ci/` :

| Fichier | Rôle | À copier en |
|---|---|---|
| `docs/ci/ci.yml` | formatage, `flutter analyze`, `flutter test` | `.github/workflows/ci.yml` |
| `docs/ci/build.yml` | **APK Android** + **bundle Windows x64** en artefacts téléchargeables | `.github/workflows/build.yml` |

Ils ne sont pas versionnés sous `.github/workflows/` parce que le jeton de
l'environnement de génération n'a pas la permission « workflows » (le push est
refusé par GitHub). Pour les activer, depuis **votre** machine :

```bash
mkdir -p .github/workflows
cp docs/ci/ci.yml .github/workflows/ci.yml
cp docs/ci/build.yml .github/workflows/build.yml
git add .github && git commit -m "ci: enable the CI and build workflows" && git push
```

Ensuite, onglet **Actions** du dépôt :

- `Build` se lance à chaque push (et manuellement via **Run workflow**) ;
- quand il est vert, ouvrez l'exécution terminée → section **Artifacts** :
  - `taskflow-android-apk` → `taskflow-<sha>.apk`, à installer sur un téléphone
    (release signé avec la clé de debug : installation et test OK, publication
    Play Store non) ;
  - `taskflow-windows-x64` → `taskflow-windows-x64-<sha>.zip`, à **décompresser
    entièrement** puis lancer `taskflow.exe` (un build Flutter desktop n'est pas
    un exécutable unique : le `.exe` a besoin des DLL et du dossier `data/`).

Les artefacts sont conservés 30 jours. Le workflow épingle Flutter **3.50.1**,
la version dont les templates ont servi à écrire `android/` et `windows/` ;
montez cette valeur en même temps que ces dossiers, jamais seule.

En attendant, la vérification se fait aussi en local : les quatre commandes de
la section précédente, puis le lancement sur un téléphone Android et sur
Windows, dans les deux thèmes.

## Limites connues de l'étape 0

- Les écrans Calendrier, Matrice, Concentration et Détail de tâche sont des pages vides : ils sont livrés aux étapes 1 à 6.
- Aucune création de tâche, rappel, récurrence ni synchronisation : étapes 1 à 4.
- `supabase_flutter` est installé mais pas encore initialisé.
- `lib/core/database/app_database.g.dart` (sortie de `drift_dev`) et
  `lib/l10n/generated/app_localizations*.dart` (sortie de `gen-l10n`) sont
  versionnés : l'environnement de génération n'a pas de SDK Dart. Les deux
  s'obtiennent avec `dart run build_runner build --delete-conflicting-outputs`
  et `flutter gen-l10n`, et le fichier Drift se régénère aussi avec
  `python3 tool/generate_drift_code.py` (secours, mêmes conventions).
