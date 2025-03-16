# On utilisera l'image node:20-alpine
FROM node:20-alpine as development

# On créé un dossier /app et on se place dedans
WORKDIR /app

# On copie les fichiers `package.json` et `package-lock.json`
COPY package*.json .

# On installe les dépendances
RUN npm install

# On copie le reste des fichiers
COPY . .

# On build le projet => vient créer le dossier dist
RUN npm run build

###########

# On utilisera l'image node:20-alpine
FROM node:20-alpine as production

# On créé un dossier /app et on se place dedans
WORKDIR /app

# On copie les fichiers `package.json` et `package-lock.json`
COPY package*.json .

# On installe uniquement les dépendances de production
RUN npm install --only=production

# On copie le dossier dist de l'image development (qui contient le build en js)
COPY --from=development /app/dist ./dist

# On lance le serveur
CMD ["node", "dist/index.js"]