# Build together with following sourves as context:
# https://www.reddit.com/r/CoreKeeperGame/comments/1990auo/comment/kibbza3/
# https://core-keeper.fandom.com/wiki/Dedicated_server


# Recommended base image from Valve https://developer.valvesoftware.com/wiki/SteamCMD#Docker
FROM cm2network/steamcmd:steam-bookworm
RUN ./steamcmd.sh \
    +force_install_dir /home/corekeeper-server \
    +login anonymous \
    # Install Steam SDK https://steamdb.info/app/1007/
    +app_update 1007 validate \
    # Install core keeper server https://steamdb.info/app/1963720/
    +app_update 1963720 validate \
    +quit

# Core keeper server listens on these ports
# Don't forget to expose them using docker or in your docker compose file
EXPOSE 27015/udp
EXPOSE 27016/udp

CMD /home/corekeeper-server/_launch.sh