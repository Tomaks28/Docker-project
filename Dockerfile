# On utilisera l'image node:20-alpine
FROM node:20-alpine AS development

WORKDIR /app

COPY package*.json .

RUN npm install

COPY . .

RUN npm run build

###########

# On utilisera l'image node:20-alpine
FROM node:20-alpine AS production

WORKDIR /app

COPY package*.json .

RUN npm install --only=production

COPY --from=development /app/dist ./dist

CMD ["node", "dist/index.js"]