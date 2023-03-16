$adapter = Get-NetAdapter | Where {$_.Name -Match "Wi-Fi"}
$MacAddress = $adapter.InterfaceDescription

$MacAddress