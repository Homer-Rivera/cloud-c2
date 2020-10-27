FROM alpine AS builder

# Install unzip and curl
RUN apk add -U unzip curl

# download software
RUN mkdir -p /app; \
    curl -L https://c2.hak5.org/download/community --output c2.zip; \
    unzip c2.zip -d /stage; \
    find /stage -type f -name '*amd64_linux*' -print -exec cp {} /app \;


FROM ubuntu:bionic

WORKDIR /app
COPY --from=builder /app .

ENTRYPOINT ["/app/c2-3.0.0_amd64_linux", "--hostname", "c2.example.com"]

EXPOSE 2022 8080
