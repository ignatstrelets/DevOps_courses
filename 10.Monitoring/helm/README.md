# Report on adding custom Grafana dashboard to kube-prometheus-stack helm chart


##### Export existing Grafana Dashboard as JSON

[custom-template.json](custom-template.json)

##### Clone git repo
```     git clone https://github.com/prometheus-community/helm-charts.git ```

##### We will customize 'kube-prometheus-stack' chart

##### Add custom ConfigMap to 'kube-prometheus-stack/templates/grafana/dashboards-1.14/'

[custom-k8s.yaml](custom-k8s.yaml)

##### Add dependencies, build dependencies, render template

```
    helm repo add prometheus-community https://prometheus-community.github.io/Helm-charts
    helm repo add grafana https://grafana.github.io/Helm-charts
    helm dependency build
    helm repo update
    cd ~/helm-charts/charts/kube-prometheus-stack
    helm template kube-prometheus-stack . --validate > rendered-template.yaml
```
[rendered-template.yaml](rendered-template.yaml)

##### Deploy custom Helm Chart
```
    helm install kube-prometheus-stack .
```

##### Test
```
    kubectl get svc
    <...>
    kubectl port-forward deployment/kube-prometheus-stack-grafana 3000
```
![custom-k8s.png](custom-k8s.png)
