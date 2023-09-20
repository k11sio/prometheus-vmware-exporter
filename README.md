# prometheus-vmware-exporter
Collect metrics ESXi Host

## Build
```sh 
docker build -t prometheus-vmware-exporter .
```

## Run
```sh
docker run -b \
  --restart=always \
  --name=prometheus-vmware-exporter \
  --env=ESX_HOST esx.domain.local \
  --env=ESX_USERNAME user \
  --env=ESX_PASSWORD password \
  --env=ESX_LOG debug \
  prometheus-vmware-exporter 
```

## k8s Example
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: prometheus-vmware-exporter
  labels:
    app: prometheus-vmware-exporter
spec:
  replicas: 1
  selector:
    matchLabels:
      app: prometheus-vmware-exporter
  template:
    metadata:
      labels:
        app: prometheus-vmware-exporter
    spec:
      containers:
      - name: prometheus-vmware-exporter
        image: ghcr.io/k11sio/prometheus-vmware-exporter:main
        ports:
        - containerPort: 9512
---
apiVersion: v1
kind: Service
metadata:
  name: prometheus-vmware-exporter-svc
spec:
  selector:
    app: prometheus-vmware-exporter
  ports:
    - protocol: TCP
      port: 80
      targetPort: 9512
```
