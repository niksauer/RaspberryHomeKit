FROM raspbian/stretch
RUN echo "deb http://apt.pilight.org/ stable main" > /etc/apt/sources.list.d/pilight.list \
	&& wget -O - http://apt.pilight.org/pilight.key | apt-key add - \
	&& apt-get update && apt-get install -y \
	build-essential cmake git dialog \
	libwiringx libwiringx-dev libpcap0.8-dev libmbedtls-dev liblua5.2-dev libluajit-5.1-dev \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*
RUN git clone --depth 5 https://github.com/niksauer/pilight.git && cd pilight && chmod +x setup.sh && ./setup.sh install && ldconfig \
	&& openssl req -x509 -newkey rsa:4096 -sha256 -nodes -keyout pilight.key -out pilight.crt -subj "/CN=pilight.org" -days 3650 \
	&& cat pilight.key pilight.crt > /etc/pilight/pilight.pem
CMD ["/usr/local/sbin/pilight-daemon", "-F"]
