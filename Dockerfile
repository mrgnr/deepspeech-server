# $ docker build -t deepspeech-server .
# $ wget https://github.com/mozilla/DeepSpeech/releases/download/v0.6.0/deepspeech-0.6.0-models.tar.gz
# $ tar -xzvf deepspeech-0.6.0-models.tar.gz
# $ docker run -d \
#       --name deepspeech-server \
#       --mount type=bind,source="$(pwd)/config.json",target="/etc/deepspeech-server/config.json",readonly \
#       --mount type=bind,source="$(pwd)/deepspeech-0.6.0-models",target="/deepspeech-0.6.0-models",readonly \
#       -p 8080:8080 \
#       deepspeech-server

FROM python:3.5-slim-buster

RUN pip3 install \
    cyclotron==0.5 \
    cyclotron-aio==0.5 \
    cyclotron-std==0.5 \
    rx==1.6.1 \
    deepspeech==0.6.0 \
    https://github.com/mrgnr/deepspeech-server/archive/ds-v0.6.x.zip

ADD config.json /etc/deepspeech-server/config.json
EXPOSE 8080

CMD ["/usr/local/bin/deepspeech-server", "--config", "/etc/deepspeech-server/config.json"]
