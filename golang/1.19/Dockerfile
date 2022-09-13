FROM to-be-replaced-by-local-ref/base:ubuntu

ENV GOPATH=/go \
    GOROOT=/usr/local/go
ENV PATH=${PATH}:${GOROOT}/bin:${GOPATH}/bin

COPY ./download-file.sh /tmp/

RUN apt-get update && \
    apt-get install -y --no-install-recommends git make tar gzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    /tmp/download-file.sh https://go.dev/dl/go1.19.1.linux-amd64.tar.gz 'a69153393a2eaf1c2b77f5a4bafe6a2fb36368c6856d79bd697472af71d925fc62c58e6b8fe75adf143b0462da2ed9e68d0fcd0328cde091be70d745b92814aa' | tar -C /usr/local -xzf - && \
    rm -rf /tmp/
