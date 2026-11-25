# SPEC : index du cahier des charges

Projet : application de gestion de tâches (nom provisoire **TaskFlow**), Android + Windows, inspirée de TickTick (design et fonctions similaires, **sans copier** marque, logo, icônes ni illustrations).

## À lire dans cet ordre

| # | Fichier | Contenu |
|---|---|---|
| 1 | [spec/01-cahier-base.md](spec/01-cahier-base.md) | Vision, stack, architecture, modèle de données, toutes les fonctionnalités, offre gratuite/Premium, écrans, phases |
| 2 | [spec/02-annexe-A-android.md](spec/02-annexe-A-android.md) | Design réel Android : menu, liste, calendrier, matrice, Pomodoro, widgets |
| 3 | [spec/03-annexe-B-android-ecrans.md](spec/03-annexe-B-android-ecrans.md) | Détail de tâche, ajout rapide, sélecteur de date, habitudes, paramètres |
| 4 | [spec/04-annexe-C-pc.md](spec/04-annexe-C-pc.md) | Version PC : fenêtre à 4 zones, menus, calendrier, Pomodoro, habitudes |
| 5 | [spec/05-annexe-D-themes-et-regles.md](spec/05-annexe-D-themes-et-regles.md) | **Thèmes clair + sombre (jetons de couleur)** et règles de travail |

Captures d'écran de référence : [design/README.md](design/README.md).

## Ordre de priorité en cas de contradiction

**Annexe D > Annexe C (PC) > Annexe B > Annexe A > base (sections 1 à 10).**

Exemples déjà tranchés :

- Barre du bas Android = **5 icônes sans texte** (pas 4 onglets avec texte).
- Case à cocher = **carré arrondi** (pas un cercle).
- PC = **4 zones** (rail, barre latérale, liste, détail), pas 3 colonnes.
- Thèmes = **clair ET sombre**, sur Android ET PC.
- Couleur d'accent = **réglage** (bleu `#4772FA` par défaut, turquoise `#3FA796` en option).
- Offre gratuite : **9 listes max** ; vues du calendrier = Premium.

## Décisions fixées

- Framework : **Flutter** (Android + Windows), état **Riverpod**, base locale **Drift/SQLite**, backend **Supabase**.
- Langues : **français, anglais, arabe (RTL)** dès le départ, via fichiers ARB.
- Aucune couleur en dur dans les écrans : tout passe par les jetons de thème (annexe D).
- Valeurs de couleur et de dimension des annexes = **estimations visuelles** relevées sur des captures.
