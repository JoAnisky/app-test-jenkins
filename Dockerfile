# Utilisation de l'image officielle Node.js
FROM node:16

# Créer un répertoire pour l'application
WORKDIR /app

# Copier package.json et installer les dépendances
COPY package*.json ./
RUN npm install

# Copier tous les fichiers dans le conteneur
COPY . .

# Exposer le port de l'application
EXPOSE 3000

# Lancer l'application
CMD ["node", "index.js"]
