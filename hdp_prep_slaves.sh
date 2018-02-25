#!/usr/bin bash
# MANUAL PREPARATION WORK:
# Login to AWS EC2 Zone (eu-west my preference)
# Configure 3 (minimum, because Zookeeper quorum needs) Instances of Centos 7 HVM
# (Tried RHEL 7.4 at first, but turned out to miss certain things like wget and libtirpc-devel - easy to install but why)
### t2.xlarge (smallest successfull test on 4x16)
### 10GiB SSD (delete on termination, 10 is supposedly minimum requirement, should I use more?)
### Security Group - All Traffic / MyIp (all instances need eachother, I need SSH for config and web access for Ambari web UI)
### Use security key
### Launch all instances
# ssh centos@<external fqdn> - start on the machine that will run Ambari server
### (Is there a way to also automate these steps?)
### Generate keys in .ssh by: ssh-keygen
### Copy public key to the other hosts: /home/centos/.ssh/id_rsa.pub
# After running the below commands, remember to ssh from Master to Slaves and say yes to warning message
# Copy/paste/run (sudo bash) the following to prep each slave instance
cat /home/centos/.ssh/id_rsa.pub >> /home/centos/.ssh/authorized_keys
chmod 700 /home/centos/.ssh
chmod 600 /home/centos/.ssh/id_rsa.pub
setenforce 0
umask 0022
yum repolist && yum makecache fast && yum update -y
yum install -y ntp && systemctl enable ntpd
systemctl disable firewalld && service firewalld stop
yum install -y git python-argparse epel-release