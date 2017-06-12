FROM java:8

MAINTAINER edewit

ADD https://github.com/itzg/restify/releases/download/1.0.3/restify_linux_amd64 /usr/local/bin/restify
RUN chmod +x /usr/local/bin/*

RUN apt-get update && apt-get install -y jq nano

RUN adduser --disabled-password --gid 0 --gecos "Minecraft" minecraft
WORKDIR /home/minecraft
RUN mkdir data
RUN mkdir config
RUN mkdir mods
RUN mkdir plugins
RUN chown -R minecraft:root /home/minecraft
RUN chmod -R 775 /home/minecraft
USER minecraft

ENV HOME=/home/minecraft

EXPOSE 25565 25575

COPY start-minecraft.sh /home/minecraft/start-minecraft.sh
COPY mcadmin.jq config

# VOLUME ["/home/minecraft"]
COPY server.properties /tmp/server.properties
WORKDIR data

ENTRYPOINT [ "/home/minecraft/start-minecraft.sh" ]

ENV MOTD="A Minecraft Server Powered by Docker" \
    JVM_OPTS="-Xmx1024M -Xms1024M" \
    TYPE=VANILLA VERSION=LATEST FORGEVERSION=RECOMMENDED LEVEL=world PVP=true DIFFICULTY=easy \
    LEVEL_TYPE=DEFAULT GENERATOR_SETTINGS= WORLD= MODPACK= ONLINE_MODE=false CONSOLE=true
