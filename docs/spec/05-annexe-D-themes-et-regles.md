# ANNEXE D : Thèmes clair ET sombre (Android + PC) et règles de travail avec l'agent

> **Cette annexe annule la décision « thème clair uniquement » des annexes B et C.** L'application doit avoir **un thème clair et un thème sombre sur Android ET sur PC**, avec le choix **Clair / Sombre / Système** (Paramètres > Apparence). Le thème **Système** est le réglage par défaut.

## D.1 Principe technique

- **Aucune couleur écrite en dur dans les écrans.** Toutes les couleurs viennent de **jetons de thème** (tokens) définis une seule fois pour le clair et une seule fois pour le sombre.
- La **couleur d'accentuation** est un réglage indépendant du thème (bleu par défaut `#4772FA`, turquoise `#3FA796` et d'autres au choix). Elle s'applique au clair comme au sombre.
- Le changement de thème est **instantané** et **mémorisé** (local + compte).
- Les illustrations d'état vide existent en **deux variantes** (clair et sombre) ou utilisent les couleurs du thème.

## D.2 Jetons de couleur

| Jeton | Clair | Sombre |
|---|---|---|
| `background` (fond de l'écran mobile) | `#F1F3F9` | `#14171A` |
| `surface` (cartes, liste PC) | `#FFFFFF` | `#1D2125` |
| `surfaceSidebar` (barre latérale PC) | `#F5F6FA` | `#1F2428` |
| `rail` (rail d'icônes PC) | accent foncé (ex : `#1F3FA8`) | `#1B3A44` |
| `selected` (ligne choisie, survol) | `#EDEFFB` | `#2B3136` |
| `input` (champ « Add Task ») | `#F1F3F9` | `#272C30` |
| `textPrimary` | `#1A1C1E` | `#E8EAED` |
| `textSecondary` | `#6B7280` | `#9AA0A6` |
| `divider` | `#E5E7EB` | `#2E3338` |
| `overlay` (voile derrière les feuilles) | noir 35 % | noir 55 % |
| `danger` (retard, « Effacer ») | `#D52B24` | `#E5484D` |
| `success` | `#2E9E5B` | `#3DBE74` |
| `premium` (couronne) | `#F59E0B` | `#F59E0B` |

**Priorités (identiques dans les deux thèmes, un peu plus claires en sombre) :** haute `#D52B24` / `#E5484D` ; moyenne `#F2B01E` ; basse `#4772FA` / `#6A8DFF` ; aucune `#B5B8BD` / `#6B7280`.

**Couleurs de listes, de tags et de la Matrice :** mêmes teintes dans les deux thèmes ; les pastilles de tags utilisent un **fond translucide de la teinte** (environ 20 % d'opacité) avec un **texte de la teinte** pour garder un bon contraste.

**Contraste :** texte et fond respectent au minimum le ratio **4.5:1** (WCAG AA) dans les deux thèmes.

**Captures disponibles par thème :**

- Android : **clair** uniquement (captures `docs/design/android/`). Le sombre Android est à **dériver** des jetons ci-dessus.
- PC : **sombre** uniquement (captures `docs/design/pc/`). Le clair PC est à **dériver** des jetons ci-dessus.

## D.3 Réglages Apparence (à prévoir)

1. **Thème :** Clair / Sombre / Système.
2. **Couleur d'accentuation :** palette de 8 couleurs (dont bleu `#4772FA` et turquoise `#3FA796`).
3. **Taille du texte** et **densité** (compact / confortable).

## D.4 Règles de travail avec l'agent de code

- Le cahier des charges est dans **`docs/SPEC.md`** (index) et **`docs/spec/`** (parties).
- Les captures d'écran sont dans **`docs/design/android/`** et **`docs/design/pc/`** (index : `docs/design/README.md`) ; l'agent doit **les consulter** avant de construire chaque écran.
- En cas de contradiction, l'ordre de priorité est : **Annexe D > Annexe C (PC) > Annexe B > Annexe A > base (sections 1 à 10)**.
- Le fichier **`docs/PROGRESS.md`** est tenu à jour par l'agent : ce qui est fait, ce qui reste, les décisions prises.
- **Un seul chantier à la fois**, un commit clair par étape, tests qui passent avant de continuer.
- Ne **jamais** copier la marque, le logo, les icônes ou les illustrations de l'application d'origine : utiliser des icônes libres (Material Symbols ou Lucide) et ses propres illustrations.
