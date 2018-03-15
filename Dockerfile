FROM alpine:latest
RUN apk add --no-cache file
COPY ./dvm.sh /bin/dvm.sh
ENTRYPOINT [ "/bin/dvm.sh" ]
