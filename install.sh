#!/bin/bash
#
#
# This will automatically install the WTU menus and email configuration.
#
# Must be run as root or in sudo
#
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Not running with sufficient permissions, please use sudo."
    exit
fi
#
clear
#
echo "Beginning MS installation process..."
echo ""
echo "Moving main files to the /opt folder." ; sleep 1
#
cp -r opt /
#
# Copy over the crontab
#
echo "Copying /etc folder to root." ; sleep 1
#
cp -r etc /
#
# Linking required menu scripts
#
echo "Linking menu and other scripts." ; sleep 1
#
# remove old links
# 
rm /usr/bin/wp-diagnostics
rm /usr/bin/change_sitename
#
ln -s /opt/wellpass/wp-diagnostics /usr/bin/
ln -s /opt/wellpass/change_sitename /usr/bin/
#
# Setting as executable
#
echo "Setting executable permissions on scripts." ; sleep 1
#
chmod +x /usr/bin/wp-diagnostics /usr/bin/change_sitename
#
# And lastly, make sure all permissions are set correctly
#
echo "Setting file permissions." ; sleep 1
#
chown wpadmin:wpadmin -R /home/wpadmin/
#
echo ""
echo "Installation and setup complete..."
echo ""
#
systemctl restart cron.service
#
echo "Installation Finished."
