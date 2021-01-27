#!/bin/bash

# Entry point documentation:
# https://success.docker.com/article/use-a-script-to-initialize-stateful-container-data

# Exit script if any command return non zero
set -e

# Print some information
# ================================
echo "*** VERSION java : `java -version 2>&1`"
echo "*** VERSION mvn  : `mvn -version`"

# Check if only waiting is asked (for debug in k8s)
# =================================================
if [ "$1" = 'wait-infinite' ]; then
	echo "*** Infinite wait (debug): keeping the container running..."
	while true; do echo "Sleeping 10s..."; sleep 10; done
fi

# Check if SSH server is asked (for debug in k8s)
# ===============================================
if [ "$1" = 'ssh-server' ]; then
	echo "*** Launching SSH server..."
	# Copy the current environment variables for the next SSH clients
	printenv > /root/.ssh/environment
	# Set the root password to blank
	passwd root -d
	# Run SSH server (Warning: no security!)
	/usr/sbin/sshd -D -4 -p 22 -h /root/.ssh/id_rsa -o PasswordAuthentication=yes -o PermitRootLogin=yes -o PermitEmptyPasswords=yes -o PermitUserEnvironment=yes
fi

# "$@" = all parameters, ie default CMD or manual parameters specified
echo "*** Executing a non default command [$@]"
exec "$@"
