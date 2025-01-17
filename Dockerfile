FROM golang:1.19-buster as builder
WORKDIR /src/github.com/devinotelecom/prometheus-vmware-exporter
COPY ./ /src/github.com/devinotelecom/prometheus-vmware-exporter
RUN go get -d -v
RUN go build

FROM debian:buster-slim
COPY --from=builder /src/github.com/devinotelecom/prometheus-vmware-exporter/prometheus-vmware-exporter /usr/bin/prometheus-vmware-exporter
EXPOSE 9512
ENTRYPOINT ["prometheus-vmware-exporter"]
