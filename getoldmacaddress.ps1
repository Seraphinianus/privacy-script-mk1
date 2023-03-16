Reg.exe delete "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "NetworkAddress" /f
Reg.exe delete "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0013" /v "NetworkAddress" /f

netsh interface set interface name="Ethernet" admin="disable"
netsh interface set interface name="Ethernet" admin="enable"

netsh interface set interface name="Wi-Fi" admin="disable"
netsh interface set interface name="Wi-Fi" admin="enable"

Exit