#!/system/bin/sh

#set -x 
setprop sys.adbon.oneshot 0
state=`getprop sys.usb.state`
if [ -d "/factory/.adbon" ]; then
  while [ "mtp" != "$state" ]
  do
      sleep 1
      state=`getprop sys.usb.state`
  done
  setprop sys.usb.config mtp,adb
  setprop sys.adbon.oneshot 1
	rm -rf /factory/.adbon
fi
