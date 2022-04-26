kubectl apply -f pipeline-resource.yaml
kubectl apply -f svcacc.yaml
kubectl apply -f task-git-source.yaml
kubectl apply -f task-build-docker-image-from-git-source.yaml
kubectl apply -f pipeline.yaml
kubectl apply -f pipelinerun.yaml
kubectl apply -f triggerbind.yaml
