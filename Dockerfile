FROM alpine:3.9.4
LABEL maintainer="chris.ramirezg@gmail.com"

RUN apk --update --no-cache add iptables

COPY ./entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]
