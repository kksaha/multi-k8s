docker build -t kksaha007/multi-client:latest -t kksaha007/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kksaha007/multi-server:latest -t kksaha007/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kksaha007/multi-worker:latest -t kksaha007/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kksaha007/multi-client:latest
docker push kksaha007/multi-server:latest
docker push kksaha007/multi-worker:latest

docker push kksaha007/multi-client:$SHA
docker push kksaha007/multi-server:$SHA
docker push kksaha007/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kksaha007/multi-server:$SHA
kubectl set image deployments/client-deployment client=kksaha007/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kksaha007/multi-worker:$SHA
