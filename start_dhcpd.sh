echo "Attempt to start DHCP Daemon"
sudo dhcpd -4 -cf /etc/dhcp/dhcpd.conf
DHCPD_ERROR_CODE=$?
if [ $DHCPD_ERROR_CODE -ne "0" ] 
then
    echo "Error starting DHCP Server"
    echo "Kill already running DHCP server? PLEASE VERIFY ABOVE!! [y/n]"
    read readvar
    if [ $readvar = 'y' ]
    then 
        DHCPDPID=`cat /var/run/dhcpd.pid`
        echo "killing dhcpd at pid " $DHCPDPID
        kill -15 $DHCPDPID
        echo "Starting dhcpd again"
        sudo dhcpd -4 -cf /etc/dhcp/dhcpd.conf
    elif [ $readvar = 'n' ]
    then
        echo "Exiting script without doing anything"
    else
        echo "Wrong input, Exiting script"
    fi
else
    echo "Successfully started DHCP server"
fi