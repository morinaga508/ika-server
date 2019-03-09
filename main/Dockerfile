FROM mc1.12-hub:latest

# Plugins
RUN cd /usr/local/spigot/plugins/ &&\
    rm -rf `ls . | grep -v .jar` &&\
    curl -fLO https://popicraft.net/jenkins/job/mcMMO/21/artifact/mcMMO/target/mcMMO.jar &&\
    curl -fLO https://github.com/SkriptLang/Skript/releases/download/2.3.5/Skript.jar &&\
    curl -fL -o PetBlocks-Bukkit-7.2.2.jar	https://github.com/Shynixn/PetBlocks/releases/download/7.2.2/PetBlocks-Bukkit.jar &&\
    curl -fL -o Dynmap-GriefPrevention-0.80.jar	https://dev.bukkit.org/projects/dynmap-griefprevention/files/854600/download &&\
    curl -fL -o Multiverse-Core-2.5.0.jar	https://dev.bukkit.org/projects/multiverse-core/files/2428161/download &&\
    curl -fL -o Dynmap-v2.6-beta-1.jar		https://dev.bukkit.org/projects/dynmap/files/2580906/download &&\
    curl -fL -o MyCommand-5.3.4.jar		https://dev.bukkit.org/projects/mycommand/files/921965/download &&\
#    curl -fL -o CraftBook-3.9u22.jar		https://dev.bukkit.org/projects/craftbook/files/2541895/download &&\
    curl -fL -o CoreProtect-2.14.4.jar		https://dev.bukkit.org/projects/coreprotect/files/2591537/download &&\
#    curl -fL -o Lockette-1.8.33.jar		https://dev.bukkit.org/projects/lockette/files/920598/download &&\
#    curl -fL -o PermissionsEx-1.23.4.jar	https://dev.bukkit.org/projects/permissionsex/files/909154/download &&\
    curl -fL -o ClearLag-2.9.7.jar		https://dev.bukkit.org/projects/clearlagg/files/2442450/download &&\
    curl -fL -o WorldBorder-1.8.7.jar		https://dev.bukkit.org/projects/worldborder/files/2415838/download &&\
    curl -fL -o Autorank-4.2.3.jar		https://dev.bukkit.org/projects/autorank/files/2556405/download &&\
    curl -fL -o CustomEnderChest-v1.10.3.jar	https://dev.bukkit.org/projects/custom-enderchest/files/2648825/download &&\
    curl -fL -o PlugMan-2.1.5.jar		https://dev.bukkit.org/projects/plugman/files/2576183/download &&\
    curl -fL -o Announcer+.jar			https://dev.bukkit.org/projects/announcer-plus/files/2537041/download &&\
    curl -fL -o rewarddaily.jar			https://dev.bukkit.org/projects/rewards-daily-1-12-2-1/files/2604231/download &&\
    curl -fL -o Vault-1.5.6.jar			https://dev.bukkit.org/projects/vault/files/894359/download

RUN cd /usr/local/src &&\
    curl -fL -o LunaChat-2.8.9-dist.zip 'http://forum.minecraftuser.jp/download/file.php?id=70357' &&\
    unzip LunaChat-2.8.9-dist.zip &&\
    mv plugins/* /usr/local/spigot/plugins/

COPY plugins/ /usr/local/spigot/plugins/
COPY server.properties /usr/local/spigot/
COPY spigot.yml /usr/local/spigot/
COPY bukkit.yml /usr/local/spigot/
COPY aws /root/.aws

COPY bin/ /usr/local/spigot/bin/
COPY crontab /var/spool/cron/crontabs/root
RUN chmod +x /usr/local/spigot/bin/*
EXPOSE 8123
