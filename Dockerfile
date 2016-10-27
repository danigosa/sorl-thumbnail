FROM ubuntu:precise

# Fix locale to allow saving unicoded filenames
RUN echo 'LANG=en_US.UTF-8' > /etc/default/locale

RUN apt-get update && apt-get install -y python-pip && pip install --upgrade pip
RUN apt-get update && apt-get install -qq -y \
    python-software-properties \
    software-properties-common \
    libc6 \
    lsof \
    git \
    python-pip \
    libjpeg62 \
    libjpeg62-dev \
    zlib1g-dev \
    imagemagick \
    graphicsmagick

RUN apt-get update && apt-get install -qq -y \
    libmagickwand-dev \
    libgraphicsmagick++-dev \
    libboost-python-dev \
    libboost-thread-dev

RUN apt-get update && apt-get install -qq -y \
    libvips-tools

RUN apt-get update && apt-get install -qq -y \
    python-dev \
    python3-dev

RUN pip install wheel flake8 tox

# Add more snakes...
RUN add-apt-repository -y ppa:fkrull/deadsnakes
RUN apt-get update && apt-get install -y -qq python2.7 python2.7-dev python3.4 python3.4-dev

# Upgrade Redis to 2.8+ with Sentinel Support
RUN add-apt-repository ppa:chris-lea/redis-server
RUN apt-get update && apt-get install -y -qq redis-server

# Start in project dir by default
RUN mkdir -p /sorl-thumbnail

# Allow non-ascii file names
RUN echo "\n\ncd /sorl-thumbnail" >> /root/.bashrc
RUN echo "export LC_ALL=en_US.UTF-8" >> /root/.bashrc
RUN echo "export LANG=en_US.UTF-8" >> /root/.bashrc
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "LANG=en_US.UTF-8" >> /etc/environment
RUN apt-get update && apt-get install -qq -y \
    language-pack-en

RUN dpkg-reconfigure locales

# This is where everything starts...
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

