FROM node:18 as builder

WORKDIR /app
 
COPY package.json yarn.lock ./
RUN yarn install
 
COPY . .
 
RUN yarn run build

FROM node:18-slim as run

LABEL fly_launch_runtime="nodejs"

COPY --from=builder /app /app

WORKDIR /app
ENV NODE_ENV production

CMD [ "node", "lib/scripts/crank.js" ]
