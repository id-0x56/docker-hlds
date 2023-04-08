FROM debian:bullseye

ARG USERNAME=hlds
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt update \
    && apt install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

RUN apt update \
    && apt install -y locales \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen

ENV LC_ALL en_US.UTF-8 
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  

RUN apt update \
    && apt install -y ca-certificates lib32gcc-s1

USER $USERNAME



# docker builder prune -af \
#     && docker system prune -af \
#     && docker volume prune -f \
#     && docker image prune -af

# docker login
# docker build --no-cache -t 00x56/docker-hlds:latest .
# docker push 00x56/docker-hlds:latest

# docker run --rm --interactive --tty --volume $(pwd)/bin/hlds_l:/hlds_l --workdir /hlds_l -p 27015:27015/tcp -p 27015:27015/udp 00x56/docker-hlds /bin/bash
# docker exec -it 7809913082a3 /bin/bash
