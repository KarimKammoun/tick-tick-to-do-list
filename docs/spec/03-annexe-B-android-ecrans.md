# ANNEXE B : Écrans supplémentaires Android (détail de tâche, ajout rapide, date, habitudes, paramètres)

> Cette annexe complète l'annexe A (captures `docs/design/android/09` à `13`). **Le mode sombre est maintenant DANS le périmètre** (voir annexe D, qui remplace la décision « thème clair uniquement » prise à ce stade).

## B.1 Feuille « Détail rapide d'une tâche » (bottom sheet) — `android/09-detail-tache-feuille.jpg`

**Principe :** quand on touche une tâche dans la liste, le détail s'ouvre dans une **feuille qui monte du bas de l'écran** (environ 45 % de la hauteur), pas en plein écran. La liste reste visible derrière, **assombrie** par un voile (environ 35 à 40 % de noir). Un appui sur la zone sombre ferme la feuille et enregistre.

**Apparence de la feuille :** fond blanc, **grands coins arrondis en haut** (environ 28 dp), pleine largeur, pas d'ombre.

**Contenu, de haut en bas :**

1. **Ligne d'en-tête :**
   - à gauche : **sélecteur de liste** (nom de la liste en gras, suivi d'une icône **chevrons haut/bas ⇅**) ; un appui ouvre le choix d'une autre liste ;
   - à droite : icône **drapeau** (choix de la priorité) et icône **⋮** (menu : dupliquer, épingler, partager, supprimer, etc.).
2. **Ligne date :** case à cocher carrée à gauche, puis la **date en couleur d'accent** (ex : « Demain, 25 nov. »). Un appui ouvre le sélecteur de date (voir B.3).
3. **Titre de la tâche :** gras, environ 22 sp, modifiable directement.
4. **Description :** texte normal, 17 sp, modifiable directement. Elle apparaît en gris sous le titre dans la liste.
5. **Barre d'outils en bas (3 icônes de contour fin) :**
   - **Étiquette** (tag) : ajouter un tag ;
   - **Liste à puces / sous-tâches** (checklist) : ajouter des sous-tâches ;
   - **Trombone** : ajouter une pièce jointe.

## B.2 Feuille d'ajout rapide (bouton « + ») — `android/10-ajout-rapide.jpg`

**Principe :** un appui sur le bouton flottant « + » ouvre une feuille blanche en bas de l'écran, avec le **clavier ouvert automatiquement** et le curseur actif dans le champ. La liste derrière est assombrie.

**Contenu :**

- **Champ de saisie** (environ 2 lignes de haut) avec le texte indicatif gris **« Que voulez-vous faire ? »**.
- **Barre d'icônes** sous le champ, de gauche à droite :
  1. **Puce de date** : icône calendrier + texte **en accent** (« Aujourd'hui » par défaut dans la vue Aujourd'hui) ; un appui ouvre le sélecteur de date ;
  2. **Drapeau** (priorité), gris ;
  3. **Étiquette** (tag), gris ;
  4. **Déplacer vers une liste** (boîte avec flèche), gris ;
  5. **« ⋯ »** (plus d'options : rappel, pièces jointes, etc.) ;
  6. **Micro** (dictée vocale), tout à droite, gris.
- **Validation :** la touche ✓ du clavier ajoute la tâche. La tâche est créée dans la **liste actuelle** et avec la **date du jour** si on est dans la vue « Aujourd'hui ».
- La reconnaissance en langage naturel (section 5.6 de la base) s'applique dans ce champ.

## B.3 Sélecteur de date (feuille haute) — `android/11-selecteur-date.jpg`

**Apparence :** feuille qui occupe environ **80 % de la hauteur** de l'écran, fond gris très clair `#F7F7F7`, coins arrondis en haut.

**En-tête :**

- À gauche : **✕** (fermer sans enregistrer).
- Au centre-gauche : deux onglets **« Date »** (actif : accent, gras, soulignement) et **« Durée »** (inactif : gris). L'onglet **Durée** sert à définir une **plage** (début et fin) ou une durée estimée.
- À droite : **✓** (valider).

**Calendrier du mois :**

- Titre du mois en gras (ex : « novembre ») à gauche, avec deux chevrons **« < »** et **« > »** gris à droite pour changer de mois.
- En-têtes des jours (lun. mar. mer. jeu. ven. sam. dim.) en gris ; **la semaine commence le lundi**.
- Grille de nombres, 17 sp ; le **jour choisi** est dans un **disque d'accent plein** avec le chiffre en blanc.
- Raccourcis (Aujourd'hui, Demain, Semaine prochaine, Ce soir) : visibles sur la version PC (annexe C.6), à ajouter aussi sur mobile.

**Carte « Options de la date » (blanc, coins arrondis, 3 lignes) :**

| Ligne | Icône | Valeur par défaut | Action |
|---|---|---|---|
| **Heure** | horloge | « Aucun > » | ouvre le choix d'une heure précise |
| **Rappel** | réveil | « Aucun > » | ouvre le choix des rappels (section 5.4 de la base) |
| **Récurrence** | flèches circulaires | « Aucun > » | ouvre le choix de la répétition (section 5.5 de la base) |

**Pied de page :** bouton texte rouge **« Effacer »** centré (supprime la date, l'heure, le rappel et la récurrence).

## B.4 Écran « Habitude » — `android/12-habitudes.jpg`

**Accès :** depuis l'icône « ⋯ » de la barre du bas (celle-ci reste **en accent** quand on est sur cet écran).

**Barre supérieure :** titre **« Habitude »** en gras. À droite, 3 icônes de contour fin :

1. **Statistiques** (horloge-camembert) ;
2. **Journal / cartes** (rectangle arrondi vertical) : journal ou archive des habitudes ;
3. **Réglages / filtres** (curseurs) : tri, affichage, habitudes archivées.

**Bande des 7 derniers jours :**

- Différence avec le calendrier : la bande va **des 6 jours précédents jusqu'à aujourd'hui** (aujourd'hui tout à droite), pas du lundi au dimanche.
- Jour sélectionné (aujourd'hui) : **disque d'accent plein**, chiffre blanc ; initiales des jours en gris au-dessus.
- Balayage horizontal pour remonter dans le passé.

**État vide (aucune habitude prévue pour ce jour) :**

- Illustration centrée : **réveil** avec une petite carte à visage souriant, sur une forme grise douce, quelques étoiles ;
- Titre : **« Vous avez une journée libre »** (gras) ;
- Sous-titre gris : **« Chaque petit effort compte »**.

**Autres éléments :** bouton flottant **« + »** (créer une habitude).

*Remarque :* la liste des habitudes du jour (cases à pointer, séries) n'est pas visible ici ; se référer à la section 5.10 de la base et aux widgets de l'annexe A.9.

## B.5 Écran « Paramètres » — `android/13-parametres.jpg`

**Accès :** icône « ⋯ » de la barre du bas ; titre **« Paramètres »** en gras.

**Bloc profil (en haut, sans carte) :**

- **Grand avatar rond** (environ 74 dp) avec l'initiale en blanc ; **badge couronne** gris sur le haut droit (Premium non actif) ;
- Nom complet en **gras**, 22 sp ;
- Sous le nom, **deux pastilles de gamification** :
  - **Niveau** : hexagone vert avec logo + texte « Lv.7 », fond dégradé vert ;
  - **Badges** : médaille gris-bleu + texte « 16 des badges », fond gris-bleu foncé ;
- **Chevron « > »** à droite : ouvre la page du compte (profil, mot de passe, déconnexion).

**Carte « Compte Premium » (blanche) :**

- Disque orange avec couronne blanche à gauche ;
- Titre **« Compte Premium »** et sous-titre gris **« Vue calendrier et autres fonctions. »** ;
- Bouton **pilule contour orange**, texte orange : **« Mettre à jour maintenant »**.

**Carte « Barre d'onglets » (une seule ligne) :** icône de 4 carrés, libellé, chevron. **Permet de choisir quels onglets apparaissent dans la barre du bas** et leur ordre.

**Carte principale de réglages (6 lignes) :** chaque ligne = icône pleine de 24 dp + libellé 17 sp + chevron gris, hauteur environ 50 dp.

| Ligne | Icône | Contenu probable |
|---|---|---|
| **Apparence** | rouleau de peinture | thème clair/sombre/système, couleur d'accent, taille du texte, densité |
| **Date et heure** | horloge | format d'heure, premier jour de la semaine, fuseau horaire |
| **Sons & Notifications** | note de musique | sons, vibration, rappel quotidien, heures calmes |
| **Widgets** | widgets | la galerie décrite en A.9 |
| **Fonctionnalités d'IA** | étincelles | assistant IA, saisie intelligente |
| **Général** | liste à puces | langue, liste par défaut, date par défaut, etc. |

**Carte suivante :** **« Intégrations et Import »** (icône flèche verte) : calendriers externes (Google, Outlook), import depuis d'autres applications.

**Suite de la page (non visible) :** probablement Aide et commentaires, À propos, Confidentialité.

## B.6 Barre d'onglets personnalisable

- La barre du bas est **configurable** depuis Paramètres > Barre d'onglets.
- Onglets connus : **Tâches, Calendrier, Matrice d'Eisenhower, Concentration, Habitude, Plus (⋯)**. Seuls 5 emplacements sont affichés ; l'utilisateur choisit lesquels.
- L'onglet « ⋯ » reste actif quand on est sur Habitude ou Paramètres : cet emplacement sert de **point d'accès aux onglets masqués** et aux paramètres.
- L'icône du calendrier peut afficher le **numéro du jour** (ex : « 24 ») ou être vide selon l'écran.

## B.7 Gamification et niveaux

- **Niveau** (Lv.1, Lv.2, …) qui augmente avec les tâches terminées (système de points).
- **Badges** pour des réussites : séries, nombre de tâches, heures de concentration, etc.
- Affichés dans le profil des Paramètres.
- Fonction facultative : phase 4.

## B.8 Règles de design confirmées

- **Tout se fait dans des feuilles basses** (bottom sheets) : détail de tâche, ajout rapide, sélecteur de date ; elles ont **toutes des coins supérieurs très arrondis (≈ 28 dp)** et un **voile sombre** sur la page derrière.
- Les **actions principales sont en couleur d'accent** (bleu `#4772FA` par défaut), les **actions destructrices en rouge** (« Effacer »), les **actions Premium en orange** (couronne, « Mettre à jour maintenant »).
- Les **icônes d'action** sont en **contour fin** (24 dp) ; les **icônes des réglages** sont **pleines et colorées**.
- Les listes de réglages sont en **cartes blanches** groupées, séparées par un espace (pas de traits).
- Les **états vides** ont une illustration + titre gras + sous-titre gris encourageant.
- **Langue de l'interface :** français sur Android, anglais sur PC (capture) ; la langue est un réglage. Prévoir l'arabe (RTL).
