FROM alpine AS builder
WORKDIR /tmp/pocketbase
RUN apk add curl &&\
    curl -Lo pocketbase.zip https://github.com/pocketbase/pocketbase/releases/download/v0.18.6/pocketbase_0.18.6_linux_amd64.zip &&\
    unzip pocketbase.zip

FROM scratch
COPY --from=builder /tmp/pocketbase/pocketbase /usr/local/bin/pocketbase
ENTRYPOINT ["/usr/local/bin/pocketbase", "--migrationsDir", "/migrations", "--publicDir", "/public", "--dir", "/data", "serve", "--http", "0.0.0.0:80"]
EXPOSE 80