# blog - https://piotrminkowski.com/2021/12/30/vault-on-kubernetes-with-spring-cloud/
kubectl create ns vault
helm install vault hashicorp/vault --set "server.dev.enabled=true" -n vault
kubectl exec -it vault-0 -n vault -- /bin/sh
#port-forward 8200
#mysql pod shell run the following:
#mysql -u root
#alter user root identified by 'abcd';
#update mysql.user set authentication_string=password('abcd') where user='root';
#flush privileges;
#select user from mysql.user;
vault auth enable kubernetes
vault write auth/kubernetes/config kubernetes_host=https://${KUBERNETES_PORT_443_TCP_ADDR}:443 token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt issuer="https://kubernetes.default.svc.cluster.local"
vault policy write internal-app - <<EOF
path "database/creds/default" {
capabilities = ["read"]
}
EOF
vault write auth/kubernetes/role/internal-app bound_service_account_names=internal-app bound_service_account_namespaces=default policies=internal-app ttl=24h
vault secrets enable database
# vault write database/config/mysql plugin_name=mysql-database-plugin allowed_roles="*" connection_url="{{username}}:{{password}}@tcp(mysql.default:3306)/cities" username="shipping" password="secret"
vault write database/config/mysql plugin_name=mysql-database-plugin allowed_roles="*" connection_url="{{username}}:{{password}}@tcp(mysql.default:3306)/" username="root" password="abcd"
vault write database/roles/default db_name=mysql creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT ALL ON *.* TO '{{name}}'@'%';" default_ttl="1h" max_ttl="24h"
vault read database/creds/default
exit

#& "C:\Users\rdargahwala\robot-shop\vault.ps1