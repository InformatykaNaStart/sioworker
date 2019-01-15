FROM debian:stable
RUN apt update &&\
  apt install -y git bash supervisor wget &&\
  useradd -s /bin/bash -m sio2

### isolate

RUN apt install -y make gcc libcap-dev libseccomp-dev &&\
  git clone https://github.com/hugo213/isolate.git /tmp/isolate &&\
  cd /tmp/isolate &&\
  make isolate &&\
  make install &&\
  rm -fr /tmp/isolate

### sioworkers

RUN DEBIAN_FRONTEND=noninteractive apt install -y python-setuptools python-bsddb3 python-progressbar python-requests python-six python-simplejson python-celery python-twisted python-sortedcontainers python-pytest python-pytest-runner python-pytest-timeout python-enum34 python-poster python-virtualenv libpython2.7-dev libdb-dev gcc g++

USER sio2
RUN git clone https://github.com/xneby/sioworkers.git /home/sio2/sioworkers &&\
  python -m virtualenv /home/sio2/venv &&\
  . /home/sio2/venv/bin/activate &&\
  cd /home/sio2/sioworkers &&\
  git checkout docker &&\
  python setup.py install

### katalog supervisord

RUN mkdir /home/sio2/logs /home/sio2/pidfiles

### sandboxy

ENV SIO_SANDBOXES_URL="http://hugo.w.staszic.waw.pl/sio2-sandboxes"
COPY get_sandboxes.py /home/sio2/get_sandboxes.py
RUN . /home/sio2/venv/bin/activate &&\
  python /home/sio2/get_sandboxes.py

### konfiguracja
ENV WORKER_USER=sio2 WORKER_HOME=/home/sio2 FILETRACKER_CACHE_CLEANER_ENABLED=true CACHE_SIZE=10G SCAN_INTERVAL=1h CLEAN_LEVEL=50 WORKER_ENABLED=true SIOWORKERSD_HOST=10.0.3.101 FILETRACKER_URL=http://10.0.3.101:9999 PROBLEM_MEMORY_MAX_LIMIT=600000 WORKER_CONCURRENCY=6 WORKER_ALLOW_RUN_CPU_EXEC=false WORKER_EXTRA_FLAGS=""

COPY run.sh /home/sio2/run.sh
CMD ["/home/sio2/run.sh"]

