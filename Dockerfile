FROM arm64v8/ubuntu:16.04
MAINTAINER Yen3 <yen3@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

RUN apt-get update \
    && apt-get install -y --force-yes --no-install-recommends supervisor \
        openssh-server pwgen sudo vim-tiny \
        net-tools \
        lxde x11vnc xvfb \
        gtk2-engines-murrine ttf-ubuntu-font-family \
        libreoffice firefox \
        fonts-wqy-microhei \
        language-pack-zh-hant language-pack-gnome-zh-hant firefox-locale-zh-hant libreoffice-l10n-zh-tw \
        nginx \
        python-pip python-dev build-essential \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

#ADD https://dl.dropboxusercontent.com/u/23905041/x11vnc_0.9.14-1.1ubuntu1_armhf.deb /tmp/
#ADD https://dl.dropboxusercontent.com/u/23905041/x11vnc-data_0.9.14-1.1ubuntu1_all.deb /tmp/
#RUN dpkg -i /tmp/x11vnc*.deb

ADD web /web/
RUN pip install -r /web/requirements.txt

ADD noVNC /noVNC/
ADD nginx.conf /etc/nginx/sites-enabled/default
ADD startup.sh /
ADD supervisord.conf /etc/supervisor/conf.d/
ADD doro-lxde-wallpapers /usr/share/doro-lxde-wallpapers/

EXPOSE 6080
WORKDIR /root
ENTRYPOINT ["/startup.sh"]
