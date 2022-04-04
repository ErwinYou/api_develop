FROM node:lts-alpine as build
# Add git as the prebuild target requires it to parse version information
RUN apk add --no-cache --virtual .gyp \
  python3 \
  make \
  g++
# Create app directory
WORKDIR /app
ADD . /app/
COPY . .
RUN npm install -g pnpm
RUN pnpm i --unsafe-perm=true
RUN mv packages/hoppscotch-app/.env.example packages/hoppscotch-app/.env
RUN pnpm run generate

FROM node:lts-alpine
WORKDIR /app
COPY --from=build /app /app
CMD ["pnpm", "run", "start"]