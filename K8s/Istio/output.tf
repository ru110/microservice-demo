resource "kubernetes_manifest" "deployment_payment_fix" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "service" = "payment"
        "stage" = "test"
      }
      "name" = "payment-fix"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "service" = "payment"
          "stage" = "test"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "service" = "payment"
            "stage" = "test"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "INSTANA_AGENT_HOST"
                  "valueFrom" = {
                    "fieldRef" = {
                      "fieldPath" = "status.hostIP"
                    }
                  }
                },
              ]
              "image" = "robotshop/rs-payment-fix:latest"
              "name" = "payment-fix"
              "ports" = [
                {
                  "containerPort" = 8080
                },
              ]
              "resources" = {
                "limits" = {
                  "cpu" = "200m"
                  "memory" = "100Mi"
                }
                "requests" = {
                  "cpu" = "100m"
                  "memory" = "50Mi"
                }
              }
            },
          ]
          "restartPolicy" = "Always"
        }
      }
    }
  }
}
