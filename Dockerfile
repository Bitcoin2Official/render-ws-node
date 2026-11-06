# Stage 1: fetch the official Xray release binary
FROM alpine:3.20 AS fetch
RUN apk add --no-cache curl unzip ca-certificates
WORKDIR /tmp/dl
RUN curl -fsSL -o release.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && unzip -o release.zip && chmod +x xray

# Stage 2: minimal runtime image
FROM alpine:3.20
RUN apk add --no-cache ca-certificates
COPY --from=fetch /tmp/dl/xray /usr/local/bin/xray
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
