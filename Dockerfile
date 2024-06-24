FROM ubuntu
RUN apt-get -y --force-yes update\
	&&apt-get -y --force-yes install vim \
	&& apt-get -y --force-yes install iputils-ping \
	&& apt-get -y --force-yes install procps \
	&& apt-get -y --force-yes install net-tools \
	&& apt-get -y --force-yes install telnet
	
EXPOSE 5000
