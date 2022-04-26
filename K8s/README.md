
# Stan's Robot Shop Install

Install Stan's Robot Shop on to your K8s cluster using the helm chart

```shell
$ cd helm-templates
$ helm install --name robot-shop --namespace robot-shop .
```


## Istio

Stan's Robot Shop will run on Kubernetes with Istio service mesh. Configure Istio ingress.

```shell
$ kubectl -n robot-shop apply -f Istio/gateway.yaml
```

Now use the exposed Istio gateway to access Robot Shop.

```shell
$ kubectl -n istio-system get svc istio-ingressgateway
```

The above will display the IP address of the Istio gateway.

## Prometheus integration with Wavefront (Tanzu Observability)

The cart and payment services both have Prometheus metric endpoints. These are accessible on /metrics. The cart service provides:

* Counter of the number of items added to the cart
The payment services provides:

* Counter of the number of items purchased
* Histogram of the total number of items in each cart
* Histogram of the total value of each cart
To test the metrics use:

```shell
$ curl http://<host>:8080/api/cart/metrics
$ curl http://<host>:8080/api/payment/metrics
```

To access these metrics on Tanzu observability dashboard, telegraf sidecar is added to cart and payment deployments.
Execute telegraf-prometheus-config.yaml file to access above mentioned metric endpoints via pod deployments.

```shell
$ cd configmaps
$ kubectl apply -f telegraf-prometheus-config.yaml
```

