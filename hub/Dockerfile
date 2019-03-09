FROM alpine:3.9

# Build
RUN apk add --no-cache openjdk8 bash screen &&\
    apk add --no-cache --virtual .build curl git &&\
    mkdir /usr/local/src &&\
    cd /usr/local/src &&\
    curl -fLO https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar &&\
    java -jar BuildTools.jar --rev 1.12.2

# Tools
RUN mkdir -p /usr/local/spigot/bin &&\
    apk add --no-cache gettext mysql-client py2-pip &&\
    apk add --no-cache --virtual=.build2 gcc musl-dev &&\
    cd /usr/local/src &&\
    git clone https://github.com/Tiiffi/mcrcon.git &&\
    cd mcrcon  &&\
    gcc -std=gnu11 -pedantic -Wall -Wextra -O2 -s -o mcrcon mcrcon.c &&\
    mv mcrcon /usr/local/spigot/bin/ &&\
    pip install mcstatus &&\
    pip install awscli
COPY mcrcon /usr/local/bin/
RUN chmod +x /usr/local/bin/mcrcon

# Install
RUN mkdir -p /usr/local/spigot/plugins &&\
    cp /usr/local/src/spigot-1.12.2.jar /usr/local/spigot/ &&\
    cd /usr/local/spigot &&\
    java -jar spigot-1.12.2.jar || true

# Plugins
RUN cd /usr/local/spigot/plugins/ &&\
    curl -fLO https://github.com/EssentialsX/Essentials/releases/download/2.15.0/EssentialsX-2.15.0.1.jar &&\
    curl -fLO https://github.com/EssentialsX/Essentials/releases/download/2.15.0/EssentialsXSpawn-2.15.0.1.jar &&\
    curl -fL -o PermissionsEx-1.23.4.jar        https://dev.bukkit.org/projects/permissionsex/files/909154/download &&\
    curl -fL -o worldedit-bukkit-6.1.9.jar      https://dev.bukkit.org/projects/worldedit/files/2597538/download &&\
    curl -fL -o worldguard-bukkit-6.2.2.jar     https://dev.bukkit.org/projects/worldguard/files/2610618/download &&\
    curl -fL -o GriefPrevention-16.7.1.jar      https://dev.bukkit.org/projects/grief-prevention/files/2436066/download &&\
    curl -fL -o armorstandeditor-1.11.2-19.jar  https://dev.bukkit.org/projects/armor-stand-edit/files/2403956/download &&\
    curl -fL -o MircoJump-1.0.4.jar		https://dev.bukkit.org/projects/microjump/files/866602/download


COPY plugins/ /usr/local/spigot/plugins/
COPY server.properties /usr/local/spigot/
COPY spigot.yml /usr/local/spigot/
COPY my.cnf /root/

COPY bin/ /usr/local/spigot/bin/
RUN chmod +x /usr/local/spigot/bin/*

COPY entrypoint.sh /usr/local/spigot/bin/
RUN chmod +x /usr/local/spigot/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/spigot/bin/entrypoint.sh"]

HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
    CMD mcstatus localhost ping || exit 1

RUN mkdir /usr/local/spigot/data
WORKDIR /usr/local/spigot/data
CMD ["-jar", "/usr/local/spigot/spigot-1.12.2.jar"]
VOLUME /usr/local/spigot/data/
EXPOSE 25565
