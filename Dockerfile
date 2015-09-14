FROM python:2.7
MAINTAINER Go Incremental Limited <info@goincremental.com>
RUN pip install rq-dashboard
EXPOSE 9181
CMD ["rq-dashboard"]
