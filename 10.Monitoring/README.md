# Configuring Minikube Kubernetes cluster monitoring via Prometheus+Grafana


##### 1. Install Prometheus+Grafana via Helm chart
###### Helm chart source: https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack

![Install Grafana.png](1%2FInstall%20Grafana.png)
![Install Prometheus.png](1%2FInstall%20Prometheus.png)
##### 2. Create Dashboard with some metrics
![Dashboard.png](2%2FDashboard.png)
##### 3. Pass Prometheus Alertmanager Alerts to Grafana
![Pass alerts (by importance).png](3%2FPass%20alerts%20%28by%20importance%29.png)
![Alerts on dashboard.png](3%2FAlerts%20on%20dashboard.png)
##### 4. Discover metrics change on Dashboard
![Decrease and Increate Number of Pods.png](4%2FDecrease%20and%20Increate%20Number%20of%20Pods.png)
![Decrease and Increase shown on graph.png](4%2FDecrease%20and%20Increase%20shown%20on%20graph.png)
