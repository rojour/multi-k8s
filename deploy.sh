docker build -t rojour/multi-client:latest -t rojour/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rojour/multi-server:latest -t rojour/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rojour/multi-worker:latest -t rojour/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rojour/multi-client:latest
docker push rojour/multi-client:$SHA

docker push rojour/multi-server:latest
docker push rojour/multi-server:$SHA

docker push rojour/multi-worker:latest
docker push rojour/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rojour/multi-server:$SHA
kubectl set image deployments/client-deployment client=rojour/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rojour/multi-worker:$SHA
