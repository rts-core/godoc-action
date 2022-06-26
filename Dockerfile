FROM golang:1.18-buster

ENV GOPATH /
RUN go install golang.org/x/tools/cmd/godoc@latest
COPY ./script.sh /bin/script.sh
RUN chmod +x /bin/script.sh

ENTRYPOINT ["/bin/script.sh"]