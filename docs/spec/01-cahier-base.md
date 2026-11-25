# Cahier des charges : application To-Do List (Android + PC)

*Document de spécification détaillé pour construire une application de gestion de tâches inspirée de TickTick.*

> **Note importante :** l'objectif est de créer une application **similaire**, avec son propre nom, son propre logo et son propre design. Ne pas copier la marque, le logo, les icônes ou les textes de TickTick.

> **Priorité :** cette partie est la **base**. Les annexes A, B, C et D (dossier `docs/spec/`) la complètent et la **corrigent** : en cas de contradiction, voir l'ordre de priorité dans `docs/SPEC.md`.

---

## 1. Vision du produit

**Nom provisoire :** « TaskFlow » (à remplacer).

**Objectif :** une application de gestion de tâches et de productivité qui regroupe dans un seul outil : liste de tâches, calendrier, rappels, habitudes, minuteur Pomodoro et statistiques, avec synchronisation temps réel entre Android et PC.

**Public cible :** étudiants, travailleurs, freelances, toute personne qui veut organiser son quotidien.

**Principes de conception :**

- Ajout d'une tâche en moins de 3 secondes.
- Interface propre, rapide, sans surcharge.
- Fonctionne hors ligne, synchronise dès que la connexion revient.
- Même expérience sur téléphone et ordinateur, adaptée à chaque écran.

---

## 2. Plateformes et technologies recommandées

### Plateformes

| Plateforme | Type |
|---|---|
| Android | Application native ou multiplateforme (Play Store) |
| PC (Windows, macOS, Linux) | Application desktop |
| Web | Version navigateur (optionnel, phase 3) |

### Stack recommandée (une seule base de code)

- **Flutter** (Dart) : Android, Windows, macOS, Linux et Web.
- **Base de données locale :** SQLite via **Drift**.
- **État :** Riverpod. **Navigation :** go_router.
- **Backend :** Supabase (PostgreSQL + authentification + temps réel). Alternative : Firebase.
- **Notifications :** notifications locales planifiées (Android et desktop) + push (FCM) plus tard.
- **Authentification :** e-mail + mot de passe, Google Sign-In.
- **Paiement Premium (phase finale) :** Google Play Billing + Stripe pour le desktop.

---

## 3. Architecture générale

```
App (Android / PC)
  ├─ Interface (écrans, widgets)
  ├─ Logique métier (gestion tâches, rappels, récurrence, Pomodoro)
  ├─ Base locale SQLite (source de vérité hors ligne)
  └─ Moteur de synchronisation
          ↕ (HTTPS / WebSocket)
Serveur (Auth + API + Base PostgreSQL + Notifications push)
```

**Règle de synchronisation :**

- Chaque donnée a un `id` unique (UUID), un `updated_at` et un `deleted_at` (suppression logique).
- L'app écrit d'abord en local, puis envoie les changements au serveur.
- En cas de conflit : la modification la plus récente gagne (last-write-wins), champ par champ si possible.

---

## 4. Modèle de données

### Utilisateur (`users`)

`id, email, nom, avatar_url, langue, fuseau_horaire, premier_jour_semaine (lundi/dimanche), format_heure (12h/24h), thème (clair/sombre/système), couleur_accent, est_premium, premium_expire_le, créé_le`

### Dossier (`folders`)

`id, user_id, nom, ordre, replié (bool)`

### Liste (`lists`)

`id, user_id, folder_id (nullable), nom, couleur, icône, ordre, type (tâches / notes), mode_affichage_par_défaut (liste / kanban / timeline), archivée (bool), partagée (bool)`

### Tâche (`tasks`)

| Champ | Description |
|---|---|
| id | UUID |
| list_id | Liste d'appartenance (null = Boîte de réception) |
| parent_id | Tâche parente (pour les sous-tâches) |
| titre | Texte court |
| description | Texte long / notes (Markdown simple) |
| statut | à faire / terminée / abandonnée |
| priorité | 0 aucune, 1 basse, 2 moyenne, 3 haute |
| date_début | Date (et heure optionnelle) |
| date_échéance | Date (et heure optionnelle) |
| toute_la_journée | bool |
| fuseau_horaire | Texte |
| récurrence | Règle de répétition (format RRULE) |
| rappels | Liste de décalages (ex : à l'heure, 5 min avant, 1 jour avant) |
| ordre | Position dans la liste |
| section_id | Section / colonne Kanban (nullable) |
| durée_estimée | Minutes |
| pomodoros_estimés | Nombre |
| terminée_le | Date de complétion |
| épinglée | bool |
| créé_le / modifié_le / supprimé_le | Horodatages |

### Tag (`tags`) et liaison (`task_tags`)

`tags : id, user_id, nom, couleur, parent_tag_id`
`task_tags : task_id, tag_id`

### Section (`sections`)

`id, list_id, nom, ordre`

### Pièce jointe (`attachments`)

`id, task_id, type (image / fichier / audio), url, taille, nom`

### Commentaire (`comments`)

`id, task_id, user_id, texte, créé_le`

### Filtre personnalisé (`filters`)

`id, user_id, nom, règles (JSON : listes, tags, priorités, dates, statut)`

### Habitude (`habits`) et pointage (`habit_logs`)

`habits : id, user_id, nom, icône, couleur, fréquence (quotidienne / jours précis / x fois par semaine), objectif (ex : 8 verres), unité, heure_rappel, date_début, archivée`
`habit_logs : id, habit_id, date, valeur, note`

### Session de concentration (`focus_sessions`)

`id, user_id, task_id (nullable), type (pomodoro / chrono), début, fin, durée, note`

### Partage (`list_members`)

`list_id, user_id, rôle (propriétaire / éditeur / lecteur)`

---

## 5. Fonctionnalités détaillées

### 5.1 Gestion des tâches

- Créer, modifier, supprimer, dupliquer une tâche.
- Cocher une tâche : animation de validation + son optionnel ; la tâche passe dans « Terminées ».
- Décocher pour restaurer.
- Glisser-déposer pour réordonner (téléphone : appui long ; PC : souris).
- Glissement latéral sur mobile : droite = terminer, gauche = options (date, supprimer).
- Actions groupées : sélection multiple, puis déplacer, changer de date, changer de priorité, ajouter un tag, supprimer.
- Déplacer une tâche vers une autre liste.
- Épingler une tâche en haut de la liste.
- Sous-tâches : jusqu'à 5 niveaux ; la progression de la tâche parente s'affiche (ex : 2/5).
- Checklist dans une tâche (éléments simples, cochables).
- Description avec formatage simple (gras, italique, liste, titres, liens).
- Pièces jointes : images, fichiers, enregistrement vocal.
- Commentaires et historique d'activité sur la tâche.

### 5.2 Priorités

4 niveaux avec couleur (sur le **contour de la case à cocher**) : aucune (gris), basse (bleu), moyenne (orange/jaune), haute (rouge).

### 5.3 Dates et heures

- Date de début et date d'échéance.
- Heure optionnelle ; option « toute la journée ».
- Raccourcis : aujourd'hui, demain, semaine prochaine, ce soir, sans date.
- Sélecteur de calendrier visuel + sélecteur d'heure.
- Gestion des fuseaux horaires.
- Tâches en retard affichées en rouge.

### 5.4 Rappels et notifications

- Plusieurs rappels par tâche.
- Options : à l'heure exacte, 5 min, 30 min, 1 h, 1 jour avant, personnalisé.
- Boutons dans la notification : **Terminer**, **Reporter** (10 min, 1 h, demain), **Ouvrir**.
- Rappel quotidien récapitulatif (ex : chaque matin à 8h).
- Notifications persistantes jusqu'à action (option).
- Heures calmes (mode ne pas déranger).
- Sons personnalisables et vibration.

### 5.5 Récurrence (tâches répétées)

- Tous les jours, toutes les semaines, tous les mois, tous les ans.
- Jours précis (ex : lundi, mercredi, vendredi).
- Intervalle personnalisé (ex : toutes les 2 semaines, le 3e vendredi du mois).
- Deux modes : « à partir de la date prévue » ou « à partir de la date de complétion ».
- Date de fin : jamais, après N occurrences, ou à une date précise.
- Quand on termine une occurrence, la suivante est créée automatiquement.

### 5.6 Ajout rapide intelligent (langage naturel)

Champ de saisie unique qui détecte automatiquement :

- **Dates et heures :** « demain 14h », « lundi prochain », « dans 3 jours », « tous les vendredis ».
- **Priorité :** `!1`, `!2`, `!3` ou « urgent ».
- **Tag :** `#nom`.
- **Liste :** `~nom` ou `/nom`.
- **Sous-tâche :** indentation.

Les éléments reconnus sont surlignés dans le champ et retirés du titre. Support multilingue (français, arabe, anglais au minimum).

### 5.7 Listes, dossiers, tags, filtres

- **Listes :** nom, couleur, icône, réordonnables, archivables.
- **Dossiers :** regroupent plusieurs listes, repliables.
- **Tags :** multiples par tâche, hiérarchiques, couleur propre, affichés en **pastilles colorées**.
- **Filtres personnalisés :** combinaison de listes, tags, priorités, dates, statut, sauvegardée dans la barre latérale.
- **Vues intelligentes par défaut :** Boîte de réception (Inbox), Aujourd'hui (Today), 7 prochains jours (Next 7 Days), Terminées (Completed), Corbeille (Trash, suppression définitive après 30 jours).

### 5.8 Les vues

1. **Vue Liste :** groupable par date, priorité, tag, liste ; triable par date, priorité, titre, date de création, manuel.
2. **Vue Kanban :** colonnes personnalisables (À faire / En cours / Terminé), glisser-déposer entre colonnes.
3. **Vue Calendrier :** année, mois, semaine, jour, agenda, multi-jours, multi-semaines ; glisser une tâche sur un jour pour changer sa date.
4. **Matrice d'Eisenhower :** 4 quadrants (Urgent + Important, Important non urgent, Urgent non important, Ni l'un ni l'autre).
5. **Vue Timeline (chronologie)** : barres de la date de début à l'échéance (phase 4).
6. **Vue Notes :** pour les listes de type « notes ».

### 5.9 Minuteur de concentration (Pomodoro)

- Durée de concentration par défaut 25 min, pause courte 5 min, pause longue 15 min (tous réglables).
- Pause longue après 4 sessions (réglable).
- Lancer un minuteur lié à une tâche précise.
- Mode chronomètre libre.
- Bruits blancs et sons d'ambiance (pluie, forêt, café, vagues).
- Écran de concentration plein écran.
- Historique des sessions, temps total par tâche.
- Notification de fin de session.

### 5.10 Suivi d'habitudes

- Créer une habitude : nom, icône, couleur, fréquence, objectif quotidien, rappel.
- Pointer chaque jour (case simple ou valeur numérique).
- Série (streak) de jours consécutifs, record.
- Vue calendrier mensuel avec coloration des jours réussis.
- Statistiques : taux de réussite, graphique hebdomadaire/mensuel.
- Phrases de motivation.

### 5.11 Statistiques et tableau de bord

- Nombre de tâches terminées (jour, semaine, mois, année).
- Score de productivité (points selon tâches terminées).
- Graphique de tendance, graphique par liste/tag.
- Heures de concentration (Pomodoro), répartition par tâche/tag.
- Calendrier de chaleur (heatmap) des jours actifs.
- Objectif quotidien de tâches avec progression.

### 5.12 Recherche

- Recherche instantanée dans titres, descriptions, commentaires, tags.
- Filtres de recherche : liste, date, priorité, statut.
- Historique des recherches récentes.

### 5.13 Collaboration et partage

- Partager une liste avec d'autres utilisateurs (invitation par e-mail ou lien).
- Rôles : propriétaire, éditeur, lecteur.
- Assigner une tâche à un membre.
- Commentaires et notifications d'activité.
- Journal des modifications de la liste partagée.

### 5.14 Synchronisation et hors ligne

- Fonctionnement complet sans internet.
- Synchronisation automatique et temps réel quand connecté.
- Indicateur d'état de synchronisation.
- Gestion des conflits (voir section 3).
- Multi-appareils illimité (Android + PC + web).

### 5.15 Widgets et intégrations

- **Widgets Android :** liste Aujourd'hui, ajout rapide, calendrier, habitudes (détail en annexe A.9).
- **Ajout rapide depuis la barre de notifications** (Android).
- **PC :** icône dans la barre système, raccourci clavier global pour ajouter une tâche (ex : Ctrl+Alt+A), démarrage automatique avec le système.
- **Intégration calendrier :** abonnement Google Calendar / Outlook (lecture), export iCal (.ics).
- **Partage vers l'app :** transformer un texte partagé en tâche.
- **Assistant vocal / IA :** ajout vocal de tâche.

### 5.16 Import / Export / Sauvegarde

- Export CSV, JSON, PDF.
- Import CSV et depuis d'autres applications (Todoist, Microsoft To Do, Google Tasks).
- Sauvegarde et restauration cloud.

### 5.17 Paramètres

- **Compte :** profil, mot de passe, supprimer le compte, déconnexion.
- **Général :** langue, fuseau horaire, premier jour de semaine, format de date et d'heure, liste par défaut.
- **Apparence :** thème **clair / sombre / système**, couleur d'accentuation, taille du texte, densité.
- **Notifications :** sons, vibration, rappel quotidien, heures calmes, tâches en retard.
- **Sécurité :** verrouillage de l'application (code PIN, empreinte digitale).
- **À propos :** version, aide, confidentialité, conditions d'utilisation.

### 5.18 Offre gratuite vs Premium (modèle économique)

| Fonction | Gratuit | Premium |
|---|---|---|
| Tâches, rappels, récurrence, tags | Oui | Oui |
| Nombre de listes | **9 maximum** (« Used: 9/9 ») | Illimité |
| Sous-tâches / pièces jointes | Limité | Illimité |
| Vues du calendrier (année, mois, semaine, jour, agenda…) | Aperçu avec données d'exemple | Complet |
| Kanban, Matrice | Partiel | Complet |
| Statistiques avancées, filtres | Non | Oui |
| Partage et collaboration | Limité | Plus de membres |
| Widgets avancés, thèmes | Non | Oui |

---

## 6. Design de l'interface (UI / UX)

> **Les sections 6.1 à 6.6 sont remplacées par les annexes A, B, C et D** (design réel observé sur les captures, thèmes clair et sombre). Seuls les principes généraux ci-dessous restent valables.

- **Style :** minimaliste, moderne, beaucoup d'espace, coins arrondis, ombres très légères ou absentes.
- **Couleur d'accentuation :** bleu `#4772FA` par défaut, modifiable par l'utilisateur.
- **Typographie :** Inter, Roboto ou Noto Sans (arabe : Noto Sans Arabic ou Cairo).
- **Espacements :** grille de 4 px ; zone tactile minimale 44 x 44 px.
- **Animations :** cocher une tâche (rebond + trait), transitions de 200 à 300 ms.
- **Accessibilité :** contraste WCAG AA, tailles de texte ajustables, support **RTL** (arabe), étiquettes pour lecteurs d'écran (TalkBack).
- **Langues minimales :** français, arabe, anglais.

### Raccourcis clavier (PC)

| Action | Raccourci |
|---|---|
| Nouvelle tâche | `N` ou `Ctrl+N` |
| Ajout rapide global | `Ctrl+Alt+A` |
| Rechercher | `Ctrl+F` |
| Terminer la tâche | `Ctrl+Entrée` |
| Supprimer | `Suppr` |
| Changer la priorité | `Ctrl+1/2/3/4` |
| Définir la date | `Ctrl+D` |
| Naviguer | Flèches haut/bas |

---

## 7. Liste des écrans à produire

1. Écran de démarrage / présentation (onboarding, 3 pages).
2. Connexion, inscription, mot de passe oublié.
3. Liste de tâches principale (et ses variantes : Aujourd'hui, Next 7 Days, Inbox, listes).
4. Détail d'une tâche.
5. Feuille d'ajout rapide.
6. Sélecteur de date / rappel / répétition.
7. Gestion des listes, dossiers, tags, filtres.
8. Vue Kanban.
9. Vue Calendrier (jour / semaine / mois / année / agenda).
10. Matrice d'Eisenhower.
11. Minuteur de concentration (Pomodoro) + historique.
12. Habitudes : liste, détail, création.
13. Statistiques.
14. Recherche.
15. Partage et membres d'une liste.
16. Corbeille et tâches terminées.
17. Paramètres (et toutes ses sous-pages).
18. Page Premium / abonnement.
19. Widgets Android (galerie).

---

## 8. Plan de développement par phases

### Phase 1 : MVP (4 à 6 semaines)

- Compte et connexion, base locale, synchronisation de base.
- Tâches : créer, modifier, terminer, supprimer, priorité, date, sous-tâches.
- Listes, dossiers, tags, vues intelligentes (Aujourd'hui, Next 7 Days, Inbox).
- Rappels et notifications locales.
- **Thèmes clair et sombre** (réglage Clair / Sombre / Système) sur Android et PC.
- Android + Windows.

### Phase 2 : Productivité (4 à 6 semaines)

- Récurrence complète, ajout rapide en langage naturel.
- Vue calendrier, vue Kanban, matrice d'Eisenhower.
- Recherche, filtres personnalisés, pièces jointes, commentaires.
- Widgets Android, raccourcis clavier PC.

### Phase 3 : Engagement (4 à 6 semaines)

- Pomodoro, habitudes, statistiques.
- Partage et collaboration.
- Import / export, synchronisation calendrier externe.
- Version web.

### Phase 4 : Monétisation et polish (3 à 4 semaines)

- Abonnement Premium, restrictions gratuit/Premium.
- Timeline (Gantt), assistant vocal/IA, verrouillage de l'app, gamification (niveaux, badges).
- Tests, optimisation des performances, publication Play Store.

---

## 9. Critères de qualité

- Démarrage de l'application en moins de 2 secondes.
- Ouverture d'une liste de 1000 tâches sans ralentissement (listes virtualisées).
- Aucune perte de données, même en cas de coupure réseau.
- Notifications fiables, y compris après redémarrage de l'appareil.
- Tests automatiques pour la récurrence, la synchronisation et les rappels (parties les plus fragiles).
- Respect du RGPD : politique de confidentialité, export et suppression des données de l'utilisateur.

---

## 10. Prompts pour l'agent

Les prompts à donner à l'agent de code (étape par étape) sont dans **`docs/PROMPTS.md`**.
