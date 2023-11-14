## Rédaction des tests

Pour m'assurer que mon application est prête pour une charge de travail en production, je dois tester au moins :

1. Que mon code est conforme aux conventions (conventions publiques ou d'entreprise).
2. Que mon code ne présente aucune faille de sécurité identifiée (je ne veux pas exposer les données de mes clients).
3. Que je suis capable d'exécuter mon code dans un environnement contrôlé.
4. Que je suis capable de faire une requête pour obtenir un vote (je dois obtenir un code 200 en réponse à ma requête GET), puisque je suis dans un environnement contrôlé, je dois obtenir 0 pour chaque catégorie.
5. Que je suis capable de faire une requête pour publier un vote (je dois obtenir un code 200 en réponse à ma requête POST), puisque je suis dans un environnement contrôlé, je dois obtenir 1 pour celui pour lequel j'ai voté et 0 pour les autres.

## Workflows

### Ouverture d'une pull request

Ce workflow est déclenché lorsque vous travaillez sur différentes branches et que vous souhaitez fusionner votre branche avec ```main```.

1. Une pull request est ouverte.
2. Je vérifie si le code respecte les conventions Python en utilisant Flake8 (car je respecte les conventions d'écriture Python).
3. Je vérifie s'il y a des CVE ouverts, pour m'assurer que mon code est sécurisé. La dernière chose que je veux, c'est d'envoyer une faille de sécurité sur mon environnement de production.
4. Je m'assure que dans un environnement contrôlé (ici en utilisant docker-compose), mon système fonctionne comme prévu et que je peux interagir avec lui.
5. Si, et seulement si, toutes ces exigences sont satisfaites, je suis en mesure de fusionner mon code dans ```main```.

![Flow](docs/Simplon-PR-Opened-Workflow.drawio.svg)

### Fusion d'une pull request

Ce workflow sera déclenché lorsqu'un examinateur ou moi-même cliquerons sur le bouton de fusion.

1. Le robot de version sémantique est déclenché, il analyse les messages de commit pour calculer le numéro de version. Une fois terminé, il publie une version sur GitHub https://www.conventionalcommits.org/en/v1.0.0/.
2. Je me connecte à mon registre Docker pour pouvoir pousser mon image Docker.
3. Je prépare l'environnement pour pouvoir construire mon Dockerfile.
4. Je construis mon Dockerfile et le nomme en utilisant ce format ```<Registre Docker>/<Nom du référentiel>:<Version de la version sémantique>``` (par exemple, joffreydupire/simplon-vote-app:v1.0.0), puis je le pousse vers le registre.
5. Enfin, en utilisant la commande ```helm upgrade```, je déploie ma charge de travail Azure-Vote-App dans mon cluster K8s.

> NOTES: À partir de là, je pourrais décider de déployer un canary ou d'utiliser une ligne Blue/Green.

![Flow](docs/Simplon-PR-Merged-Flow.drawio.svg)
