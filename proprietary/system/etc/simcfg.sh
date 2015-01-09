#!/system/bin/sh
SIM_DETECT=$(cat /proc/sim_id)
if [ -n "$SIM_DETECT" ]; then
	case $SIM_DETECT in
	    "0")
		setprop persist.ril-daemon.disable "0"
		setprop persist.radio.ril_modem_state "1"
		setprop persist.dual_sim "0"
		setprop persist.dynamic-data-sim "false"
		;;
	    "1")
	        setprop persist.ril-daemon.disable "dsds"
		setprop persist.radio.ril_modem_state "1"
		setprop persist.dual_sim "dsds"
		setprop persist.dynamic-data-sim "reboot"
	        ;;
	      *)
	        setprop persist.ril-daemon.disable "dsds"
		setprop persist.radio.ril_modem_state "1"
		setprop persist.dual_sim "dsds"
		setprop persist.dynamic-data-sim "reboot"
		;;
	esac
else
        setprop persist.ril-daemon.disable "dsds"
        setprop persist.radio.ril_modem_state "1"
        setprop persist.dual_sim "dsds"
        setprop persist.dynamic-data-sim "reboot"
fi

