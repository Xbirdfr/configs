echo 'Xbird.me Zabbix PSK setup'
echo '----------------------------------------'
echo 'Answer custom parameters, or enter to usse default config'
read -e -i "/etc/zabbix" -p "Config Path: " path

if [ ! -d $path ] 
then
    echo "Directory $path DOES NOT exists." 
    exit 1 # die
fi

read -e -i "zabbix_agent2.conf" -p "Zabbix agent config file: " config_file_name
read -e -i "zabbix_agentd.psk" -p "Zabbix agent PSK file: " psk_file_name
read -e -i $HOSTNAME -p "PSK identity  (you have to set the same in Zabbix host configuration) : " pskidentity


cd $path
openssl rand -hex 32 > $psk_file_name
echo 'TLSConnect=psk' >> $config_file_name
echo 'TLSAccept=psk' >> $config_file_name
echo "TLSPSKFile=$path/$psk_file_name" >> $config_file_name
echo "TLSPSKIdentity=$pskidentity" >> $config_file_name

echo '----------------------------------------'
echo 'Please config your Zabbix host with this :'
echo ' '
echo "PSK Identity : $pskidentity"
echo "PSK Key : $(cat $psk_file_name)"
echo ' '
echo 'Dont forget to reload / restart your zabbix agent'
echo '----------------------------------------'
