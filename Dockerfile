# Ubuntu
FROM ubuntu:16.04

# Environment Variables
ENV PYTHONUNBUFFERED 1
ENV REQUESTS_CA_BUNDLE /etc/ssl/certs/ca-certificates.crt

# install stuff
RUN apt-get update && apt-get install -y \
  build-essential \
  python3 \
  python3-pip \
  python3-dev \
  ipython \
  git-core \
  libpq-dev \
  libjpeg-dev \
  binutils \
  libproj-dev \
  gdal-bin \
  libxml2-dev \
  libxslt1-dev \
  zlib1g-dev \
  libffi-dev \
  libssl-dev \
  language-pack-pt

# Handle all proxt certificate issue
RUN mkdir /usr/local/share/ca-certificates/extra
COPY files/proxy.cer /usr/local/share/ca-certificates/extra/
WORKDIR /usr/local/share/ca-certificates/extra/
RUN openssl x509 -inform DER -in proxy.cer -out proxy.pem -text; \
    cp proxy.pem proxy.pem.crt; \
    update-ca-certificates

# Install jira_python and ipython
RUN pip3 install jira \
    ipython \
    --upgrade pip


RUN dpkg-reconfigure locales
# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
RUN locale

ENTRYPOINT ["/bin/bash", "-l"]
CMD ["-c", "while true; do sleep 5; done"]
