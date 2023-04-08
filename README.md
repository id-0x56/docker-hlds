# Docker
```
sudo apt update \
    && sudo apt install -y curl \
    && curl -fsSL https://get.docker.com -o get-docker.sh \
    && sudo sh ./get-docker.sh
```
# HLDS
```
sudo apt update \
    && sudo apt install -y git curl unzip
```
```
git clone git@github.com:id-0x56/docker-hlds.git \
    && cd docker-hlds
```
```
curl -L https://github.com/id-0x56/hlds/releases/download/6153/hlds_linux_6153.zip -o $(pwd)/bin/hlds_linux_6153.zip
```
```
unzip $(pwd)/bin/hlds_linux_6153.zip -d $(pwd)/bin/hlds_l \
    && cp -r $(pwd)/conf/cstrike $(pwd)/conf/valve $(pwd)/bin/hlds_l
```
```
docker run --rm --interactive --tty --volume $(pwd)/bin/hlds_l:/hlds_l --workdir /hlds_l -p 27015:27015/tcp -p 27015:27015/udp 00x56/docker-hlds /bin/bash
```
## Counter-Strike
```
chmod +x /hlds_l/hlds_* \
    && mkdir -p $HOME/.steam/sdk32 \
    && ln -snf /hlds_l/steamclient.so $HOME/.steam/sdk32/steamclient.so \
    && /hlds_l/hlds_run -game cstrike -nomaster -insecure -pingboost 1 +map de_dust2 +maxplayers 12 +rcon_password password
```
## Half-Life Deathmatch
```
chmod +x /hlds_l/hlds_* \
    && mkdir -p $HOME/.steam/sdk32 \
    && ln -snf /hlds_l/steamclient.so $HOME/.steam/sdk32/steamclient.so \
    && /hlds_l/hlds_run -game valve -nomaster -insecure -pingboost 1 +map crossfire +maxplayers 12 +rcon_password password
```
