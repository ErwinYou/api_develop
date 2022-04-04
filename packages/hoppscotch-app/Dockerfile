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
RUN npm i -g pnpm
RUN pnpm install
# RUN pnpm i --unsafe-perm=true
# RUN mv .env.example .env
RUN pnpm generate

FROM node:lts-alpine
WORKDIR /app
COPY --from=build /app /app
CMD ["pnpm", "start"]