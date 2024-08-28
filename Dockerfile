# Build together with following sourves as context:
# https://www.reddit.com/r/CoreKeeperGame/comments/1990auo/comment/kibbza3/
# https://core-keeper.fandom.com/wiki/Dedicated_server

# Recommended base image from Valve https://developer.valvesoftware.com/wiki/SteamCMD#Docker
FROM cm2network/steamcmd:root-bookworm

# Need to install xvfb, libxi6
RUN apt update \
    && apt install -y xvfb libxi6 \
    # Clean up
    && apt-get clean

# Switch to steam user expected by script from base image
USER steam

RUN ./steamcmd.sh \
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

CMD /home/steam/Steam/steamapps/common/Core\ Keeper\ Dedicated\ Server/_launch.sh