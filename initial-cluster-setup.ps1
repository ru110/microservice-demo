minikube start --memory=7000 --cpus=8 --vm-driver hyperv --hyperv-virtual-switch "Primary Virtual Switch"
kubectl cluster-info
kubectl create namespace wavefront
helm repo add wavefront https://wavefronthq.github.io/helm/
helm repo update
helm install wavefront wavefront/wavefront --set wavefront.url=https://longboard.wavefront.com --set wavefront.token=a37ac343-add9-4ba6-aa4d-b27180d8933a --set clusterName="minikube" --namespace wavefront
kubectl create namespace observability
kubectl create -f https://github.com/jaegertracing/jaeger-operator/releases/download/v1.30.0/jaeger-operator.yaml -n observability
kubectl create namespace robo-shop
#kubectl apply -f telegraf-prometheus-config.yaml -n robo-shop
#kubectl apply -f internal-sa.yaml
cd .\scripts\
kubectl apply -f wavefront-proxy.yaml
kubectl apply -f keycloak-setup.yaml
cd ..
cd .\K8s\
cd .\configmaps\
kubectl apply -f .
cd..
cd .\helm\
helm install robot-shop --set nodeport=true .