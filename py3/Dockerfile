FROM consol/ubuntu-xfce-vnc

USER root
ENV HOME=/headless
RUN apt-get update -q && \
    apt-get remove -y chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg --purge && \
    apt-get install -y --allow-unauthenticated --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        software-properties-common \
        python3-software-properties \
        iputils-ping \
        vim \
        pv \
        wget \
        less \
        git \
        sudo \
        libfontconfig \
        gnupg2 \
        curl && \
    (cd /tmp; curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg) && \
    mv /tmp/microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list && \
    add-apt-repository ppa:jonathonf/python-3.6 && \
    apt-get update -q && \
    DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true && \
    apt-get install -y --allow-unauthenticated --no-install-recommends \
        build-essential \
        libsystemd-dev \
        libssl-dev \
        libffi-dev \
        python3.6 \
        python3.6-dev \
        python3-distutils-extra \
        python3.6-venv \
        libpq-dev \
        xvfb \
        code \
        unzip && \
    apt-get -y dist-upgrade && \
    apt-get -y autoremove && \
    apt-get remove -y python3-apt && \
    apt-get install -y python3-apt && \
    apt-get -y clean && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 2 && \
    (curl https://bootstrap.pypa.io/get-pip.py | python3) && \
    pip3 install --upgrade setuptools wheel && \
    pip3 install invoke virtualenv requests j2cli[yaml] && \
    mkdir -p /headless/venv && \
    virtualenv -p python3 /headless/venv && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /headless/.config/Code/User

ADD docker/vscode/vscode-config-ext.tgz /headless/
ADD docker/vscode/vscode-config.tgz /headless/.config/

COPY docker/vscode/settings.json /headless/.config/Code/User/
COPY docker/vnc_startup.sh /dockerstartup/
COPY docker/startup.sh /dockerstartup/
COPY requirements.txt /requirements.txt
RUN /headless/venv/bin/pip install -r /requirements.txt && \
    rm -rf /headless/.cache /headless/.pki /headless/Desktop/* && \
    addgroup --gid 1000 teamflash && \
    adduser --disabled-password --gecos "" --uid 1000 --gid 1000 teamflash && \
    usermod -aG sudo teamflash && \
    echo "teamflash ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    chown -R teamflash:teamflash /headless && \
    chmod +x /dockerstartup/vnc_startup.sh && \
    chmod +x /dockerstartup/startup.sh
