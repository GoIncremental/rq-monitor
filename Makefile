TAG=`cat version`
PREVRC=`kubectl get rc | grep -o -e 'rq-monitor-edge-v\d*.\d*.\d*'`

container:
	docker build -t goincremental/rq-monitor .

publish: container
	bumpversion patch --commit --tag
	docker tag -f goincremental/rq-monitor eu.gcr.io/gi-harbour/rq-monitor
	docker tag -f goincremental/rq-monitor eu.gcr.io/gi-harbour/rq-monitor:$(TAG)
	gcloud docker push eu.gcr.io/gi-harbour/rq-monitor

edge: publish
	kubectl rolling-update $(PREVRC) -f edge-rc.yml --update-period="1s"

rc:
	kubectl create -f rc.yml

svc:
	kubectl create -f svc.yml

edge-svc:
	kubectl create -f edge-svc.yml

edge-rc:
	kubectl create -f edge-rc.yml

run-dev: container
	docker run -d -p 9181:9181 goincremental/rq-monitor rq-dashboard
