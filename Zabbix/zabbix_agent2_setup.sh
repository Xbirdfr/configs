apt purge -y zabbix-agent
tmpdir = 'zabbixsetuptmp'
mkdir $tmpdir
cd $tmpdir
sudo wget https://repo.zabbix.com/zabbix/5.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.0-1+$(lsb_release -sc)_all.deb
sudo dpkg -i zabbix-release_5.0-1+$(lsb_release -sc)_all.deb
apt update
apt install -y zabbix-agent2
cd ..
rm -rf $tmpdir
