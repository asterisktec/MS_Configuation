#!/bin/bash
#
#
# This will automatically update the WTU menus and scripts without touching email.
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
echo "Beginning MS update process..."
echo ""
echo "Backing up any old configuration"
echo ""
#
rm -rf /opt/wellpass_old
#
mv /opt/wellpass /opt/wellpass_old ; sleep 1
#
echo "Moving main files to the /opt folder." ; sleep 1 
#
cp -r opt /
#
# Copy over the new crontab file
# but backup the old one just to be safe.
#
echo "Backing up system scheduler." ; sleep 1 
#
mv /etc/crontab /etc/crontab.bac
#
# Copy over the crontab file
#
echo "Updating the system scheduler." ; sleep 1 
#
cp -r etc/crontab /etc/crontab
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
#
systemctl restart cron.service
#
echo "Restoring Site Name and Testing Server" ; sleep 1
#
cp /opt/wellpass_old/site_name /opt/wellpass/
#
echo "Update Finished."
