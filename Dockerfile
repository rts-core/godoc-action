FROM golang:1.18-buster

ENV GOPATH /
RUN go get golang.org/x/tools/cmd/godoc
COPY ./script.sh /bin/script.sh

CMD ["/bin/script.sh"]