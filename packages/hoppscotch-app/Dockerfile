FROM node:lts-alpine as build
# Add git as the prebuild target requires it to parse version information
# RUN apk add --no-cache --virtual .gyp \
#   python3 \
#   make \
#   g++
# Create app directory
# RUN apk add --no-cache pnpm
WORKDIR /app
ADD . /app
COPY . .
RUN npm i -g pnpm && pnpm i --unsafe-perm=true && pnpm generate
# RUN pnpm install
# RUN mv .env.example .env

FROM node:lts-alpine
WORKDIR /app
COPY --from=build /app /app
CMD ["pnpm", "start"]