FROM to-be-replaced-by-local-ref/base:ubuntu

RUN echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends wireguard iproute2 resolvconf && \
    apt-get clean && \
    ln -s /usr/bin/resolvectl /usr/local/bin/resolvconf
