#build stage
FROM golang:alpine AS builder
# RUN apk add --no-cache git
WORKDIR /go/src/app
COPY . .
RUN go build -o /go/bin/app -v .

#final stage
FROM alpine:latest
RUN apk add --no-cache bash
# RUN apk --no-cache add ca-certificates
COPY --from=builder /go/bin/app ./server
CMD ["./server"]
EXPOSE 8080
LABEL Name=asciiartweb Version=1.0.0
LABEL creators="natkim, healingdrawing.github.io, cenk-idris"
LABEL description="The ascii-art-web application. Dockerized version"
LABEL license="https://opensource.org/licenses/GPL-3.0"
