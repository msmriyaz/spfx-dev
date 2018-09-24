$tenantAdminSiteUrl = "https://<yoursite>-admin.sharepoint.com";
$targetSite = "https://<yoursite>.sharepoint.com/sites/<TESTSITE>"
$adminUserName = "<adminlogin>";
$adminPassword = "<adminpassword>";
$securePassword = ConvertTo-SecureString $adminPassword -AsPlainText -Force
$O365AdminCredential = New-Object System.Management.Automation.PsCredential($adminUserName, $securePassword)


#Connect to your SharePoint Online tenant
Connect-SPOService -Url  $tenantAdminSiteUrl -Credential $O365AdminCredential

# get a reference to the site collection where the
# site collection app catalog should be created
$site = Get-SPOSite $targetSite

# create site collection app catalog
Add-SPOSiteCollectionAppCatalog -Site $site