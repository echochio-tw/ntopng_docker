FROM centos:centos7
RUN yum install -y wget
RUN wget http://packages.ntop.org/centos-stable/ntop.repo -O /etc/yum.repos.d/ntop.repo
RUN rpm -ivh  http://download.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum clean all && yum update
RUN yum install -y pfring n2disk nprobe ntopng ntopng-data cento sudo
RUN echo 'FLOW="$Flow"' > /run.sh ;\
    echo 'LOCAL="$Local"' >> /run.sh ;\
    echo 'sudo -u redis /usr/bin/redis-server /etc/redis.conf --daemonize no &' >> /run.sh ;\
    echo 'nprobe -i none -n none -3 $FLOW --zmq tcp://127.0.0.1:2055 &' >> /run.sh ;\
    echo 'echo "-G=/var/run/ntopng.pid\\" > /etc/ntopng/ntopng.conf' >>  /run.sh ;\
    echo 'echo "--community" >> /etc/ntopng/ntopng.conf' >>  /run.sh ;\
    echo 'echo "-i tcp://127.0.0.1:2055" >> /etc/ntopng/ntopng.conf' >>  /run.sh ;\
    echo 'echo "--local-networks $LOCAL" >> /etc/ntopng/ntopng.conf' >>  /run.sh ;\
    echo '/etc/init.d/ntopng start' >> /run.sh ;\
    echo 'while true; do' >> /run.sh ;\
    echo 'sleep 5' >> /run.sh ;\
    echo 'done' >> /run.sh
RUN chmod +x /run.sh
ENTRYPOINT /run.sh

