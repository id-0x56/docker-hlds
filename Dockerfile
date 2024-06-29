FROM debian:bullseye

ARG USERNAME=hlds
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

ENV TZ=Europe/London
RUN apt update \
    && apt install --no-install-recommends -y tzdata \
    && rm -rf /var/lib/apt/lists/* \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

RUN apt update \
    && apt install --no-install-recommends -y sudo \
    && rm -rf /var/lib/apt/lists/* \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

RUN apt update \
    && apt install --no-install-recommends -y locales \
    && rm -rf /var/lib/apt/lists/* \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

RUN apt update \
    && apt install -y ca-certificates lib32gcc-s1 \
    && rm -rf /var/lib/apt/lists/*

USER $USERNAME



# docker builder prune -af \
#     && docker system prune -af \
#     && docker volume prune -f \
#     && docker image prune -af

# docker login
# docker build --no-cache -t 00x56/docker-hlds:latest .
# docker push 00x56/docker-hlds:latest

# docker run --rm --interactive --tty --volume $(pwd)/bin/hlds_l:/hlds_l --workdir /hlds_l --publish 27015:27015/tcp --publish 27015:27015/udp 00x56/docker-hlds /bin/bash
# docker exec --interactive --tty 7809913082a3 /bin/bash

# docker run --interactive --tty --volume $(pwd)/bin/hlds_l:/hlds_l --workdir /hlds_l --publish 27015:27015/tcp --publish 27015:27015/udp --detach --restart unless-stopped 00x56/docker-hlds /bin/sh -c 'chmod +x /hlds_l/hlds_* && mkdir -p $HOME/.steam/sdk32 && ln -snf /hlds_l/steamclient.so $HOME/.steam/sdk32/steamclient.so && /hlds_l/hlds_run -game cstrike -nomaster -insecure -pingboost 1 +map de_dust2 +maxplayers 12 +rcon_password password'
# docker run --interactive --tty --volume $(pwd)/bin/hlds_l:/hlds_l --workdir /hlds_l --publish 27020:27015/tcp --publish 27020:27015/udp --detach --restart unless-stopped 00x56/docker-hlds /bin/sh -c 'chmod +x /hlds_l/hlds_* && mkdir -p $HOME/.steam/sdk32 && ln -snf /hlds_l/steamclient.so $HOME/.steam/sdk32/steamclient.so && /hlds_l/hlds_run -game valve -nomaster -insecure -pingboost 1 +map crossfire +maxplayers 12 +rcon_password password'
# docker container restart $(docker ps --quiet --filter ancestor=00x56/docker-hlds)
