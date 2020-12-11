docker build -t lilmakijr/multi-client-k8s:latest -t lilmakijr/multi-client-k8s:"$SHA" ./client
docker build -t lilmakijr/multi-server-k8s:latest -t lilmakijr/multi-server-k8s:"$SHA" ./server
docker build -t lilmakijr/multi-worker-k8s:latest -t lilmakijr/multi-worker-k8s:"$SHA" ./worker
#Push images to docker-hub
docker push lilmakijr/multi-client-k8s:"$SHA"
docker push lilmakijr/multi-client-k8s:latest

docker push lilmakijr/multi-server-k8s:"$SHA"
docker push lilmakijr/multi-server-k8s:latest

docker push lilmakijr/multi-worker-k8s:"$SHA"
docker push lilmakijr/multi-worker-k8s:latest
#run kubernetes config
kubectl apply --recursive -f .

#force set images in kubernetes
kubectl set image deployments/server-deployment server=lilmakijr/multi-server-k8s:"$SHA"
kubectl set image deployments/client-deployment client=lilmakijr/multi-client-k8s:"$SHA"
kubectl set image deployments/worker-deployment worker=lilmakijr/multi-worker-k8s:"$SHA"
