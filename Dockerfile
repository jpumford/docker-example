FROM node:lts as frontend-build
WORKDIR /app
ADD docker-example-frontend/package.json /app
RUN npm install
ADD docker-example-frontend /app
RUN npm run build
# /app/dist now has frontend build

FROM node:lts
WORKDIR /app
ADD docker-example-backend/package.json /app/package.json
RUN npm install --production
ADD docker-example-backend /app
COPY --from=frontend-build /app/dist /app/public

ENV NODE_ENV=production
USER node

CMD ["node", "bin/www"]
