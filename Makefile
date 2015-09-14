TAG=`cat version`

container:
	docker build -t goincremental/rq-monitor .

publish: container
	bumpversion patch --commit --tag
	TAG=`cat version`
	docker tag -f goincremental/rq-monitor eu.gcr.io/gi-harbour/rq-monitor
	docker tag -f goincremental/rq-monitor eu.gcr.io/gi-harbour/rq-monitor:$(TAG)
	gcloud docker push eu.gcr.io/gi-harbour/rq-monitor

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
