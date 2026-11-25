# ANNEXE A : Design réel observé (captures d'écran Android)

> **Important :** cette annexe est basée sur les captures de la version Android (`docs/design/android/01` à `08`). Là où elle contredit la base (`01-cahier-base.md`), **l'annexe A a priorité**. Les couleurs et dimensions sont des **estimations visuelles** (écran de 720 px de large, soit environ 360 dp ; 1 dp ≈ 2 px).
>
> Les valeurs de couleur ci-dessous sont celles du **thème clair**. Le thème sombre est défini dans l'annexe D.

## A.1 Corrections par rapport à la première version

| Sujet | Première version | Réalité observée |
|---|---|---|
| Barre de navigation du bas | 4 onglets avec texte | **5 icônes sans texte** : Tâches, Calendrier, Matrice, Concentration, Plus (⋯) |
| Case à cocher | Cercle | **Carré aux coins arrondis** (contour gris, ou coloré selon la priorité) |
| Menu latéral | Nombreuses listes intelligentes | Seulement **Aujourd'hui, Boîte de réception, Étiquettes** (+ listes de l'utilisateur) |
| Onglet Habitudes | Onglet principal | Pas dans la barre du bas : dans l'onglet « Plus » (⋯) / barre d'onglets personnalisable |
| Cartes | Ombres légères | **Cartes blanches à grands coins arrondis, sans ombre visible**, sur fond gris-bleu clair |

## A.2 Palette de couleurs (thème clair)

| Rôle | Valeur estimée |
|---|---|
| Couleur principale (bouton +, éléments actifs, dates à venir) | `#4772FA` |
| Fond de l'écran | `#F1F3F9` (gris-bleu très clair) |
| Fond des cartes | `#FFFFFF` |
| Ligne sélectionnée dans le menu | `#EDEFFB` (lavande très clair) |
| Texte principal | `#1A1C1E` |
| Texte secondaire / compteurs | `#9AA0A6` |
| Icônes inactives (barre du bas) | `#8E9096` (gris) |
| Séparateurs | `#E5E7EB`, trait fin |
| Dégradé en haut du menu latéral | bleu-lavande très pâle vers blanc |
| Avatar (initiale) | disque vert-bleu `#0F8F76`, lettre blanche |
| Badge couronne (Premium) | pastille orange doré (dégradé jaune-orange) |

**Couleurs de priorité** (appliquées au **contour de la case à cocher**) :

- Haute : rouge `#D52B24`
- Moyenne : jaune-orange `#F2B01E`
- Basse : bleu `#4772FA`
- Aucune : gris `#B5B8BD`

**Couleurs de la Matrice d'Eisenhower :**

- Quadrant I, Urgent et important : rouge-rose `#FF5A5F`
- Quadrant II, Non urgent mais important : orange-jaune `#FFB000`
- Quadrant III, Urgent mais non important : bleu `#4772FA`
- Quadrant IV, Pas urgent et non important : vert-turquoise `#1ECBA0`

**Couleurs de listes** (barre verticale à gauche de chaque tâche dans le calendrier) : violet `#C487F0`, jaune `#FFD25A`, rose `#F25FB0`, turquoise `#35BFC0`. L'utilisateur choisit une couleur par liste.

## A.3 Typographie et mesures

- Police : sans-serif géométrique de type **Roboto / Inter**.
- Titre d'écran : environ 22 sp, **gras** (ex : « education », « novembre », « Matrice d'Eisenhower »).
- Titre de tâche : 16 à 17 sp, normal, gris foncé ; tronqué avec « … » s'il est trop long (une seule ligne dans le calendrier, plusieurs lignes dans la matrice).
- Texte secondaire (date, aperçu) : 13 à 14 sp.
- Compteurs dans le menu : 15 sp, gris clair, alignés à droite.
- Marge latérale de l'écran : 16 dp. Les cartes de tâches ont environ 12 à 16 dp de rayon de coin.
- Hauteur d'une ligne de tâche : 44 à 56 dp. Hauteur d'une ligne du menu : 44 dp.
- Bouton flottant « + » : disque bleu de **56 dp**, icône plus blanche, en bas à droite (16 dp du bord, au-dessus de la barre de navigation).
- Case à cocher : environ **20 dp**, coins arrondis (~5 dp), contour 2 dp.
- Barre de navigation du bas : environ 56 dp de haut, 5 icônes réparties uniformément ; l'icône active est **bleue**, les autres grises.

## A.4 Écran 1 : Menu latéral (tiroir) — `android/01-menu-lateral.jpg`

**Comportement :** s'ouvre depuis la gauche avec le bouton ☰ ; occupe environ **85 % de la largeur** ; le reste de l'écran est assombri (voile). Un appui sur la zone sombre le ferme.

**En-tête (fond en dégradé bleu-lavande très pâle) :**

- À gauche : **avatar rond** (initiale du nom sur fond de couleur), avec un petit **badge couronne** en haut à droite de l'avatar (compte Premium).
- Au centre : nom de l'utilisateur, tronqué avec « … ».
- À droite, trois icônes de contour fin : **Recherche** (loupe), **Notifications** (cloche), **Paramètres** (hexagone avec rond au centre).

**Bloc 1 : vues spéciales** (icône colorée + libellé gras + compteur ou chevron) :

1. **Aujourd'hui** : icône calendrier orange avec le numéro du jour (« 24 »), compteur à droite.
2. **Boîte de réception** : icône boîte orange, compteur.
3. **Étiquettes** : icône étiquette cyan, chevron « > » à droite (ouvre la liste des tags).

*Un trait de séparation fin sépare les blocs.*

**Bloc 2 : listes de l'utilisateur** (icône « trois lignes » grise ☰ + nom + nombre de tâches en gris à droite) :

- La liste **sélectionnée** est mise en évidence par un **fond lavande clair arrondi** (pilule pleine largeur, coins de 16 dp environ).
- Le compteur correspond au **nombre de tâches non terminées**.
- Les listes peuvent être regroupées dans des dossiers.

**Pied de page (fixe en bas) :**

- À gauche : bouton **« ⊕ Ajouter »** (icône plus dans un carré arrondi, contour fin) pour ajouter une liste, un dossier, un filtre ou une étiquette.
- À droite : icône **liste avec engrenage** pour gérer l'ordre et l'affichage des éléments du menu.

## A.5 Écran 2 : Liste de tâches — `android/02-liste-taches.jpg`

**Barre supérieure :** icône ☰ à gauche (ouvre le menu), titre de la liste en gras, icône **⋮** à droite (menu : vue, tri, groupement, options de la liste).

**Corps :** **une seule grande carte blanche** aux coins arrondis qui contient toutes les tâches de la liste, séparées par de l'espace (pas de traits entre elles).

**Une ligne de tâche :**

- À gauche : case à cocher carrée.
- Titre de la tâche (16 sp).
- Sous le titre (optionnel) : **aperçu de la description** en gris.
- Sous le titre : **date relative en bleu** : « Demain », « 28 nov. », « 5 déc. ». Format court (jour + mois abrégé) ; « Aujourd'hui » et « Demain » en toutes lettres.

**Éléments :** fond gris-bleu clair ; bouton flottant bleu « + » en bas à droite ; barre de navigation 5 icônes (icône **Tâches** active : carré bleu rempli avec une coche blanche).

## A.6 Écran 3 : Calendrier (bande semaine + liste du jour) — `android/03-calendrier-semaine.jpg`

**Barre supérieure :**

- À gauche : **nom du mois** en gras, grande taille (ex : « novembre »).
- À droite : 2 icônes de changement de vue + **⋮**.

**Bande de la semaine :**

- Initiales des jours en gris (lun. mar. mer. jeu. ven. sam. dim.), la semaine commence le **lundi**.
- Numéros du jour en dessous ; le **jour sélectionné** est dans un **disque bleu plein** avec le chiffre en blanc.
- Un **petit point bleu** sous chaque jour qui contient des tâches.
- Balayage horizontal pour changer de semaine.

**Carte « Aujourd'hui » (liste des tâches du jour sélectionné) :**

- Titre de la carte en gras (« Aujourd'hui », ou la date pour les autres jours).
- Chaque tâche a :
  - une **barre verticale colorée** collée au bord gauche de la carte (couleur de la liste d'appartenance) ;
  - une case à cocher carrée (contour **rouge** si priorité haute) ;
  - le titre sur une seule ligne, tronqué avec « … » ;
  - à droite, l'**heure en bleu** (08:00, 13:30, 20:00) ou le mot « Aujourd'hui » s'il n'y a pas d'heure ;
  - sous l'heure, de petites **icônes grises** : **sous-tâches** (arbre), **répétition** (deux flèches circulaires) ;
  - un **chevron « > »** pour les tâches qui ont des sous-tâches.
- Tri : tâches avec heure d'abord (ordre chronologique), puis tâches sans heure.

## A.7 Écran 4 : Matrice d'Eisenhower — `android/04-matrice-eisenhower.jpg`

**Barre supérieure :** titre « Matrice d'Eisenhower » en gras + **⋮**.

**Disposition :** grille **2 x 2** de 4 cartes blanches à grands coins arrondis, défilement vertical possible.

**En-tête de chaque carte :** **chiffre romain dans un disque de couleur** (I, II, III, IV) suivi du libellé dans la même couleur :

- **I** (rouge) : « Urgent et important »
- **II** (orange) : « Non urgent mais important »
- **III** (bleu) : « Urgent mais non important »
- **IV** (vert) : « Pas urgent et non important »

**Contenu de chaque carte :**

- Tâches avec case à cocher **à la couleur du quadrant**, titre (plusieurs lignes si nécessaire) et date/heure en bleu (ex : « Aujourd'hui, 20:00 »).
- Les **tâches terminées** sont affichées **grisées**, avec une coche grise et leur date de réalisation (ex : « 16 nov. »), après les tâches actives.
- Si la liste est longue : lien **« Voir plus »** centré, en gris, en bas de la carte.
- Le classement automatique suit la priorité (importance) et la date d'échéance (urgence) ; l'utilisateur peut glisser une tâche d'un quadrant à l'autre.
- Le bouton flottant « + » reste affiché par-dessus.

## A.8 Écran 5 : Minuteur de concentration — `android/05-pomodoro.jpg`

**Barre supérieure :**

- Deux onglets de texte : **« Pomo »** (actif : noir, gras, **soulignement bleu**) et **« Chronomètre »** (inactif : gris).
- À droite : icône **statistiques** (horloge-camembert), icône **+** (ajouter une session manuelle), **⋮**.

**Corps :**

- Au-dessus du cercle : texte **« Restez concentré > »** (choisir la tâche ou le but de la session).
- **Grand anneau** circulaire fin, gris très clair (environ 270 dp de diamètre), avec au centre la durée en **très gros chiffres fins** (environ 64 sp) : « 10:00 ». Durée réglable (25:00 par défaut).
- Pendant le décompte, l'anneau se remplit/se vide en **couleur d'accent** avec la progression.
- Bouton **« Début »** : pilule pleine d'accent, texte blanc, environ 160 x 48 dp, centrée sous l'anneau.
- Pas de bouton flottant sur cet écran.

## A.9 Écrans 6, 7, 8 : Widgets Android (galerie) — `android/06`, `07`, `08`

**Page « Widgets » :** flèche retour, titre « Widgets » en gras, icône d'aide (?) ; widgets présentés en **grille de 2 colonnes** avec leur nom sous chaque aperçu. Les widgets **Premium** portent une **pastille couronne orange** en bas à droite.

| Widget | Contenu |
|---|---|
| **Restez concentré** (carré) | Illustration de tomate (cercle pointillé), texte « Aujourd'hui : 0m », bouton **▶ Début** |
| **Habitude du jour** (carré vert clair `#98E38A`) | « 16 Days » (série), nom de l'habitude en gras, grande illustration |
| **Carte thermique des habitudes** (carré) | Icône + nom de l'habitude, calendrier du mois (l m m j v s d), un point vert sur chaque jour réalisé |
| **Statistiques de complétion des tâches** (carré) | « Aujourd'hui achevé » + grand nombre, histogramme en barres grises, **barre du jour en accent**, axe de 0 à 9 |
| **Assistant IA** (carré sombre) | Fond dégradé sombre, étoile bleue (étincelle), texte « Notez vos idées ou vos projets » |
| **Ajout rapide de tâche** (carré) | Titre, deux lignes (calendrier **Aujourd'hui**, boîte **Boîte de réception**), bouton **+** en bas à droite |
| **Médaille** (icône d'application) | Icône de l'app avec **badge rouge** indiquant le nombre de tâches |
| **Pomo** (large, 1 ligne) | Minuteur « 25:00 » en rouge-corail, bouton ▶, menu ⋮ |
| **Concentration : distribution du temps** (large, Premium) | « Aujourd'hui 5h », « Cette semaine 36h45m », histogramme empilé par jour (échelle 0 à 12 h), légende colorée avec émojis |
| **Habitudes hebdomadaires** (large, Premium) | Grille 7 jours, jour actuel dans un disque d'accent, une ligne par habitude avec icône ronde colorée et petites cases à pointer |
| **Tâches** (large, liste défilante) | En-tête : menu déroulant de la liste (« Aujourd'hui ⌄ »), bouton **+**, menu **⋮**. Lignes : case colorée par priorité, titre, date alignée à droite |

## A.10 Animations et comportements déduits

- Le menu latéral glisse depuis la gauche avec un voile sombre sur le reste de l'écran.
- Le bouton « + » est présent sur Tâches, Calendrier et Matrice, **mais pas** sur Concentration.
- Le compteur du menu = nombre de tâches actives de la liste ; il se met à jour en direct.
- Les dates sont écrites en **couleur d'accent** pour les tâches à venir ou du jour, en **rouge** pour les tâches en retard (confirmé sur PC, annexe C).
- Les tâches terminées restent visibles, grisées, dans la Matrice.
- Pour garder l'application légère : une seule grande carte par écran, peu de séparateurs, beaucoup d'espace vide.

## A.11 Fonctions confirmées par les captures

1. Notifications (icône cloche) accessibles depuis le menu latéral : centre de notifications.
2. Recherche accessible depuis le menu latéral.
3. Étiquettes (tags) avec leur propre écran de liste.
4. Badge d'icône de l'application (nombre de tâches du jour).
5. Statistiques de concentration par catégorie, avec émojis.
6. Habitudes avec série (« 16 Days »), illustration et carte thermique mensuelle.
7. Assistant IA pour noter des idées/projets (widget dédié).
8. Statut Premium visible par une couronne sur l'avatar et sur les widgets payants.
9. Compte utilisateur avec photo/initiale.
10. Ajout rapide de tâche depuis le widget, avec date et liste présélectionnées.
