FROM centos:centos7
RUN yum install -y wget
RUN wget http://packages.ntop.org/centos-stable/ntop.repo -O /etc/yum.repos.d/ntop.repo
RUN yum clean all \
    yum update \
	yum install pfring n2disk nprobe ntopng ntopng-data cento
RUN echo 'FLOW="$Flow"' > /run.sh \
    echo 'LOCAL="$Local"' >> /run.sh \
    echo '/usr/bin/redis-server /etc/redis.conf --daemonize no &' >> /run.sh \
    echo 'nprobe -i none -n none -3 $FLOW --zmq tcp://127.0.0.1:2055 &' >> /run.sh \
    echo 'ntopng --http-port 3000 --local-networks $LOCAL -i tcp://127.0.0.1:2055 --user nobody -G=/var/tmp/ntopng.pid --community  --daemon &' >> /run.sh \
    echo 'while true; do' >> /run.sh \
    echo 'sleep 5' >> /run.sh \
    echo 'done' >> /run.sh
RUN	echo chmod +x /run.sh
ENTRYPOINT /run.sh
