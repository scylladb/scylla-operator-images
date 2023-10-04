FROM to-be-replaced-by-local-ref/base:ubuntu

RUN apt update && \
    apt install -y --no-install-recommends xfsprogs mdadm && \
    apt clean  && \
    rm -rf /var/lib/apt/lists/*
