FROM ubuntu:bionic

ARG LIBTORRENT_RASTERBAR_VERSION=1.1.13
ARG DELUGE_VERSION=1.3.15

WORKDIR BUILD

RUN apt-get update && \
	apt-get -y install wget supervisor \
	build-essential checkinstall libboost-system-dev libboost-python-dev libboost-chrono-dev libboost-random-dev libssl-dev automake libtool && \
	wget https://github.com/arvidn/libtorrent/releases/download/libtorrent-$(echo "$LIBTORRENT_RASTERBAR_VERSION" | sed "s/\./_/g")/libtorrent-rasterbar-$LIBTORRENT_RASTERBAR_VERSION.tar.gz && \
	tar xvf libtorrent-rasterbar-$LIBTORRENT_RASTERBAR_VERSION.tar.gz && \
	/BUILD/libtorrent-rasterbar-$LIBTORRENT_RASTERBAR_VERSION/configure --disable-debug --enable-python-binding --with-libiconv && \
	make -j$(nproc) && \
	make install && \
	ldconfig && \
	apt-get install -y python python-twisted python-openssl python-setuptools intltool python-xdg python-chardet geoip-database python-notify python-pygame python-glade2 librsvg2-common xdg-utils python-mako && \
	wget http://download.deluge-torrent.org/source/deluge-$DELUGE_VERSION.tar.xz && \
	tar xvf deluge-$DELUGE_VERSION.tar.xz && cd /BUILD/deluge-$DELUGE_VERSION &&\
	python setup.py build && \
	python setup.py install --install-layout=deb && \
	rm -rf /var/lib/apt/lists/* && \
	cd / && rm -rf /BUILD/

VOLUME /root/.config/deluge /home/Downloads/deluge /home/Downloads/deluge/watch

COPY core.conf /root/.config/deluge/core.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8112 58846
EXPOSE 45656/tcp 45656/udp 45657/tcp 45657/udp

CMD ["/usr/bin/supervisord"]
