#
# Bluetooth system service configuration
#

# lists of enabled services
systemctl list-unit-files --type=service | grep enabled
# stops the service
sudo systemctl stop bluetooth.service 
# disables service from loading at boot
sudo systemctl disable bluetooth.service 
# verify that service got disabled
systemctl status bluetooth.service 
# if you really want it dead (so other services can't start it again)
sudo systemctl mask bluetooth.service 
# lists of ALL services (some STATIC are dependancies of other services and can't be disabled)
systemctl list-unit-files --type=service 
