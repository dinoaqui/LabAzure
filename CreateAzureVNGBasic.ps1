#
# Edit it according to your environment.
#

# Define your Resource Group Name
$resourceGroupName = "RG_VPN_BASIC"
# Define your VNET Name
$vnetName = "VNET-BASIC"
# Put your Region
$location = "East US"
# Set VNG Name
$gatewayName = "VNG-BASIC"
# Set Subnet Name
$subnetName = "GatewaySubnet"
# Set Subnet Gateway Address
$subnetPrefix = "192.168.1.0/27"
# Set Public IP VNG Name
$publicIpName = "pip-VNG-BASIC"


# CreateSubnetGateway
$subnet = New-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix $subnetPrefix

# Get VNET info
$vnet = Get-AzVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroupName

# Get SubnetGateway info
$subnetConfig = Get-AzVirtualNetworkSubnetConfig -name 'gatewaysubnet' -VirtualNetwork $vnet

# Create Public IP
$publicIp = New-AzPublicIpAddress -ResourceGroupName $resourceGroupName -Location $location -Name $publicIpName -AllocationMethod Dynamic -Sku Basic

# Create IP Configuration for Gateway
$gwIpConfig = New-AzVirtualNetworkGatewayIpConfig -Name "${gatewayName}IpConfig" -SubnetId $subnetConfig.Id -PublicIpAddressId $publicIp.Id

# Create Azure Virtual Network Gateway
New-AzVirtualNetworkGateway -ResourceGroupName $resourceGroupName -Location $location -Name $gatewayName -IpConfigurations $gwIpConfig -GatewayType "Vpn" -VpnType "RouteBased" -GatewaySku "Basic"
