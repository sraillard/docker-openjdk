# Alpine image
FROM docker.io/alpine:3.13.0

# Install bash shell and default prompt
RUN apk add --no-cache bash
# Default bash prompt
COPY .bashrc /root/.bashrc

# Install make
RUN apk add --no-cache make

# Install curl
RUN apk add --no-cache curl

# Install OpenJDK 8 (Java 1.8) and Maven
RUN apk add --no-cache openjdk8 maven

# Install OpenSSH server and SFTP server with some default host keys
RUN apk add --no-cache openssh-server openssh-sftp-server
RUN mkdir /root/.ssh/
COPY id_rsa /root/.ssh/
COPY id_rsa.pub /root/.ssh/
RUN chmod 400 /root/.ssh/id_rsa
RUN chmod 400 /root/.ssh/id_rsa.pub

# Add a default working directory
RUN mkdir /work
WORKDIR /work

# Add an entry point script using bash
COPY docker-entrypoint.sh /usr/local/bin/
# For permission issue, the /bin/bash command should be added
# By default, the script is copied without exec right, whereas bash is already executable
ENTRYPOINT [ "/bin/bash" , "/usr/local/bin/docker-entrypoint.sh" ]

# Remove default "node" command and just wait to keep the container running
CMD [ "wait-infinite" ]

# Final default command executed will be:
# /bin/bash /usr/local/bin/docker-entrypoint.sh wait-infinite
