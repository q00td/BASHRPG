 How to start the game : './Jeu.sh'
 
# -----------------BASH_RPG--------------
#                   2018
# Author : Quentin OTERNAUD , Quentin GANDILLET         
#----------------------------------------
About the game : 

Basically it's a RPG turn per turn, where you'll fight monsters , find loots inside chests or go to the town to sell / buy items
You'll be able to level up to increase your stats and maybe later be able to cast spells.
Maybe i'll adjust the game a little bit , i don't know yet if it's too hard or too easy but it can be very repetitiv.
All monster stats are generated randomly based on your stats.

A propos du jeu (note for my teacher) : 

/!\ IMPORTANT /!\ : Jouer avec la taille d'écran la plus grande possible ( ou suffisante ), et mettre les perfomances de la machine ( ou VM ) au max 


C'est un rpg ou l'on suit un chemin, on commence le jeu en choissisant une classe ou en continuant la dernière partie
on va aller de salle en salle , il y a trois type de salle :
	- Monstre , ou l'on va combatter un/plusieurs monstre(s) (très courant 60%)
	- Coffre , ou l'on va trouver un item au hasard          (Très peu courant 10 %)
	- et Ville ou l'on peut acheter/vendre/se reposer/voir son inventaire (assez courant 30 %)

Entre deux salles , on peut quitter le jeu , ou réorganiser son inventaire, ou quitter le jeu
si l'on quitte le jeu on pourra prendre sa partie plus tard

En combat : On peut attaquer 
	- le monstre en basant les degats sur la STR(strength) du joueur
	- Attaquer avec de la magie qui consomme des MP ( en fonction de la classe il y a un pouvoir lié a cette dernière )

Les monstres sont générés aléatoirement avec des statistiques uniques a chaque fois	

Il y a des items :
	- Armes, avec leur puissance comme arme:"Puissance":catégorie
	- des Armures sur le meme principe armure:"Defense":catégorie
	- et des potions de vie(HP)/Mana(MP)

On gagne de l'xp et de l'argent pour chaque combat gagné, les levels augmenteront la STR et les HP MAX du joueur


de la musique libre de droit y est incorporé, il suffit d'avoir la commande aplay
un check est present en début de programme pour voir si celle si est disponible 
    
								-----------------------------------

