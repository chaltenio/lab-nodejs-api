# Build: docker build -f node.dockerfile -t chalten/nodeapp_api:1.0.0 .

# Create a custom bridge network and add container into it
# docker network create --driver bridge nodeappisolated_network

# NOTE: $(pwd) in the following line is for Mac and Linux. See https://blog.codewithdan.com/docker-volumes-and-print-working-directory-pwd/ for Windows examples.
# docker run -d --net=nodeappisolated_network --name nodeapp_api -p 5000:5000 -v $(pwd)/logs:/var/www/logs chalten/nodeapp_api
# docker run -d --net=nodeappisolated_network --name nodeapp_api -p 5000:5000 -v [pathToYourProject]]/logs:/var/www/logs chalten/nodeapp_api:1.0.3

# Seed the database with sample database
# Run: docker exec nodeapp_api node seeder.js


FROM        node:alpine

LABEL       author="mate.dev/chris"

ARG         PACKAGES=nano

ENV         TERM xterm
RUN         apk update && apk add $PACKAGES

WORKDIR     /var/www
COPY        package.json package-lock.json ./
RUN         npm install

COPY        . ./
EXPOSE      $PORT

ENTRYPOINT  ["npm", "start"]