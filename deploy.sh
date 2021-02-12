docker build -t tranantho/multi-client:latest -t tranantho/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tranantho/multi-server:latest -t tranantho/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t tranantho/multi-worker:latest -t tranantho/multi-worker:$SHA -f ./worker/Dockerfile ./worker 

docker push tranantho/multi-client:latest
docker push tranantho/multi-server:latest
docker push tranantho/multi-worker:latest


docker push tranantho/multi-client:$SHA
docker push tranantho/multi-server:$SHA
docker push tranantho/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tranantho/multi-server:$SHA
kubectl set image deployments/client-deployment client=tranantho/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tranantho/multi-worker:$SHA
