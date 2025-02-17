# Étape 1 : Build (ne fait qu'installer les dépendances)
FROM node:16 AS builder

# Définir le répertoire de travail
WORKDIR /app

# Copier uniquement les fichiers nécessaires pour l'installation des dépendances
COPY package*.json ./

# Installer toutes les dépendances (prod + dev pour le build)
RUN npm install

# Copier le reste du code source (mais on ne fait pas le build ici)
COPY . .

# Étape 2 : Production (image finale plus légère)
FROM node:16-slim

# Définir le répertoire de travail
WORKDIR /app

# Copier uniquement les fichiers nécessaires pour exécuter l'application
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/index.js ./
COPY --from=builder /app/docker-compose.yml ./

# Exposer le port de l'application
EXPOSE 8080

# Lancer l'application
CMD ["node", "index.js"]
