FROM python:2.7
MAINTAINER Go Incremental Limited <info@goincremental.com>
RUN git clone https://github.com/nvie/rq-dashboard.git
WORKDIR ./rq-dashboard
RUN python setup.py install
EXPOSE 9181
CMD ["rq-dashboard"]
