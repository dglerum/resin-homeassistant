ARG BUILD_FROM
FROM resin/rpi-raspbian

ARG BUILD_ARCH
ARG BUILD_VERSION

LABEL maintainer "Philipp Schmitt <philipp@schmitt.co>"

RUN apt-get update && \
    apt-get install -y git && \
    git clone https://github.com/50ButtonsEach/fliclib-linux-hci /tmp/src && \
    cp /tmp/src/bin/armv6l/flicd /usr/bin/flicd && \
    chmod +x /usr/bin/flicd && \
    mkdir /config && \
    rm -rf /tmp/src && \
    apt-get remove --purge -y git && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /data
ENTRYPOINT ["/usr/bin/flicd"]
CMD ["-f", "/data/flic-db", "-s", "0.0.0.0", "-p", "5551"]
