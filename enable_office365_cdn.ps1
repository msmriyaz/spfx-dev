<# Script summarises the operation defined in:
https://docs.microsoft.com/en-us/sharepoint/dev/spfx/extensions/get-started/hosting-extension-from-office365-cdn

The intend of this script is to enable CDN capabiliy on SharePoint Online to host SPFX component.
#>

$tenantAdminSiteUrl = "https://<orgname>-admin.sharepoint.com";
$adminUserName = "<adminlogin>";
$adminPassword = "<adminpassword>";
$securePassword = ConvertTo-SecureString $adminPassword -AsPlainText -Force
$O365AdminCredential = New-Object System.Management.Automation.PsCredential($adminUserName, $securePassword)

#Connect to your SharePoint Online tenant
Connect-SPOService -Url  $tenantAdminSiteUrl -Credential $O365AdminCredential

#Get the current status of public CDN settings from the tenant level by executing the following commands one-by-one
$isSPOTenantCdnEnabled = Get-SPOTenantCdnEnabled -CdnType Public
$isSPOTenantCdnOrigins = Get-SPOTenantCdnOrigins -CdnType Public
$isSPOTenantCdnPolicies = Get-SPOTenantCdnPolicies -CdnType Public

Write-Host "`'Get-SPOTenantCdnEnabled`' returned => $($isSPOTenantCdnEnabled)" -f Yellow;
Write-Host "`'Get-SPOTenantCdnOrigins`' returned => $($isSPOTenantCdnOrigins)" -f Yellow;
Write-Host "`'Get-SPOTenantCdnPolicies`' returned => $($isSPOTenantCdnPolicies)" -f Yellow;

if($isSPOTenantCdnEnabled -ne $false){
    Write-Host "Detected cdn host capability has been turned off" -f Yellow;

    #Enable public CDN in the tenant
    Write-Host "Enabling public CDN on tenant" -f Green;
    Set-SPOTenantCdnEnabled -CdnType Public -Confirm:$false

    #Execute the following command to get the list of CDN origins from your tenant
    Write-Host "Get the list of CDN origins from your tenant" -f Magenta;
    Get-SPOTenantCdnOrigins -CdnType Public

}

<#
Note:
When the origin is listed without the (configuraiton pending) text,
then we are good to use the CDN feature

Public CDN enabled locations:
*/MASTERPAGE (configuration pending)
*/STYLE LIBRARY (configuration pending)
*/CLIENTSIDEASSETS (configuration pending)

Get the list of CDN origins from your tenant
*/MASTERPAGE (configuration pending)
*/STYLE LIBRARY (configuration pending)
*/CLIENTSIDEASSETS (configuration pending)

---------
Use the 'Get-SPOTenantCdnOrigins -CdnType Public' command to very the latest status (this takes over 15 mins sometime)

When the CDN is ready, your output would be similar to the one below:
*/MASTERPAGE
*/STYLE LIBRARY
*/CLIENTSIDEASSETS
#>