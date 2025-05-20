function Get-OfflineNetworkConfig {
    $networkCardsPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkCards\*"
    $tcpipBasePath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
    $connectionBasePath = "HKLM:\SYSTEM\ControlSet001\Control\Network\{4D36E972-E325-11CE-BFC1-08002BE10318}"

    $serviceNames = Get-ItemPropertyValue -Path $networkCardsPath -Name ServiceName

    foreach ($serviceName in $serviceNames) {
        $connectionPath = "$connectionBasePath\$serviceName\Connection"
        try {
            $adapterReg = Get-ItemProperty -Path $connectionPath -ErrorAction Stop
            $adapterName = $adapterReg.Name
        } catch {
            continue
        }

        if (-not $adapterName) { continue }

        $tcpipPath = "$tcpipBasePath\$serviceName"
        $netSettings = Get-ItemProperty -Path $tcpipPath -ErrorAction SilentlyContinue

        function Get-ValueInline($object, $property) {
            if ($object.PSObject.Properties.Name -contains $property -and -not [string]::IsNullOrWhiteSpace($object.$property)) {
                return $object.$property
            } else {
                return "DHCP"
            }
        }

        $output = [PSCustomObject]@{
            Interface      = $adapterName
            IpAddress      = Get-ValueInline $netSettings 'IPAddress'
            SubnetMask     = Get-ValueInline $netSettings 'SubnetMask'
            DefaultGateway = Get-ValueInline $netSettings 'DefaultGateway'
        }

        if ($netSettings.PSObject.Properties.Name -contains 'NameServer') {
            $dnsServers = (Get-ValueInline $netSettings 'NameServer') -split ","
            for ($i = 0; $i -lt $dnsServers.Count; $i++) {
                $output | Add-Member -MemberType NoteProperty -Name "DNS$($i+1)" -Value ($dnsServers[$i].Trim())
            }
        } else {
            $output | Add-Member -MemberType NoteProperty -Name "DNS" -Value "DHCP"
        }

        $output
    }
}
Export-ModuleMember -Function Get-OfflineNetworkConfig
