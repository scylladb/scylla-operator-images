FROM docker.io/library/golang:1.26 AS builder

RUN go install sigs.k8s.io/prow/cmd/mkpj@latest

RUN curl -fsSL -o /usr/local/bin/kubectl \
      "https://dl.k8s.io/release/v1.33.0/bin/linux/amd64/kubectl" && \
    chmod +x /usr/local/bin/kubectl

FROM quay.io/scylladb/scylla-operator-images:base-ubi-9.7-minimal

COPY --from=builder /go/bin/mkpj /usr/local/bin/mkpj
COPY --from=builder /usr/local/bin/kubectl /usr/local/bin/kubectl

COPY config.yaml /etc/prow/config.yaml
COPY job.yaml /etc/prow/job.yaml
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
