docker build -t raghukumarm/multi-client:latest -t raghukumarm/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t raghukumarm/multi-server:latest -t raghukumarm/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t raghukumarm/multi-worker:latest -t raghukumarm/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push  raghukumarm/multi-client:latest
docker push  raghukumarm/multi-server:latest
docker push  raghukumarm/multi-worker:latest

docker push  raghukumarm/multi-client:$SHA
docker push  raghukumarm/multi-server:$SHA
docker push  raghukumarm/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=raghukumarm/multi-client:$SHA
kubectl set image deployments/server-deployment server=raghukumarm/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=raghukumarm/multi-worker:$SHA