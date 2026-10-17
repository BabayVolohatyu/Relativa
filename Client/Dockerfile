FROM node:22-alpine AS base
RUN apk add --no-cache curl
WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY index.html redirect.html vite.config.ts tsconfig.json tsconfig.app.json tsconfig.node.json postcss.config.js tailwind.config.js env.d.ts ./
COPY public ./public
COPY src ./src
RUN chown -R node:node /app

USER node

EXPOSE 3000

CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0", "--port", "3000"]
