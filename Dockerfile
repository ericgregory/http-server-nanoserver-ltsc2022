FROM golang:1.20-nanoserver-ltsc2022 as gobuild

COPY . /app
WORKDIR /app

RUN go mod download
RUN go vet -v
RUN go test -v

ENV CGO_ENABLED=0
ENV GOOS=windows
ENV GOARCH=amd64 

RUN go build main.go

FROM mcr.microsoft.com/windows/nanoserver:ltsc2022

COPY --from=gobuild /app/main.exe /main.exe

EXPOSE 80
CMD ["\\main.exe"]







