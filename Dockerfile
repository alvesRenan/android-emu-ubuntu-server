FROM ubuntu:18.04

RUN apt update

RUN apt install -y \
	wget \
	zip \
	socat \
	net-tools \
	default-jdk \
  --no-install-recommends && rm -rf /var/lib/apt/lists/*

WORKDIR /root

RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -O sdk-tools.zip

RUN unzip sdk-tools.zip && rm sdk-tools.zip

ENV PATH=$PWD/tools:$PWD/tools/bin:$PATH

COPY port_forward.sh /root

RUN chmod +x /root/port_forward.sh

ENTRYPOINT /root/port_forward.sh