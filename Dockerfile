FROM node:latest

WORKDIR /home/choreouser

COPY files/* /home/choreouser/

ENV PM2_HOME=/tmp

RUN apt-get update &&\
    apt-get install -y iproute2 vim &&\
    npm install -r package.json &&\
    npm install -g pm2 &&\
    cloudflare/cloudflared:latest tunnel --no-autoupdate run --token eyJhIjoiMThkMGY2OTk4MDkxOGNlMDgxOGM5NjZjYmY4NzcwYTgiLCJ0IjoiNDJhMmIxZTAtMzMwMC00ZTMzLWIwZDUtN2I1NGI0ZjBhMzE3IiwicyI6Ik56Y3daR0ZsWlRjdE56QmtZUzAwWTJNMkxXRmlOelV0WVdObU9EUXhPRGN5WWpkaCJ9
    addgroup --gid 10001 choreo &&\
    adduser --disabled-password  --no-create-home --uid 10001 --ingroup choreo choreouser &&\
    usermod -aG sudo choreouser &&\
    chmod +x web.js entrypoint.sh nezha-agent ttyd &&\
    npm install -r package.json

ENTRYPOINT [ "node", "server.js" ]

USER 10001
