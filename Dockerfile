# FROM haxe:4.0-alpine as build-client

# WORKDIR /app

# COPY ./build.hxml /app/
# RUN haxelib install --always bulid.hxml

# COPY ./src /app/
# RUN haxe build.hxml


# FROM node:10.16-alpine as build-server

# WORKDIR /server

# COPY --from=build-client /app/bin/

FROM node:14-alpine

WORKDIR /app

COPY package.json /app/
COPY package-lock.json /app/
RUN npm install --production

COPY server /app/server
COPY bin /app/bin

EXPOSE 3000

CMD ["npm", "start"]

