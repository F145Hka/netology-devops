FROM centos:centos7
RUN yum -y --enablerepo=extras install epel-release && yum clean all && yum -y update
RUN yum install wget make gcc openssl-devel bzip2-devel libffi-devel -y
RUN wget https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tgz && tar xzf Python-3.7.2.tgz
RUN cd Python-3.7.2 && ./configure --enable-optimizations && make altinstall
RUN mkdir /python_api
WORKDIR /python_api
COPY python-api.py /python_api/
COPY requirements.txt /python_api/
RUN pip3.7 install -r requirements.txt
CMD  ["python3.7", "python-api.py"]