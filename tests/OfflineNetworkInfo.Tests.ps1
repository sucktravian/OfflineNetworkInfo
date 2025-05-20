# Import the module
Import-Module "$PSScriptRoot/../OfflineNetworkInfo.psm1"

Describe "OfflineNetworkConfig" {
    It "Should return an array of objects with expected properties" {
        $result = Get-OfflineNetworkConfig
        $result | ForEach-Object {
            $_ | Should -BeOfType PSObject
            $_.PSObject.Properties.Name | Should -Contain "Interface"
            $_.PSObject.Properties.Name | Should -Contain "IpAddress"
            $_.PSObject.Properties.Name | Should -Contain "SubnetMask"
            $_.PSObject.Properties.Name | Should -Contain "DefaultGateway"

            # Check for DNS properties (DNS or DNS1, DNS2 etc)
            $dnsProps = $_.PSObject.Properties.Name | Where-Object { $_ -match "^DNS\d*$" }
            $dnsProps | Should -Not -BeNullOrEmpty
        }
    }

    It "Should not throw errors when run" {
        { Get-OfflineNetworkConfig } | Should -Not -Throw
    }
}
