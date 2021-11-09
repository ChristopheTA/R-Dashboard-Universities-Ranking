# INTRODUCTION

Le projet ici que nous avons réalisé est l'étude des données concernant le classement mondial des meilleures universités. 

Nous avons utilisé comme jeu de données les valeurs venant de l'institut [`Times Higher Education (THE)`](https://www.timeshighereducation.com/) étant l'une des plus connues et des plus influentes dans les mesures des données universitaires. 

Le dataset de départ comporte des notes des écoles sur plusieurs années concernant par exemple l'enseignement, la recherche ou encore le score total de l'université. D'autres données ont également été utiles pour un différent type d'étude géographique comme la répartition d'étudiants internationaux ou encore le rapport femme/homme. 

Toutes ces informations nous amènent à répondre à la problematique suivante: `Quel est l'état de la haute éducation dans le monde ?`

# INSTALLATION ET UTILISATION DES FICHIERS

## Installation de Git et récupération des fichiers

Verifiez tout d'abord que vous avez installé [Git](https://git-scm.com/) pour la récupération des fichiers

Nous allons maintenant cloner le projet dans le répertoire de votre choix. Pour cela, cliquez sur votre répertoire et faîtes clique-droit `Git Bash Here`

IMAGE

Une fois Git Bash ouvert, nous allons cloner le répertoire en ligne où se trouve le projet. Cliquez sur le bouton `Clone or Download` et copiez l'adresse HTTPS du [répertoire](https://git.esiee.fr/tac/r-and-data-visualisation.git).
Une fois copié, retournez dans Git Bash et tapez la commande `git clone` https://git.esiee.fr/tac/r-and-data-visualisation.git et cela vous donnera un accès de téléchargement au répertoire.
Finalement, tapez la commande `git pull` et vous aurez à votre disposition tous les fichiers du projet. 


## Comprendre les fichiers

Voici l'inventaire des fichiers présents dans notre projet :
- le dossier [`Data`](https://git.esiee.fr/tac/r-and-data-visualisation/-/tree/master/Data) contenant le [dataset](https://www.kaggle.com/mylesoneill/world-university-rankings?select=timesData.csv) (jeu de données) au format `csv`, un fichier [continents2](https://www.kaggle.com/andradaolteanu/country-mapping-iso-continent-region), ainsi qu'un fichier [`GeoJSON`](https://datahub.io/core/geo-countries#resource-countries) pour la représentation géographique
- le fichier [`global.R`](https://git.esiee.fr/tac/r-and-data-visualisation/-/blob/master/global.R) qui est utilisé pour la lecture des fichiers ci-dessus et le nettoyage des données
- le fichier [`ui.R`](https://git.esiee.fr/tac/r-and-data-visualisation/-/blob/master/ui.R)  qui est utilisé pour l'aspect graphique de l'interface utilisateur et la définition des entrées
- le fichier [`server.R`](https://git.esiee.fr/tac/r-and-data-visualisation/-/blob/master/server.R)  qui est utilisé pour la préparation des données et de la construction des sorties
- le fichier [`project.Rproj`](https://git.esiee.fr/tac/r-and-data-visualisation/-/blob/master/project.Rproj) qui permet d'ouvrir le projet dans sa globalité
- le dossier [`www`] (https://git.esiee.fr/tac/r-and-data-visualisation/-/tree/master/www) pour l'image de la page (représentant notre école :) )


# USER'S GUIDE

## Installation des packages nécessaires

Verifiez tout d'abord si vous disposez de la bonne version de R. Pour cela :
- ouvrir le logiciel RStudio
- dans la console, tapez la commande `R.version`
- vérifiez si la version est compatible avec la version utilisée, ici `4.1.1`

Certains packages seront également nécessaires à installer. Les commandes d'installation sont déjà écrites sur les 10 premières lignes du fichier [`global.R`]. Si ces packages sont déjà installés et présents dans la librairie, vous recevrez un message d'avertissement vous demandant de mettre à jour ces packages. Vous pouvez appuyer sur Non/No et ignorer ces messages, ou commenter les lignes d'installation.
Voici l'utilité de ces packages :
- le package tidyverse permet de manipuler les données plus facilement
- le package shiny permet la création de notre application R shiny
- le package leaflet permet la création de cartes interactives
- le package geojsonio permet de lire et manipuler les fichiers GeoJSON
- le package shinythemes permet de donner un thème à notre dashboard

## Fonctionnement du Dashboard

Pour lancer le dashboard, ouvrez le fichier `project.Rproj`, puis appuyez sur le bouton `Run App` en haut à droite de l'éditeur. Une fenêtre va alors apparaître, et vous pourrez accéder au dashboard.

Une fois la page cherchée, vous pourrez apercevoir 4 onglets à parcourir nommés respectivement `Graph`, `Histogram` et `Map` et `Top 10` qui contiennent chacun différent type de graphique représentant notre dataset. 

Sur chacun de ces onglets, vous verrez une barre horizontale appelée `Year` qui permettra de changer l'année des données étudiées. Il y aura aussi une flèche au-dessous de cette barre qui permettra de faire défiler les années automatiquement.

Dans le premier onglet, vous avez un graphique sur lequel vous pouvez sélectionner quelles variables seront affichées sur l'axe des ordonnées et l'axe des abscisses. 

Dans le deuxième onglet, de la même manière, vous pouvez sélectionner quelle variable sera comptée et affichée sur un histogramme.

Dans le troisième onglet, vous aurez une représentation géographique du nombre d'universités par pays ou du nombre d'étudiants par pays au choix. Comme vous pourrez le voir, il y a peu de pays affichés en 2011, et plus les années suivantes, car le classement varie et de nouvelles entrées et sorties d'universités se font chaque année. 


# DEVELOPPER'S GUIDE

Le code est réparti en 3 fichiers distincts (`global.R`,`ui.R`,`server.R`). Nous allons voir comment chacun d'eux fonctionne.

## Global

La lecture des fichiers est simple. On va lire dans le dossier `Data` le dataset `timesData.csv` avec la fonction `read.table()`. Comme il s'agit d'un fichier csv, le séparateur est une virgule et la première ligne correspond aux noms des colonnes. On obtient ainsi notre dataframe. On va aussi lire le fichier `continents2.csv`, et le fichier`country.geojson` avec la fonction `read.geojson()` présente dans le package geojsonio.

Nous avons ensuite dû faire un nettoyage des données.
Tout d'abord, nous avons dû renommer certains noms de pays, soit parce qu'ils étaient mal écrits, soit pour que les dataframes soit compatibles entre elles, et avec notre fichier geojson. Nous les fusionnons ensuite.

Nous avons aussi dû changer le type de certaines variables pour mieux les utiliser. En effet, certaines données numériques telles que des pourcentages ou le rang de l'université étaient de type char, nous les avons alors changer en entier ou en numérique.

Le nettoyage des données terminé, nous pouvons donc récupérer les fonctions qui définissent l'interface utilisateur et le serveur avec la fonction `source()`, puis on lance le dashboard avec la fonction `shinyApp()`.

## UI

Maintenant que les données sont prêtes à être utilisées, il nous faut la partie `front-end` de la page pour pouvoir les manipuler de manière interactive.

Nous avons utilisé la fonction `fluidPage()` pour créer notre interface utilisateur. Nous avons ensuite décidé de séparer les différents affichages à l'aide de la fonction `navbarPage()` qui crée une barre de navigation. Dans cette fonction, nous pouvons ainsi créer plusieurs onglets avec la fonction `tabPanel()`.

Chaque onglet est défini par un `sidebarLayout()`. Celui-ci contient un `sidebarPanel()` utilisé pour faire changer les variables, et un `mainPanel()` montrant les figures.

## Server

Une fois l'esthétique de la page faite, il nous faut la partie `back-end` de la page pour préparer les données en fonctions des variables de l'interface utilisateur et construire les figures. 

Notre serveur est une fonction prenant deux paramètres `input` et `output`, qui nous permettent de relier le serveur à notre interface utilisateur. Chaque entrée est un attribut de `input`, et chaque sortie est un attribut de `output`.

Chaque sortie sera créée avec une fonction de type render, qui prend en paramètre une valeur de sortie qu'on définit par une fonction avec des accolades. Pour chacune, on va filtrer la dataframe en fonction des entrées, par exemple en fonction de l'année choisie sur l'un des slider.

Pour la création de la carte, nous allons tout d'abord utiliser la fonction `group_by()` pour grouper la dataframe par pays, puis utiliser `summarize()` pour obtenir les données statistiques que nous allons afficher.
Nous devons ensuite créer une palette de couleurs et des étiquettes, variables qui changent selon la catégorie choisie sur l'interface utilisateur.
Nous allons ensuite manipuler le fichier geojson. Nous allons le filtrer pour n'avoir que les pays présents dans notre dataframe, puis l'ordonner de la même manière que notre dataframe pour que les pays affichés sur la carte correspondent aux pays de la dataframe.

Nous pouvons enfin créer notre carte avec la fonction `leaflet()`, à laquelle nous ajoutons des polygones définissant les pays, et nous faisons varier la couleur en fonction de la valeur choisie sur l'interface utilisateur.


## Exploration et pistes de recherche

Nous avons plusieurs pistes d'amélioration pour notre code.
Dans un premier temps, nous pensons qu'il serait intéressant de pouvoir se focaliser sur les États-Unis, pays qui rassemble les meilleures universités du monde. On pourrait alors voir la répartition de ces universités entre chaque état, et observer les divergences dans le pays lui-même.
Nous pensons aussi qu'utiliser les autres datasets des autres instituts serait pertinent. On pourrait par exemple fusionner les datasets pour obtenir plus de données d'universités, ou alors comparer ces datasets pour distinguer les différences dans les critères de notation.


# RAPPORT D'ANALYSE

Analysons et interprétons les données dans leur ensemble pour répondre à la problématique. On sait que d'après les données que nous voyons et de manière générale, les universités Américaines monopolisent le classement comme on peut le voir au niveau du tableau Top 10 au fil des années (jusqu'en 2016).

Intéressons-nous plus au valeur données par le Graphe sur différents critères. Est-ce que les meilleures écoles en général dominent vraiment sur tous les critères ? 

La réponse est à première vue non, puisque si par exemple on veut tracer le score total en fonction du pourcentage d'étudiants à l'international, on remarque que c'est plutôt les pays d'Europe qui ont certes un score total un peu moins élevé mais une répartition d'étudiants étrangers un peu plus égale pouvant aller jusqu'à 50 % d'étudiants étrangers contre maximum 35 % d'étudiants internationaux dans les universités américaines, ce qui montre bien que l'éducation aux Etats-Unis restent tout de même un privilège pas accessible à tout le monde. C'est pourquoi sur le critère `International`, l'Europe a en moyenne de meilleurs résultats.

Pour le reste des critères numériques à savoir l'enseignement, la recherche, les citations et les revenus, les universités d'Amérique du Nord ont de meilleurs résultats en moyenne, suivi de l'Europe, l'Asie, l'Océanie et l'Afrique, ce qui se voit en détail sur le tableau des 10 meilleures universités de chaque année, avec les Etats-Unis et le Royaume-Uni se partageant majoritairement les places.  

Bien que les nombres jouent en faveur des pays Anglosaxons, on peut voir que cela reste tout de même juste un échantillon du reste des universités. On peut voir sur la deuxième représentation graphique un histogramme des valeurs numériques en globalité et le résultat montre que chaque critère a une moyenne de scores importante entre 20 et 40 sur l'ensemble des universités, montrant bien la notation pointue des critères de l'institut THE. 

Analysons maintenant ces valeurs et cherchons si certaines d'entre elles sont liées en changeant les variables sur les axes du graphique et en observant si cela forme une régression. On constate que hormis entre la note de l'international et le taux d'elèves internationaux, et la note d'enseignement et le score total, très peu de données corellent entre elles, ce qui montre l'impact du taux d'enseignement dans la notation du score total de chaque université.    

Qu'en est-il de la représentation géographique et comment faire la relation avec les scores obtenus ? On constate que les nombres jouent en la faveur des Etats-Unis avec un nombre conséquent d'universités et de nombres d'étudiants dans le haut du classement. 

Si maintenant on s'intéresse aux valeurs de ratio, on constate que dans les pays où les universités sont bien classées ayant les plus hauts `Total Score`, ont un `Student / Staff Ratio` assez bas, ce qui signifie qu'un intervenant va gérer un nombre d'élève assez bas, ce qui peut expliquer une meilleure méthode et donc de meilleurs résultats. 

Le critère `International Students` comme vu précédemment présente des résultats assez homogènes au fil des années, avec en tête de valeurs la Russie et l'Australie aux alentours des 40 % en moyenne.   
Le dernier ratio `Female / Male Ratio` montre avec 'surprise' que la haute éducation a une forte tendance féminine en majorité sur tout le globe sur toutes les années. 

En conclusion, bien que la valeur du score total d'une université reflète en grande partie son niveau académique, il se peut que certains critères passent à la trappe alors qu'ils sont pertinents dans l'étude d'un classement. Certaines valeurs 'qualitatives' montrent que leur étude se doit d'être pertinente pour peut-être pouvoir proposer un différent type de classement. On comprend désormais mieux numériquement pourquoi certaines universités américaines, notamment celles de la `Ivy League` se distinguent mieux dans les sondages et médias par ce qu'elles représentent dans les scores en comparaison avec les autres universités.   






