#!/bin/bash
if [ $EUID -ne 0 ]; then echo '[+] You must run this as root!'; sudo bash $0; exit; fi

USERNAME=labuser
PASSWORD=$(dd if=/dev/urandom count=1 bs=4096 2>/dev/null | sha256sum | head -c 16)

sudo apt update
sudo apt install -y docker.io gcc make

useradd -s /bin/bash -m -G docker labuser
echo -n "${USERNAME}:${PASSWORD}" | chpasswd
home_dir=$(getent passwd "${USERNAME}" | cut -d: -f6)

make

cp -v docker/resources/run.sh ${home_dir}/run.sh
chmod 755 ${home_dir}/run.sh
chown "${USERNAME}.${USERNAME}" ${home_dir}/run.sh

cat <<EOF >>/etc/ssh/sshd_config
Match user labuser
	ForceCommand ${home_dir}/run.sh
Match all
EOF
service ssh restart

echo ''
echo ''
echo 'All finished!'
echo ''
echo "Have your lab users log in with:"
echo "    ssh ${USERNAME}@$(curl icanhazip.com 2>/dev/null)"
echo "    password: ${PASSWORD}"
echo ''
