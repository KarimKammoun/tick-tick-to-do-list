# ANNEXE C : Version PC (Windows) observée

> Captures : `docs/design/pc/01` à `14`. Elles sont en **thème sombre** ; le projet a un thème clair **et** sombre (annexe D). On retient de ces captures **la structure, les composants et les comportements**. Les couleurs de l'interface PC sombre sont des repères ; le thème clair PC est défini dans l'annexe D. L'interface PC est ici en **anglais** (Android en français) : la **langue est un réglage** de l'application.

## C.1 Structure générale de la fenêtre (4 zones)

Cette annexe **remplace l'ancienne section 6.6** (3 colonnes) : la version PC a **4 zones** de gauche à droite, pour une fenêtre de 1920 px de large.

| Zone | Largeur approx. | Rôle |
|---|---|---|
| **1. Rail d'icônes** | 50 px, fixe | Navigation entre les modules (Tâches, Calendrier, Matrice, Pomodoro, Habitudes, Recherche, …) |
| **2. Barre latérale** | 320 px (redimensionnable, repliable) | Vues intelligentes, listes, tags, filtres, Terminées, Corbeille |
| **3. Liste des tâches** | environ 730 px, flexible | Champ « Add Task » + tâches de la vue choisie |
| **4. Panneau de détail** | environ 810 px, flexible | Détail de la tâche sélectionnée (vide avec une illustration sinon) |

**Barre de titre personnalisée (en haut à droite) :** icône **couronne orange** (Premium), puis **réduire, agrandir/restaurer, fermer**. La fenêtre n'utilise pas la barre de titre Windows standard.

**Comportements de redimensionnement :**

- Largeur supérieure à 1000 px : 4 zones.
- Entre 700 et 1000 px : le panneau de détail passe **par-dessus** la liste (ou la barre latérale se replie).
- Moins de 700 px : on bascule sur la **mise en page mobile** (annexes A et B).
- Le bouton **☰** à gauche du titre de la liste **replie ou déplie la barre latérale**.

## C.2 Couleurs et styles (repères)

**Couleur d'accentuation :** sur PC elle est **turquoise** `#3FA796` (case sélectionnée, bouton « Start », bouton « OK », date du jour, jour sélectionné), alors que sur Android elle est **bleue** `#4772FA`. **L'accent est un réglage de thème** (Paramètres > Apparence) ; la valeur par défaut est le bleu `#4772FA`.

**Valeurs relevées (thème sombre PC) :**

- Rail : bleu-pétrole sombre `#1B3A44` ; barre latérale `#1F2428` ; zone principale `#1D2125` ; ligne sélectionnée `#2B3136` ; champ « Add Task » `#272C30`.
- Texte principal blanc cassé ; texte secondaire gris `#9AA0A6`.
- Retard : rouge `#E5484D` ; dates normales : couleur d'accentuation.

**Thème clair PC :** voir le tableau des jetons de l'annexe D.2.

**Typographie :** police sans-serif claire (Segoe UI sur Windows, ou Inter) ; titre de vue 22 px **gras** ; titre de tâche 14 à 15 px ; texte secondaire 12 px ; en-têtes de section de la barre latérale 12 px gras gris.

**Densité :** ligne de tâche d'environ **40 px** de haut, séparée par un trait fin ; coins arrondis de 6 à 8 px ; interface plus compacte que sur mobile.

## C.3 Rail d'icônes (zone 1)

De haut en bas :

1. **Avatar** (carré arrondi avec l'initiale, petit point blanc de notification) : menu du compte.
2. **Tâches** (case cochée) : actif = pastille claire.
3. **Calendrier**.
4. **Matrice d'Eisenhower** (4 carrés).
5. **Pomodoro / Concentration** (cible).
6. **Habitudes** (horloge pleine).
7. **Recherche** (loupe).
8. **Module supplémentaire** (carré avec étoile : probablement succès/badges ou extras ; **à confirmer**).

**En bas du rail :**

- **Synchronisation** (flèches circulaires), état de la synchro ;
- **Notifications** (cloche) ;
- **Aide** (point d'interrogation) avec **point rouge** (nouveauté).

## C.4 Barre latérale (zone 2) — `pc/01`, `pc/03`, `pc/04`

**Vues intelligentes (en haut) :** icône + libellé + compteur à droite :

- **Today** (icône calendrier avec le numéro du jour)
- **Next 7 Days**
- **Inbox**

**Section « Lists »** (en-tête gras gris) avec une pastille **« Used: 9/9 »** : **la version gratuite est limitée à 9 listes** (voir offre gratuite, section 5.18 de la base).

- Chaque liste : icône ☰, nom, **point de couleur** (couleur de la liste), compteur.
- La liste ouverte est surlignée (fond arrondi).

**Section « Tags »** (repliée/vide ici ; les tags s'affichent en pastilles colorées dans les tâches, voir C.5).

**Section « Filters » :** quand elle est vide, un **encadré d'aide gris** explique : « Display tasks filtered by list, date, priority, tag, and more » (état vide avec texte d'invitation).

**Pied de la barre :** **Completed** (icône case cochée) et **Trash** (icône corbeille).

## C.5 Liste de tâches (zone 3) — `pc/01` à `pc/04`

**En-tête :** ☰ (replier la barre latérale) + **titre de la vue en gras** ; à droite : icône **ampoule** (uniquement dans « Today » : suggestions/aide, **à confirmer**), icône **tri/groupement** (⇅) et **« … »** (menu de la liste).

**Champ d'ajout :** barre pleine largeur **« + Add Task »** sous l'en-tête. Au focus : **bordure d'accentuation**, et à droite une **puce de date « Today ⌄ »** (voir C.6).

**Ligne de tâche (de gauche à droite) :**

1. **Barre verticale colorée** (3 px) au bord gauche = couleur de la liste ; continue sur les lignes voisines de la même liste.
2. **Chevron ⌄/›** si la tâche a des sous-tâches (les sous-tâches s'affichent **indentées** juste en dessous).
3. **Case à cocher carrée** (contour rouge si priorité haute, etc.).
4. **Titre** (une ligne, tronqué).
5. **Pastille de tag colorée** (ex : « 30min », « 10min », « 5min », « 1h », « 2h ») ; la couleur dépend du tag.
6. **Nom de la liste** en petit gris (affiché dans Today, Next 7 Days, Inbox ; **masqué** dans une liste) et tronqué avec « … ».
7. **Icônes** : répétition ⟳, sous-tâches.
8. **Date/heure** alignée à droite :
   - **« Yesterday » en rouge** = en retard ;
   - **« Today »**, **heure** (ex : « 8:00 », « 13:30 ») ou **« Tomorrow »** en couleur d'accentuation ;
   - **jour abrégé** (« Thu », « Fri », « Sat », « Sun ») pour les 7 jours à venir ;
   - **date** (« Dec 12 ») au-delà.

**Au survol / à l'édition d'une ligne :** fond arrondi plus clair, **poignée de glisser ≡** à gauche, le titre devient éditable avec le curseur.

**Groupement par défaut selon la vue :**

- **Today** : liste plate, retards d'abord.
- **Next 7 Days** : groupes par jour avec en-tête gras + compteur + chevron de repli : « Tue, Today 10 », « Wed, Tomorrow 3 », « Thu, Nov 26 2 », etc.
- **Inbox** : groupes par échéance (Overdue, Today, Tomorrow, Next 7 days, **Later**, No date).
- **Liste personnelle** : réglage « Group by / Sort by » = **Custom** (ordre manuel).

## C.6 Popover de date (depuis « Add Task » ou le panneau de détail) — `pc/06`

Petite fenêtre flottante d'environ **260 px** de large, coins arrondis (12 px), ombre :

1. **Contrôle segmenté** : **Date** | **Duration**.
2. **4 raccourcis en icônes** : **soleil** (Today), **soleil levant** (Tomorrow), **calendrier « +7 »** (Next week), **lune** (This evening / Tonight : **à confirmer**).
3. **Mini-calendrier** : titre « Nov 2026 » avec ‹ **○** › (précédent, **aujourd'hui**, suivant) ; en-têtes M T W T F S S (**lundi en premier**) ; jours des mois voisins grisés ; **jour choisi = disque d'accent**.
4. **Trois lignes** : **Time >**, **Reminder >**, **Repeat >**.
5. **Boutons** : **OK** (rempli, accent) et **Clear** (contour).

## C.7 Menus contextuels — `pc/07` à `pc/10`

**Menu « options de l'ajout » (depuis le champ Add Task) :**

- **Priority** : 4 drapeaux en ligne : **rouge** (High), **orange** (Medium), **bleu** (Low), **contour** (None, surligné si choisi) ;
- **liste >** (choisir la liste), **Tags >** (sous-menu), **Attachment**, **Add from Template**, **Convert to Note**, séparateur, **Input Box Setting**.

**Menu « … » de la liste :**

- **View** : 3 icônes de mode d'affichage : **Liste** (sélectionné, accent), **Kanban**, **Timeline** (frise chronologique) ;
- **Show Completed**, **Show Details**, **View Options** ;
- séparateur : **Add Section**, **Share**, **List Activities**, **Print >** (sous-menu).

**Menu de tri (icône ⇅) :** deux lignes : **Group by : Custom >** et **Sort by : Custom >**.

**Menu de priorité du panneau de détail (drapeau en haut à droite) :** **High** (drapeau rouge), **Medium** (orange), **Low** (bleu), **None** (contour, avec **✓** si actif).

## C.8 Panneau de détail (zone 4) — `pc/05`

**Barre du haut :** case à cocher de la tâche, **séparateur vertical**, **puce de date** (icône calendrier + texte, ex : « Nov 23, Yesterday, 19:30 » **en rouge** car en retard) suivie de l'icône de **répétition ⟳** ; à droite le **drapeau** de priorité.

**Corps :**

- **Titre** de la tâche, gras, environ 22 px, éditable ; à droite, une icône **≡** pour basculer en mode liste/sous-tâches (**à confirmer**).
- **Zone de description** (texte libre, éditeur riche).
- **Tags** : pastille colorée (ex : « 30min ») suivie d'un bouton rond **« + »** pour ajouter un tag.

**Barre du bas :** à gauche le **sélecteur de liste** (icône + nom) ; à droite : icône **mise en forme « A »**, icône **commentaire**, et **« … »** (plus d'actions).

**État vide (aucune tâche sélectionnée) :** fond avec **motifs d'étoiles discrets** et une **illustration au trait** (téléphone, cahier, crayon, tasse) en bas à droite, très peu contrastée.

## C.9 Calendrier PC — `pc/11`, `pc/12`

**En-tête :** icône de panneau + **nom du mois en gras** ; à droite : bouton **+** (ajouter), sélecteur de vue **« Week ⌄ »**, contrôle segmenté **‹ | Today | ›**, et **« … »**.

**Vue Semaine :**

- Colonnes **Mon … Sun**, numéros du jour sous les noms ; **aujourd'hui = disque d'accent**.
- Colonne des heures à gauche (00:00 à 19:00+) ; la tranche **00:00 - 07:00 est regroupée** en une seule ligne pour gagner de la place.
- **Événements = blocs colorés** positionnés selon l'heure et la durée, avec **titre + plage horaire** (« 8:00 - 9:00 ») ; les blocs qui se chevauchent sont placés côte à côte ; les événements **passés sont atténués**.
- Une ligne = 1 heure (environ 60 px).

**Vue Année :** 12 mini-calendriers en grille **4 x 3** ; les jours qui ont des tâches sont **colorés** (intensité = nombre de tâches, façon carte thermique) ; aujourd'hui en couleur plus vive.

**Sélecteur de vues (flottant en bas) :** **Year, Month, Week, Day, Agenda, Multi-Day, Multi-Week** + bouton orange **« Upgrade Now »**. Un texte indique : **« Premium only, sample data for reference. »** → **toutes les vues du calendrier sont réservées à Premium** ; les comptes gratuits voient un **aperçu avec des données d'exemple**.

## C.10 Pomodoro PC — `pc/13`

**Colonne gauche :**

- Titre **« Pomodoro »** ; **contrôle segmenté « Pomo | Stopwatch »** (centré en haut) ; icônes **+** et **« … »**.
- Libellé **« Focus > »** (choisir la tâche liée) au-dessus du cercle.
- **Grand anneau fin** (environ 360 px) avec la durée **« 10:00 »** en très gros chiffres ; bouton **« Start »** (pilule d'accent) sous l'anneau.

**Colonne droite « Overview » :**

- **4 cartes statistiques** (2 x 2) : **Today's Pomos**, **Today's Focus Duration**, **Total Pomos**, **Total Focus Duration** (ex : 7 h 24 m).
- **« Focus Record »** (avec **+** et **« … »**) : historique **groupé par date**. Chaque session : **icône de pomodoro**, **plage horaire** (« 12:27 - 12:57 »), **durée à droite** (« 30m », « 1h », « 3h »), et sous elle **les tâches travaillées** (petits points reliés par une ligne verticale, façon chronologie).

## C.11 Habitudes PC — `pc/14`

- **En-tête :** **« Habit ⌄ »** (menu déroulant : groupes/vues d'habitudes) ; à droite : icône **grille** (changer l'affichage), **+** (créer), **« … »**.
- **Bande de 7 jours** : **aujourd'hui à droite, en couleur d'accent** ; sous chaque jour un **petit cercle hachuré** (aucune habitude pointée).
- **État vide :** illustration (réveil avec carte à visage souriant), titre **« Develop a habit »**, sous-titre **« Every little bit counts »**.
- Panneau de droite vide (le détail d'une habitude s'y affichera).

## C.12 Équivalences Android / PC (à conserver identiques)

| Élément | Android | PC |
|---|---|---|
| Navigation | barre du bas (5 icônes) | rail vertical (8 icônes) |
| Vues intelligentes | Aujourd'hui, Boîte de réception, Étiquettes | Today, Next 7 Days, Inbox (+ Tags, Filters en sections) |
| Détail de tâche | feuille du bas | panneau de droite permanent |
| Ajout de tâche | bouton « + » et feuille | champ « Add Task » toujours visible |
| Choix de la date | feuille haute | popover flottant |
| Calendrier | bande semaine + liste | vues Year, Month, Week, Day, Agenda, Multi-Day, Multi-Week |
| Pomodoro | un écran | écran + statistiques et historique |
| Habitudes | bande de 7 jours + liste | bande de 7 jours + panneau de détail |

## C.13 Fonctions confirmées par les captures PC

1. **Tags en pastilles colorées**, ajoutés depuis le panneau de détail (bouton « + »).
2. **Sections dans une liste** (« Add Section ») et **modes d'affichage** Liste, Kanban, Timeline.
3. **Group by / Sort by** configurables par liste (Custom, par date, priorité, etc.).
4. **Show Completed / Show Details / View Options** par liste.
5. **Share, List Activities, Print** (impression de liste).
6. **Modèles de tâche** (« Add from Template ») et **conversion tâche vers note** (« Convert to Note »).
7. **Pièces jointes** et **commentaires** sur les tâches.
8. **Réglages du champ d'ajout** (« Input Box Setting »).
9. **Durée** d'une tâche (onglet « Duration » du sélecteur de date) et affichage en **blocs horaires** dans le calendrier.
10. **Limites de l'offre gratuite** : 9 listes ; calendrier multi-vues réservé à Premium.
11. **Panneau d'historique de concentration** avec cartes de statistiques.
12. **Synchronisation et notifications** accessibles en bas du rail.

## C.14 Ce qu'il manque (captures facultatives, non bloquantes pour la Phase 1)

1. Matrice d'Eisenhower sur PC.
2. Menu de l'avatar et Paramètres sur PC.
3. Vue Kanban et vue Timeline d'une liste.
4. Choix de l'heure, du rappel et de la répétition (sous-pages du popover de date).
5. Écran « Tags » et création d'un filtre.
6. Création d'une habitude et détail d'une habitude.
7. Calendrier en vue Mois, Jour et Agenda.
8. Menu clic droit sur une tâche.
9. Thème clair PC et thème sombre Android (à dériver des jetons de l'annexe D).
