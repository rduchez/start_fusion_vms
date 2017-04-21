if [ -z "$1" ]
  then
    echo "error: No argument supplied"
    echo "Syntax is startBigIP_Win2012_Linux.sh [start|stop] {ad}"
    echo "AD can be started by adding ad after the start/stop mantra"
    exit 1
fi

if [ "$1" == "stop" ]
	then
        echo "Stopping"
	ssh root@192.168.155.242 'now=$(date +"%m_%d_%Y"); tmsh save sys config file config_$now.scf no-passphrase'
	ssh root@192.168.155.242 'now=$(date +"%m_%d_%Y"); tmsh save sys ucs config_$now.ucs'
	now=$(date +"%m_%d_%Y")
	scp root@192.168.155.242:/var/local/scf/config_$now.scf .
fi

/Applications/VMware\ Fusion.app/Contents/Library/vmrun $1 /Users/rduchez/Documents/Virtual\ Machines.localized/BIG-IP-vLAB-02.vmwarevm
/Applications/VMware\ Fusion.app/Contents/Library/vmrun $1 /Users/rduchez/Documents/Virtual\ Machines.localized/Linux-host.vmwarevm

if [ "$2" == "ad" ]
  then
        /Applications/VMware\ Fusion.app/Contents/Library/vmrun $1 /Users/rduchez/Documents/virtual_machines/WindowsServer2012.vmwarevm 
fi

# load default config at start 
if [ "$1" == "start" ]
	then
		echo 'Starting'
		until $(curl -k --output /dev/null --silent --fail https://admin:admin@192.168.155.242/mgmt/toc/); do
			printf '.'
			sleep 20
		done
		ssh root@192.168.155.242 'tmsh load sys ucs bigip02_base.ucs'
fi
