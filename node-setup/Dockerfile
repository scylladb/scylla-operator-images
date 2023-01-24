FROM to-be-replaced-by-local-ref/base:ubuntu

RUN apt-get update && \
    apt-get install -y --no-install-recommends xfsprogs mdadm && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*
