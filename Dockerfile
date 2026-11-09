# syntax=docker/dockerfile:1
# Stage 1: official Xray image (it has no shell) - used only to copy the binary.
# The binary in ghcr.io/xtls/xray-core is at /usr/local/bin/xray.
FROM ghcr.io/xtls/xray-core:latest AS xray
# Stage 2: Alpine provides a shell, so Cloady can run the entrypoint.
FROM alpine:3.21
RUN apk add --no-cache ca-certificates tzdata
COPY --from=xray /usr/local/bin/xray /usr/local/bin/xray
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
EXPOSE 3000
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]












