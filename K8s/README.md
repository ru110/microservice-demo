
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
