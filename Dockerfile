FROM ubuntu:18.04

RUN apt update

RUN apt install -y \
	wget \
	unzip \
	socat \
	net-tools \
	openjdk-8-jdk \
	openjdk-8-jre \
	iproute2 \
	qemu-kvm \
	libvirt-bin \
	virtinst \
	bridge-utils \
	cpu-checker \
  --no-install-recommends && \
	rm -rf /var/lib/apt/lists/*

WORKDIR /root

RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip \
	-O sdk-tools.zip \
	--no-check-certificate

RUN unzip sdk-tools.zip && rm sdk-tools.zip

ENV PATH=/root/tools:/root/tools/bin:$PATH

ENV ANDROID_AVD_HOME=/root/.android/avd

ENV ANDROID_SDK_ROOT=/root

COPY port_forward.sh /root

RUN chmod +x /root/port_forward.sh

# Remove later
RUN echo "y" | sdkmanager "platforms;android-23" "system-images;android-23;google_apis;x86" "build-tools;23.0.3"
#

EXPOSE 5554/tcp

EXPOSE 5555/udp

CMD /root/port_forward.sh