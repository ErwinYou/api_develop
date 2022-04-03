FROM node:lts-alpine

# Add git as the prebuild target requires it to parse version information
RUN apk add --no-cache --virtual .gyp \
  python3 \
  make \
  g++

# Create app directory
WORKDIR /app

ADD . /app/

COPY . .

RUN npm install -g pnpm \
    && pnpm i --unsafe-perm=true \
    && cp packages/hoppscotch-app/.env.example packages/hoppscotch-app/.env \
    && pnpm run generate

CMD ["pnpm", "run", "start"]
