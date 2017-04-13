if [ -z "$1" ]
  then
    echo "Syntax is startBigIP_Win2012_Linux.sh [start|stop]"
    echo "No argument supplied"
    exit 1
fi
/Applications/VMware\ Fusion.app/Contents/Library/vmrun $1 /Users/rduchez/Documents/virtual_machines/WindowsServer2012.vmwarevm 
/Applications/VMware\ Fusion.app/Contents/Library/vmrun $1 /Users/rduchez/Documents/Virtual\ Machines.localized/BIG-IP-vLAB-02.vmwarevm
/Applications/VMware\ Fusion.app/Contents/Library/vmrun $1 /Users/rduchez/Documents/Virtual\ Machines.localized/Linux-host.vmwarevm
