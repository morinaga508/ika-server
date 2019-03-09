# Build

```
ln -s docker-compose.prod.yml docker-compose.yml
docker-compose build
```

# Configure

Please create `.env` file.

# Install

```
cp host/minecraft.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable minecraft
```

# Start minecraft server


```
systemctl start minecraft
```

# Get dependency plugins

Download from
- https://www.spigotmc.org/resources/plugin-library.17645/
- https://www.spigotmc.org/resources/statz.25969/
- https://www.spigotmc.org/resources/bossshoppro-the-most-powerful-chest-gui-shop-menu-plugin.25699/
- https://www.spigotmc.org/resources/playershops-gui-bsp-allow-players-to-create-public-shops.29568/
- https://www.spigotmc.org/resources/worldguard-extra-flags.4823/
- https://www.spigotmc.org/resources/televator.4098/
- https://www.spigotmc.org/resources/redstone-clock-preventer.1054/
- https://www.spigotmc.org/resources/better-chairs.18705/
- https://www.spigotmc.org/resources/cratesplus-free-crates-plugin-1-7-1-13-1.5018/
- https://www.spigotmc.org/resources/lockettepro-uuid-support.20427/
- https://www.spigotmc.org/resources/protocollib.1997/
- https://www.spigotmc.org/resources/aac-advanced-anti-cheat-hack-kill-aura-blocker.6442/
- https://www.spigotmc.org/resources/skquery-1-9-1-13.36631/

```
mv ~/PluginLibrary-1.2.1.jar volumes/main/plugins/
mv ~/Statz-1.5.3.jar volumes/main/plugins/
mv ~/BossShopPro-1.9.8.jar volumes/main/plugins/
mv ~/BSP-PlayerShops-1.2.2.jar volumes/main/plugins/
mv ~/WorldGuardExtraFlagsPlugin-3.0.4.jar volumes/main/plugins/
mv ~/Televator-1.4.jar volumes/main/plugins/
mv ~/RedstoneClockPreventer-1.3.1.jar volumes/main/plugins/
mv ~/BetterChairs-0.9.5.jar volumes/main/plugins/
cp volumes/main/plugins/ BetterChairs-0.9.5.jar volumes/hub/plugins/
mv ~/CratesPlus-4.5.1.jar volumes/main/plugins/
mv ~/LockettePro-2.9.0.jar volumes/main/plugins/
mv ~/ProtocolLib.jar volumes/main/plugins/
mv ~/AAC.jar volumes/main/plugins/
```

