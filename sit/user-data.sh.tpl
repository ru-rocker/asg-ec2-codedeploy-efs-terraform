#!/bin/bash
mkdir -p "${efs_mount_point_1}"
test -f "/sbin/mount.efs" && printf "\n${file_system_id_1}:/ ${efs_mount_point_1} efs iam,tls,_netdev\n" >> /etc/fstab || printf "\n${file_system_id_1}.efs.ap-southeast-1.amazonaws.com:/ ${efs_mount_point_1} nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport,_netdev 0 0\n" >> /etc/fstab
test -f "/sbin/mount.efs" && grep -ozP 'client-info]\nsource' '/etc/amazon/efs/efs-utils.conf'; if [[ $? == 1 ]]; then printf "\n[client-info]\nsource=liw\n" >> /etc/amazon/efs/efs-utils.conf; fi;
sed -i "s/stunnel_check_cert_hostname = true/stunnel_check_cert_hostname = false/g" /etc/amazon/efs/efs-utils.conf
sed -i "s/#region = us-east-1/region = ap-southeast-1/g" /etc/amazon/efs/efs-utils.conf
mount -t efs -o tls ${file_system_id_1}:/ ${efs_mount_point_1}
mkdir -p "${efs_wildfly_folder}"
chown -R wildfly.wildfly /shared/wildfly/
service codedeploy-agent restart