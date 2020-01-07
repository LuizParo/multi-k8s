docker build -t luizparo/multi-client:latest -t luizparo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t luizparo/multi-server:latest -t luizparo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t luizparo/multi-worker:latest -t luizparo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push luizparo/multi-client:latest
docker push luizparo/multi-server:latest
docker push luizparo/multi-worker:latest
docker push luizparo/multi-client:$SHA
docker push luizparo/multi-server:$SHA
docker push luizparo/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image image deployments/server-deployment server=luizparo/multi-server:$SHA
kubectl set image image deployments/client-deployment client=luizparo/multi-client:$SHA
kubectl set image image deployments/worker-deployment worker=luizparo/multi-worker:$SHA