FROM node:10.13.0-slim

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN apt-get -y update && \
	apt-get -y install git python make gcc g++ apt-transport-https bzip2 && \
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
	apt-get -y update && \
	apt-get -y install yarn
RUN git clone https://github.com/nr23730/matrix-puppet-signal.git
RUN cd /matrix-puppet-signal && \
	npm remove --save signal-desktop && \ # we install this manually to prevent duplicate dependencies
    npm --unsafe-perm install && \
    cd node_modules && \
    git clone https://github.com/nr23730/signal-desktop.git && \
    cd signal-desktop && \
    yarn && \
    yarn grunt

RUN mkdir /conf /data && \
    ln -s /conf/config.json /matrix-puppet-signal/config.json && \
    ln -s /conf/signal-registration.yaml /matrix-puppet-signal/signal-registration.yaml && \
    ln -s /data/D_signal.sqlite /matrix-puppet-signal/D_signal.sqlite && \
    ln -s /data/__sysdb__.sqlite /matrix-puppet-signal/__sysdb__.sqlite && \
    ln -s /data /matrix-puppet-signal/data

ADD entry.sh /

ENTRYPOINT ["/bin/sh", "/entry.sh"]
