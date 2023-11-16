# Correction

## Dockerfile
Le dockerfile n'est plus necessaire puisqu'on deploie depuis Packer avec Ansible

## Docker compose
Penser a modifier le service, il n'est plus necessaire de le build, par contre on doit lui donner la bonne image

## Ansible Playbook et Role
### Playbook
Le playbook commence par bootstrap python sur le container car il est indispensable pour que Ansible fonctionne correctement.
Ensuite on appelle le role deps qui permettra d'installer les dependances pip necessaire a l'execution de mon code, je passe par une variable afin de pouvoir en ajouter facilement si mon code evolue
Enfin je copie le code source sur la destination.

> Je n'ai pas besoin d'inventaire dans ce cas parce que Packer se debrouillera seul pour faire la connexion 
### Role Deps
Ce role fonctionne avec Ubuntu et Alpine (une autre distribution linux) en utilisant ```when``` je cree une condition pour executer les bonne tache sur la bonne distribution.
Avec ```check_packages``` je m'assure que python3-pip est bien installe, si oui alors je lance l'installation des package pip que je reçois en parametre avec ma variable ```{{ pip_packages }}```

## Packer
Je definis dans le bloc Packer l'ensemble de mes dependances, je veux build un container et je provisionne avec Ansible, donc je dois retrouver Docker et Ansible.

Mon bloc source quand a lui recupere la derniere version d'Ubuntu, cependant je modifie legerement comment elle devra demarre a la fin avec l'argument ```ENTRYPOINT``` si ENTRYPOINT est une chaine de caractere il ignore CMD et Ubuntu demarre avec un CMD par defaut donc je m'assure comme ça de demarrer avec mes parametres.

Le bloc build est assez simple la seule difficulte vient du post-processor "docker-push" qui necessite de recuperer un PAT (Personal Access Token) sur le site de Docker.

## CI/CD
Rien de complexe ici je repete les etapes necessaire comme si je devais faire le setup a la main sur ma machine.
> Attention mon trigger est legerement different avec le ```workflow_dispatch``` il me permet simplement de lancer un pipeline manuellement

## Rappel des commandes 
| commande | Description |
|----|-----|
| ansible-galaxy role init nom_role | Cree un role Ansible |
| ansible-playbook nom_playbook | Lance le playbook |
| packer init . | Initialise packer dans le dossier courant |
| packer validate . | Verifie la syntaxe du fichier Packer |
| packer build . | Lance le build packer |