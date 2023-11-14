# Utilisez une image Python officielle comme base
FROM python:3.9

# Définissez le répertoire de travail
WORKDIR /app

# Copiez les fichiers nécessaires dans le conteneur
COPY . .

# Installez les dépendances
RUN pip install -r requirements.txt

# Exposez le port sur lequel l'application écoute
EXPOSE 8080

# Commande pour démarrer l'application
CMD ["python", "app.py"]
