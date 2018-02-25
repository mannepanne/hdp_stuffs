#!/bin/bash
# Run this on each Ambari host (sudo bash) to set the correct /etc/hosts
MY_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
MY_LOCAL=$(curl -s http://169.254.169.254/latest/meta-data/local-hostname)
echo $MY_IP
echo $MY_LOCAL
cat > /etc/hosts << EOF
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
$MY_IP $MY_LOCAL
EOF