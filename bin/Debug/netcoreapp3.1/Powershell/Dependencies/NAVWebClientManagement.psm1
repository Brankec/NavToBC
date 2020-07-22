#Requires -Version 4
#Requires -RunAsAdministrator

<#
.SYNOPSIS
Gets the information about the Business Central web server instances that are registered on a computer.
.DESCRIPTION
You can use Get-NAVWebServerInstance cmdlet to get the following information about Business Central web server instances that are registered in IIS on the computer.

WebServerInstance: The name of the Business Central web server instance
Uri: Unified Resource Locator of web server instance.
SiteDeploymentType: The deployment type of the web server instance. Possible values are: RootSite or SubSite
Server: The computer that is running the Business Central Server that the Business Central web server instance connects to.
ServerInstance: The Business Central Server instance that the Business Central web server instance connects to.
ClientServicesPort: Specifies the listening TCP port for the Business Central Server instance that the Business Central web server instance connects to.
ManagementServicesPort: Specifies the listening TCP port that is used to manage the Business Central Server instance.
DNSIdenity: Specifies the subject name or common name of the service certificate for Business Central Server instance. This parameter is only relevant when the ClientServicesCredentialType in the Business Central Server instance configuration is set to UserName, NavUserPassword, or AccessControlService. These credential types requires that security certificates are used on the Dynamics NAV web server and Business Central Server instances to protect communication.
Configuration File: The location of the navsettings.json file that is used by the Business Central web server instance.
Version: The platform version of the Business Central web server instance.
.PARAMETER WebServerInstance
Specifies the name of the Business Central web server instance that you want information about. If you omit this parameter, then the cmdlet returns information about all Business Central web server instances.
.EXAMPLE
Get-NAVWebServerInstance -WebServerInstance DynamicsNAV
This example gets information about the Business Central web server instance that is named 'DynamicsNAV'.
#>
function Get-NAVWebServerInstance
(
    [string] $WebServerInstance
) {
    $instances = @()

    Import-Module WebAdministration

    foreach ($site in Get-Website) {
        $exePath = Join-Path $site.PhysicalPath "Prod.Client.WebCoreApp.exe"
        if (Test-Path $exePath) {
            $settingFilePath = Join-Path $site.PhysicalPath "navsettings.json"
            $settings = Get-Content $settingFilePath -Raw | ConvertFrom-Json

            $instance = [PSCustomObject]@{
                WebServerInstance            = $site.Name
                Website                      = $site.Name
                Uri                          = Get-NavWebSiteUrl -WebSite $site
                SiteDeploymentType           = "RootSite"
                "Configuration File"         = $settingFilePath
                ClientServicesPort           = $settings.NAVWebSettings.ClientServicesPort
                ManagementServicesPort       = $settings.NAVWebSettings.ManagementServicesPort
                ClientServicesCredentialType = $settings.NAVWebSettings.ClientServicesCredentialType
                DnsIdentity                  = $settings.NAVWebSettings.DnsIdentity
                Server                       = $settings.NAVWebSettings.Server
                ServerInstance               = $settings.NAVWebSettings.ServerInstance
                Version                      = Get-ChildItem -Path $exePath | % versioninfo | % fileversion
            }

            $instances += $instance
        }

        foreach ($application in  Get-WebApplication -Site $site.Name) {
            $exePath = Join-Path $application.PhysicalPath "Prod.Client.WebCoreApp.exe"
            if (Test-Path $exePath) {
                $settingFilePath = Join-Path $application.PhysicalPath "navsettings.json"
                $settings = Get-Content $settingFilePath -Raw | ConvertFrom-Json

                $instance = [PSCustomObject]@{
                    WebServerInstance            = $application.Path.Trim('/')
                    Website                      = $site.Name
                    Uri                          = Get-NavWebSiteUrl -WebSite $site -Application $application
                    SiteDeploymentType           = "SubSite"
                    "Configuration File"         = $settingFilePath
                    ClientServicesPort           = $settings.NAVWebSettings.ClientServicesPort
                    ManagementServicesPort       = $settings.NAVWebSettings.ManagementServicesPort
                    ClientServicesCredentialType = $settings.NAVWebSettings.ClientServicesCredentialType
                    DnsIdentity                  = $settings.NAVWebSettings.DnsIdentity
                    Server                       = $settings.NAVWebSettings.Server
                    ServerInstance               = $settings.NAVWebSettings.ServerInstance
                    Version                      = Get-ChildItem -Path $exePath | % versioninfo | % fileversion
                }

                $instances += $instance
            }
        }
    }
    if ($WebServerInstance){
        $instances | where {$_.WebServerInstance -eq $WebServerInstance} | Write-Output
    }
    else {
        Write-Output $instances
    }
}

<#
.SYNOPSIS
Changes a configuration value for a Business Central web server instance.
.DESCRIPTION
Each web server instance has a configuration file called the navsettings.json file, which is stored in the physical path of the web server instance. This file contains several key-value pairs that configure various settings. The key-value pairs have the format "KeyName":  "KeyValue", such as "ClientServicesCredentialType":  "Windows". You can use this cmdlet to change the value of any key in the configuration file.  The changes will be applied to the web server instance automatically because the application pool is recycled. When the application pool is recycled by the IIS, static state such as client sessions in the Business Central Web client will be lost.
.PARAMETER WebServerInstance
Specifies the name of the web server instance in IIS.
.PARAMETER KeyName
Specifies the configuration key name as it appears in the web server instance’s configuration file (navsettings.json).
.PARAMETER KeyValue
Specifies configuration key value.
.PARAMETER SiteDeploymentType
Specifies the deployment type of web server instance. There are two possible values: SubSite and RootSite.
-   Use SubSite if the web server instance was created as a subsite (web application) to a container website. If you specify SubSite, you will have to set the -ContainerSiteName parameter. If the subsite is under the default container website 'Microsoft Dynamics 365 Business Central Web Client' then you can omit this parameter.
-   RootSite if the web server instance was created as a root-level website.
.PARAMETER ContainerSiteName
Specifies the name of the container website that the SubSite-type web server instance belongs to. This setting is only used if SiteDeploymentType has been set to "SubSite". If the subsite is under the default container website 'Microsoft Dynamics 365 Business Central Web Client' then you can omit this parameter.
.EXAMPLE
Set-NAVWebServerInstanceConfiguration -WebServerInstance DynamicsNAV -KeyName ClientServicesCredentialType -KeyValue NavUserPassword
This example sets the 'ClientServicesCredentialType' configuration setting to 'NavUserNamePassword'.
#>
function Set-NAVWebServerInstanceConfiguration
(
    [Parameter(Mandatory = $true)]
    [string] $WebServerInstance,
    [Parameter(Mandatory = $true)]
    [string] $KeyName,
    [Parameter(Mandatory = $true)]
    [string] $KeyValue,
    [ValidateSet('SubSite', 'RootSite')]
    [string] $SiteDeploymentType = "SubSite",
    [string] $ContainerSiteName
) {
    Import-Module WebAdministration

    $ContainerSiteName = Validate-NavWebContainerSiteName -ContainerSiteName $ContainerSiteName -SiteDeploymentType $SiteDeploymentType

    $iisEntity = Get-NavWebsiteOrApplication -WebServerInstance $WebServerInstance -SiteDeploymentType $SiteDeploymentType -ContainerSiteName $ContainerSiteName
    $physicalPath = $iisEntity.PhysicalPath
    $applicationPool =  $iisEntity.ApplicationPool

    $navSettingFile = Join-Path $physicalPath "navsettings.json"

    if (!(Test-Path -Path $navSettingFile -ErrorAction Stop)) {
        throw "$navSettingFile does not exist"
    }

    $config = Get-Content $navSettingFile -Raw | ConvertFrom-Json

    if ($config.'NAVWebSettings'| get-member -Name $KeyName -MemberType NoteProperty){
        $config.'NAVWebSettings'.$KeyName = $KeyValue
    }
    else {
        $config.'NAVWebSettings'| add-member -Name $KeyName -value $KeyValue -MemberType NoteProperty -Force
    }

    $config | ConvertTo-Json | Set-Content $navSettingFile

    # Manually recycle IIS App pool
    Restart-WebAppPool -Name $applicationPool -ErrorAction Ignore
}

<#
.SYNOPSIS
Gets a specific configuration value for a Business Central web server instance.
.DESCRIPTION
Use this cmdlet to get the value of a setting in the configuration file (navsettings.json) for a web server instance. The settings in the navsettings.json are defined by a key-value pair.
.PARAMETER WebServerInstance
Specifies the name of the web server instance in IIS.
.PARAMETER KeyName
Specifies the configuration key name as it appears in the web server instance’s configuration file.
.PARAMETER SiteDeploymentType
Specifies the deployment type of web server instance. There are two possible values: RootSite and SubSite.
-   Use SubSite if the web server instance was created as a sub-site (web application) to a container website. If you specify SubSite, you will have to set the -ContainerSiteName parameter. If the subsite is under the default container website 'Microsoft Dynamics 365 Business Central Web Client' then you can omit this parameter.
-   RootSite is the web server instance was created as a root-level website.
.PARAMETER ContainerSiteName
Specifies the name of the container website that the SubSite-type web server instance belongs to. This setting is only used if SiteDeploymentType has been set to "SubSite". If the subsite is under the default container website 'Microsoft Dynamics 365 Business Central Web Client' then you can omit this parameter.
.EXAMPLE
Get-NAVWebServerInstanceConfiguration -WebServerInstance DynamicsNAV -KeyName ClientServicesCredentialType
This example reads 'ClientServicesCredentialType' confgiration value.
#>
function Get-NAVWebServerInstanceConfiguration
(
    [Parameter(Mandatory = $true)]
    [string] $WebServerInstance,
    [Parameter(Mandatory = $true)]
    [string] $KeyName,
    [ValidateSet('SubSite', 'RootSite')]
    [string] $SiteDeploymentType = "SubSite",
    [string] $ContainerSiteName
) {
    Import-Module WebAdministration

    $ContainerSiteName = Validate-NavWebContainerSiteName -ContainerSiteName $ContainerSiteName -SiteDeploymentType $SiteDeploymentType

    $iisEntity = Get-NavWebsiteOrApplication -WebServerInstance $WebServerInstance -SiteDeploymentType $SiteDeploymentType -ContainerSiteName $ContainerSiteName
    $physicalPath = $iisEntity.PhysicalPath

    $navSettingFile = Join-Path $physicalPath "navsettings.json"

    if (!(Test-Path -Path $navSettingFile -ErrorAction Stop)) {
        throw "$navSettingFile does not exist"
    }

    $config = Get-Content $navSettingFile -Raw | ConvertFrom-Json
    return $config.'NAVWebSettings'.$KeyName
}

function Get-NavWebsiteOrApplication(
    [Parameter(Mandatory = $true)]
    [string] $WebServerInstance,
    [ValidateSet('SubSite', 'RootSite')]
    [string] $SiteDeploymentType = "SubSite",
    [string] $ContainerSiteName
) {
    if ($SiteDeploymentType -eq "SubSite") {
        $webApplication = Get-WebApplication -Name $WebServerInstance -Site $ContainerSiteName
        return $webApplication
    }
    else {
        $website = Get-Website -Name $WebServerInstance
        return $website
    }
    return $physicalPath;
}

<#
.SYNOPSIS
Removes an existing Microsoft Dynamics 365 Business Central web server instance.

.DESCRIPTION
The Business Central Web, Phone, and Tablet clients use a Business Central web server instance on IIS. Use the Remove-NAVWebServerInstance cmdlet to delete a specific web server instance. The cmdlet deletes all subfolders, web applications, and components that are associated with the web server instance.

.PARAMETER WebServerInstance
Specifies the name of the web server instance in IIS that you want to remove.

.PARAMETER SiteDeploymentType
Specifies the deployment type of web server instance. There are two possible values: SubSite and RootSite.
-   Use SubSite if the web server instance was created as a sub-site (web application) to a container website. If you specify SubSite, you will have to set the -ContainerSiteName parameter. If the subsite is under the default container website 'Microsoft Dynamics 365 Business Central Web Client' then you can omit this parameter.
-   Use RootSite if the web server instance was created as a root-level website. If you use this value, all folders and subsites of the instance will be removed.

.PARAMETER ContainerSiteName
Specifies the name of the container website that the SubSite-type web server instance belongs to. This setting is only used if SiteDeploymentType has been set to "SubSite". If the subsite is under the default container website 'Microsoft Dynamics 365 Business Central Web Client' then you can omit this parameter.

.PARAMETER RemoveContainer
Specifies to remove the container website that the SubSite web server instance belongs to. This will remove all folders and subsites (web applications) of the container website.

.EXAMPLE
Remove-NAVWebServerInstance -WebServerInstance DynamicsNAV -SiteDeploymentType RootSite

This example removes a root-level web server instance.
.EXAMPLE
Remove-NAVWebServerInstance -WebServerInstance DynamicsNAV-AAD

This example removes a web server instance that was created as a SubSite type.
#>
function Remove-NAVWebServerInstance {
    [CmdletBinding(HelpURI = "https://go.microsoft.com/fwlink/?linkid=401381")]
    PARAM
    (
        [Parameter(Mandatory = $true)]
        [string]$WebServerInstance,
        [ValidateSet('SubSite', 'RootSite')]
        [string] $SiteDeploymentType = "SubSite",
        [string] $ContainerSiteName,
        [switch] $RemoveContainer

    )
    Import-Module WebAdministration

    $ContainerSiteName = Validate-NavWebContainerSiteName -ContainerSiteName $ContainerSiteName -SiteDeploymentType $SiteDeploymentType

    if ($SiteDeploymentType -eq "SubSite") {
        $website = Get-WebApplication -Name $WebServerInstance
    }
    else {
        $website = Get-Website -Name $WebServerInstance
    }

    if ($website) {
        $appPool = $website.applicationPool

        Write-Verbose "Remove application pool: $WebServerInstance"
        Remove-WebAppPool -Name $appPool

        Write-Verbose "Remove website: $WebServerInstance"

        if ($SiteDeploymentType -eq "SubSite") {
            Remove-WebApplication -Name $WebServerInstance -Site $ContainerSiteName
            if ($RemoveContainer) {

                $hasExistingWebApps = Get-WebApplication -Site $ContainerSiteName

                if ($hasExistingWebApps) {
                    Write-Warning "'$ContainerSiteName' site will not be removed because it contains other web applications"
                    $RemoveContainer = $false
                }
                else {
                    Remove-Website -Name $ContainerSiteName
                }
            }
        }
        else {
            Remove-Website -Name $WebServerInstance
        }
    }

    $wwwRoot = Get-WWWRootPath
    $siteRootFolder = Join-Path $wwwRoot $WebServerInstance
    if (Test-Path $siteRootFolder -ErrorAction Stop) {
        Write-Verbose "Remove $siteRootFolder"
        Remove-Item $siteRootFolder -Recurse -Force
    }

    if ($RemoveContainer -and ($SiteDeploymentType -eq "SubSite")) {
        $containerFolder = Join-Path $wwwRoot $ContainerSiteName
        Write-Verbose "Remove $containerFolder"
        Remove-Item $containerFolder -Recurse -Force
    }
}

function Validate-NavWebContainerSiteName(
    [string] $ContainerSiteName,
    [string] $SiteDeploymentType = "SubSite"
) {
    $registryProps = Get-NavWebClientInstallationProperties
    if (!$ContainerSiteName -and $SiteDeploymentType -eq "SubSite") {
        if ($registryProps) {
            $ContainerSiteName = $registryProps.Name
            Write-Verbose "Using container name from registry: $ContainerSiteName"
        }
        else {
            $ContainerSiteName = "NavWebApplicationContainer"
            Write-Verbose "Using default container name: $ContainerSiteName"
        }
    }

    return $ContainerSiteName
}

<#
.SYNOPSIS
Creates new a Business Central web server instance.

.DESCRIPTION
Creates a new Business Central web server instance on IIS for hosting the Business Central Web, Phone, and Tablet clients.

To create a new web server instance, you need access to the **WebPublish** folder that contains the content files for serving the Business Central Web Client.
- This folder is available on the Dynamics NAV installation media (DVD) and has the path "DVD\WebClient\Microsoft Dynamics NAV\150\Web Client\WebPublish".
- If you installed the Business Central Web Server Components, this folder has the path "%systemroot%\Program Files\Microsoft Dynamics NAV\[version number]\Web Client\WebPublish".
You can use either of these locations or you can copy the folder to more convenient location on your computer or network.

.PARAMETER WebServerInstance
Specifies the name to assign the web server instance in IIS, such as DynamicsNAV-AAD. If you are creating a SubSite type web server instance, the name will become part of the URL for the Business Central Web client. For example, if you set the parameter to MyNavWeb, the URL would be something like ‘http://myWebServer:8080/MyNavWeb/’.  If you are creating a RootSite type web server instance, the name is only used in IIS and does not become part of the URL. For example, if you set the parameter to MyNavWeb, the URL would be something like ‘http://myWebServer:8080/’.

.PARAMETER Server
Specifies the name of the computer that the Business Central Server instance is installed on. This parameter accepts "localhost" if the server instance and the new web server instance are installed on the same computer.

.PARAMETER ServerInstance
Specifies the name of the Business Central Server instance that the web server instance will connect to. You can specify either the full name of an instance, such as ‘MicrosoftDynamicsNavServer$myinstance-2’, or the short name such as ‘myinstance-2’.

.PARAMETER ClientServicesCredentialType
Specifies the credential type that is used for authenticating client users. The value must match the credential type that is configured for the Business Central Server instance that the web server instance connects to. Possible values include: Windows, UserName, NavUserPassword, or AccessControlService.

.PARAMETER ClientServicesPort
Specifies the TCP port that is configured on the Business Central Server instance for communicating with client services. This value must match the client services port that is configured for the Business Central Server instance that the web server instance connects to.

.PARAMETER ManagementServicesPort
Specifies the TCP port that is configured on the Business Central Server instance for communicating with the management services. This value must match the management services port that is configured for the Business Central Server instance that the web server instance connects to.

.PARAMETER SiteDeploymentType
Specifies how the web server instance is installed IIS regarding its hierarchical structure and relationships. There are two possible values: RootSite and SubSite.

-   RootSite a adds the web server instance as root-level website in IIS that has its own bindings. The URL for the web server has the format: [http://[WebserverComputerName]:[port]/](http://[WebserverComputerName]:[port]/).
-   SubSite adds the web server instance as an application under an existing or new container website, which you specify with the -ContainerSiteName parameter. If you are adding the SubSite instance to a new container website, you will also have to set the -WebSitePort parameter to setup the binding. You can add multiple SubSites to a container website. The SubSites inherit the binding defined on the container website.

If you omit this parameter, a subsite instance will be added to the default container website called 'Microsoft Dynamics 365 Business Central Web Client". If this contianer website does not exist, it will be added.

.PARAMETER ContainerSiteName
Specifies the name the container website to which you want to add the web server instance. This setting is only used if the -SiteDeploymentType parameter is set to ‘SubSite’. If you specify a container name that does not exist, a new site with is created as a container for the new web server instance. The website has no content but has binding on the port that specify with the -WebSitePort parameter.

.PARAMETER WebSitePort
Specifies the TCP port number under which the web server instance will be running. This is the port will be used to access the Business Central Web client and will be part of the URL. This parameter is only used if the -SiteDeploymentType parameter is set to ‘RootSite’ or set to ‘SubSite’ if you are creating a new container website.

.PARAMETER AppPoolName
Specifies the application pool that the web server instance will use. If you do not specify an application pool, the default Business Central Web Client application pool will be used.

.PARAMETER PublishFolder
Specifies the location of the WebPublish folder that contains the content file that is required for Business Central Web client. If you omit this parameter, the cmdlet will look for the folder path '%systemroot%\Program Files\Microsoft Dynamics NAV\[version number]\Web Client\WebPublish'

.PARAMETER DnsIdentity
Specifies the DNS identity of the Business Central Server instance that the web server instance connects to. You set the value to either the Subject or common name (CN) of the security certificate that is used by the Business Central Server instance. This parameter is only relevant when the ClientServicesCredentialType is set to UserName, NavUserPassword, or AccessControlService because these authentication methods require that security certificates are used on the Business Central Server and web server instances o protect communication.

Typically, the Subject is prefixed with "CN" (for common name), for example, "CN = NavServer.com", but it can also just be "NavServer.com". It is also possible for the Subject field to be blank, in which case the validation rules will be applied to the Subject Alternative Name field of the certificate.

.PARAMETER CertificateThumbprint
Specifies the thumbprint of the security certificate to use to configure an HTTPS binding for the web server instance. The certificate must be installed in the local computer certificate store.

.PARAMETER AddFirewallException
Specifies whether to allow inbound communication on the TCP port that is specified by the -WebSitePort parameter. If you use this parameter, an inbound rule for the port will be added to Windows Firewall.

.PARAMETER HelpServer
Specifies the name of computer that hosts the Business Central Help Server that provides online help to Business Central Web client users.

.PARAMETER HelpServerPort
Specifies the TCP port (such as 49000) that is used by the Business Central Help Server on the computer specified by the -HelpServer parameter.

.EXAMPLE
New-NAVWebServerInstance -WebServerInstance DynamicsNAV150-UP -Server localhost -ServerInstance DynamicsNAV150 -ClientServicesCredentialType NavUserPassword

This example adds a new 'SubSite' web server instance under the existing default container website 'Microsoft Dynamics 365 Business Central Web Client'. The new website instance will be configured for NavUserNamePassword authentication.
.EXAMPLE
New-NAVWebServerInstance -WebServerInstance DynamicsNAV-Root -Server localhost -ServerInstance DynamicsNAV150 -SiteDeploymentType RootSite

This example adds a RootSite type web server instance called 'DynamicsNAV-Root'.
.EXAMPLE
New-NAVWebServerInstance -PublishFolder "C:\NAV\WebClient\Microsoft Dynamics NAV\150\Web Client\WebPublish" -WebServerInstance DynamicsNAV150-Root -Server localhost -ServerInstance DynamicsNAV150 -SiteDeploymentType RootSite

This example adds a new RootSite type web server instance from a web publish folder that is located 'C:\NAV\WebClient\Microsoft Dynamics NAV\150\Web Client\WebPublish'.
#>
function New-NAVWebServerInstance {
    [CmdletBinding(HelpURI = "https://go.microsoft.com/fwlink/?linkid=401381")]
    PARAM
    (
        [Parameter(Mandatory = $true)]
        [string]$WebServerInstance,

        [Parameter(Mandatory = $true)]
        [string]$Server,

        [Parameter(Mandatory = $true)]
        [string]$ServerInstance,

        [ValidateSet('Windows', 'UserName', 'NavUserPassword', 'AccessControlService')]
        [string]$ClientServicesCredentialType = "Windows",

        [int]$ClientServicesPort = 7046,

        [int]$ManagementServicesPort = 7045,

        [ValidateSet('SubSite', 'RootSite')]
        [string]$SiteDeploymentType = 'SubSite',

        [string]$ContainerSiteName,

        [int]$WebSitePort,

        [string]$AppPoolName,

        [string]$PublishFolder,

        [string]$DnsIdentity,

        [string]$CertificateThumbprint,

        [switch]$AddFirewallException,

        [string]$HelpServer,

        [int]$HelpServerPort
    )
    $registryProps = Get-NavWebClientInstallationProperties

    # Add default parameter values
    if (!$PublishFolder) {
        if ($registryProps) {
            $PublishFolder = Join-Path $registryProps.Path "WebPublish"
            Write-Verbose "Using publish web folder from registry: $PublishFolder"
        }
    }

    if (!$AppPoolName) {
        $AppPoolName = $WebServerInstance
        Write-Verbose "Using application pool name: $AppPoolName"
    }

    if ($ContainerSiteName -and $SiteDeploymentType -eq "RootSite") {
        throw "ContainerSiteName parameter is only valid when 'SiteDeploymentType' is set to SubSite"
    }


    if (!$ContainerSiteName) {
        if ($registryProps) {
            $ContainerSiteName = $registryProps.Name
            Write-Verbose "Using container name from registry: $ContainerSiteName"
        }
        else {
            $ContainerSiteName = "NavWebApplicationContainer"
            Write-Verbose "Using default container name: $ContainerSiteName"
        }
    }

    if ($WebSitePort -eq 0) {
        if ($CertificateThumbprint) {
            $WebSitePort = 443
        }
        else {
            $WebSitePort = 80
        }

        Write-Verbose "Using default website port: $WebSitePort"
    }

    if (!(Test-Path -Path $PublishFolder -ErrorAction Stop)) {
        throw "$PublishFolder does not exist"
    }

    Import-Module WebAdministration

    # Create the website
    $siteRootFolder = New-NavWebSite -SourcePath $PublishFolder -WebServerInstance $WebServerInstance -ContainerSiteName $ContainerSiteName -SiteDeploymentType $SiteDeploymentType -AppPoolName $AppPoolName  -Port $WebSitePort -CertificateThumbprint $CertificateThumbprint

    # Set the Nav configuration
    Write-Verbose "Update configuration: navsettings.json"

    $navSettingFile = Join-Path $siteRootFolder "navsettings.json"
    if (!(Test-Path $navSettingFile -ErrorAction Stop)) {
        throw "$navSettingFile does not exist"
    }

    $config = Get-Content $navSettingFile -Raw | ConvertFrom-Json
    $config.NAVWebSettings.Server = $Server
    $config.NAVWebSettings.ServerInstance = $ServerInstance
    $config.NAVWebSettings.ClientServicesCredentialType = $ClientServicesCredentialType
    $config.NAVWebSettings.DnsIdentity = $DnsIdentity

    if ($HelpServer) {
        $config.NAVWebSettings.HelpServer = $HelpServer
    }

    if ($HelpServerPort -gt 0) {
        $config.NAVWebSettings.HelpServerPort = $HelpServerPort
    }

    if (!$CertificateThumbprint) {
        # Disable requiring SSL when no SSL thumbprint was specified (insecure)
        $config.NAVWebSettings.RequireSsl = "false"
    }

    $config.NAVWebSettings.ManagementServicesPort = $ManagementServicesPort
    $config.NAVWebSettings.ClientServicesPort = $ClientServicesPort
    $config.NAVWebSettings.UnknownSpnHint = "(net.tcp://${Server}:${ClientServicesPort}/${ServerInstance}/Service)=NoSpn"
    $config | ConvertTo-Json | set-content $navSettingFile

    # Set firewall rule
    if ($AddFirewallException) {
        Set-NavWebFirewallRule -Port $WebSitePort
    }

    Write-Verbose "Done Configuring Web Client"

    # Ignore errors if the site cannot start in cases when e.g. the port is being already used
    Restart-WebAppPool -Name $AppPoolName -ErrorAction Ignore
}

function New-NavWebSite
(
    [string] $SourcePath,
    [string] $WebServerInstance,
    [string] $ContainerSiteName,
    [ValidateSet('SubSite', 'RootSite')]
    [string] $SiteDeploymentType,
    [string] $AppPoolName,
    [string] $Port,
    [string] $CertificateThumbprint
) {
    $wwwRoot = Get-WWWRootPath
    $siteRootFolder = Join-Path $wwwRoot $WebServerInstance

    if (Test-Path $siteRootFolder) {
        Write-Verbose "Remove $siteRootFolder"
        Remove-Item $siteRootFolder -Recurse -Force
    }

    Write-Verbose "Copy files to WWW root $siteRootFolder"
    Copy-Item $SourcePath -Destination $siteRootFolder -Recurse -Container -Force


    Write-Verbose "Create the application pool $AppPoolName"
    if (Test-Path "IIS:\AppPools\$AppPoolName") {
        Write-Verbose "Removing existing application pool $AppPoolName"
        Remove-WebAppPool $AppPoolName
    }

    $appPool = New-WebAppPool -Name $AppPoolName -Force
    $appPool.managedRuntimeVersion = '' # No Managed Code
    $appPool.managedPipelineMode = "Integrated"
    $appPool.startMode = "AlwaysRunning"
    $appPool.enable32BitAppOnWin64 = "false"
    $appPool.recycling.logEventOnRecycle = "Time,Requests,Schedule,Memory,IsapiUnhealthy,OnDemand,ConfigChange,PrivateMemory"
    $appPool.processModel.identityType = "ApplicationPoolIdentity"
    $appPool.processModel.loadUserProfile = "true"
    $appPool.processModel.idleTimeout = "1.00:00:00"
    $appPool | Set-Item

    $user = New-Object System.Security.Principal.NTAccount("IIS APPPOOL\$($appPool.Name)")
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule($user, "ListDirectory, ReadAndExecute, Write, Delete", "ContainerInherit, ObjectInherit", "None", "Allow")

    # Get and Set the same ACL to make sure ACL is in canonical form
    $acl = Get-Acl -Path $siteRootFolder
    Set-Acl -Path $siteRootFolder $acl
    $acl = $null

    $extractedResourcesFolder = Join-Path $siteRootFolder "\wwwroot\Resources\ExtractedResources"
	Create-FolderIfMissing $extractedResourcesFolder
    $acl = Get-Acl -Path $extractedResourcesFolder
    $acl.AddAccessRule($rule)
    Set-Acl -Path $extractedResourcesFolder $acl
    $acl = $null

    $thumbnailsFolder = Join-Path $siteRootFolder "\wwwroot\Thumbnails"
	Create-FolderIfMissing $thumbnailsFolder
    $acl = Get-Acl -Path $thumbnailsFolder
    $acl.AddAccessRule($rule)
    Set-Acl -Path $thumbnailsFolder $acl
    $acl = $null

    $reportsFolder = Join-Path $siteRootFolder "\wwwroot\Reports"
	Create-FolderIfMissing $reportsFolder
    $acl = Get-Acl -Path $reportsFolder
    $acl.AddAccessRule($rule)
    Set-Acl -Path $reportsFolder $acl
    $acl = $null

    if ($SiteDeploymentType -eq "SubSite") {

        # Create NavWebContainer if does not exist
        $containerDirectory = Join-Path $wwwRoot $ContainerSiteName
        New-Item $containerDirectory -type directory -Force | Out-Null

        # Create container website
        $containerSite = Get-Website -Name $ContainerSiteName
        if (!$containerSite) {
            New-NavSiteWithBindings -PhysicalPath $containerDirectory -SiteName $ContainerSiteName -CertificateThumbprint $CertificateThumbprint -Port $Port
        }
        if (Get-WebApplication -Site $ContainerSiteName -Name $WebServerInstance) {
            Remove-WebApplication -Site $ContainerSiteName -Name $WebServerInstance
        }
        New-WebApplication -Site $ContainerSiteName -Name $WebServerInstance -PhysicalPath $siteRootFolder -ApplicationPool $AppPoolName | Out-Null

        Set-NavSiteAuthenticationSettings -SiteLocation "$ContainerSiteName/$WebServerInstance"
    }
    else {
        New-NavSiteWithBindings -PhysicalPath $siteRootFolder -SiteName $WebServerInstance -AppPoolName $AppPoolName -CertificateThumbprint $CertificateThumbprint -Port $Port
        Set-NavSiteAuthenticationSettings -SiteLocation $WebServerInstance
    }

    return $siteRootFolder
}

function Create-FolderIfMissing
(
	[string] $FolderPath
) {
	If (!(Test-Path $FolderPath)) {
		New-Item -ItemType Directory -Force -Path $FolderPath | Out-Null
	}
}

function Set-NavSiteAuthenticationSettings
(
    [string] $SiteLocation
) {
    Set-WebConfigurationProperty -Filter '/system.webServer/security/authentication/windowsAuthentication' -Name enabled -Value true -Location $SiteLocation -Force
    Set-WebConfigurationProperty -Filter '/system.webServer/security/authentication/anonymousAuthentication' -Name enabled -Value true -Location $SiteLocation -Force
}

function New-NavSiteWithBindings
(
    [string] $PhysicalPath,
    [string] $SiteName,
    [string] $CertificateThumbprint,
    [string] $AppPoolName,
    [int] $Port
) {
    # Remove existing site
    Get-WebSite -Name $SiteName | Remove-WebSite

    if ($CertificateThumbprint) {
        Write-Verbose "Create website: $SiteName with SSL"
        New-Website -Name $SiteName -ApplicationPool $AppPoolName -PhysicalPath $PhysicalPath -Port $Port -Ssl | Out-Null
        $binding = Get-WebBinding -Name $SiteName -Protocol "https"
        $binding.AddSslCertificate($CertificateThumbprint, 'My') | Out-Null
    }
    else {
        Write-Verbose "Create website: $SiteName without SSL"
        New-Website -Name $SiteName -ApplicationPool $AppPoolName -PhysicalPath $PhysicalPath -Port $Port | Out-Null
    }
}

function Get-NavWebClientInstallationProperties
() {
    $keyPath = "HKLM:\Software\Microsoft\Microsoft Dynamics NAV\150\Web Client"
    if (Test-Path $keyPath) {
        return Get-ItemProperty -Path $keyPath
    }
}

function Set-NavWebFirewallRule
(
    [int] $Port
) {
    $firewallRule = Get-NetFirewallRule -DisplayName "Microsoft Dynamics NAV Web Client" -ErrorAction Ignore

    if (!$firewallRule) {
        New-NetFirewallRule -DisplayName "Microsoft Dynamics NAV Web Client" -Direction Inbound -LocalPort $Port -Protocol "TCP" -Action Allow -RemoteAddress "any" | Out-Null
        return
    }

    $ports = $firewallRule | Get-NetFirewallPortFilter
    if ($ports.LocalPort -is [array]) {
        if (!($ports.LocalPort -contains $Port)) {
            Set-NetFirewallRule -DisplayName "Microsoft Dynamics NAV Web Client" -LocalPort ($ports.LocalPort + $Port)
        }

        return
    }
    if ($ports.LocalPort -ne $Port) {
        Set-NetFirewallRule -DisplayName "Microsoft Dynamics NAV Web Client" -LocalPort ($ports.LocalPort, $Port)
    }
}

function Get-WWWRootPath {
    $wwwRootPath = (Get-Item "HKLM:\SOFTWARE\Microsoft\InetStp").GetValue("PathWWWRoot")
    $wwwRootPath = [System.Environment]::ExpandEnvironmentVariables($wwwRootPath)

    return $wwwRootPath
}

function Get-NavWebSiteUrl(
    $Website,
    $Application
) {
    $protocol = $Website.Bindings.Collection.protocol
    $port = $Website.Bindings.Collection.bindingInformation -replace ".*\:([\d]+)\:", '$1'

    if ($Application) {
        return "${protocol}://${env:computername}:$port/" + $Application.Path.Trim('/')
    }
    else {
        return "${protocol}://${env:computername}:$port"
    }
}

Export-ModuleMember -Function Get-NAVWebServerInstance, New-NAVWebServerInstance, Remove-NAVWebServerInstance, Set-NAVWebServerInstanceConfiguration, Get-NAVWebServerInstanceConfiguration


# SIG # Begin signature block
# MIIkgAYJKoZIhvcNAQcCoIIkcTCCJG0CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDQVE9jwehOqXdm
# Xb0GFxWgSHgDAJZ7JB8gFf4M4ZoZ5KCCDYUwggYDMIID66ADAgECAhMzAAABUptA
# n1BWmXWIAAAAAAFSMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMTkwNTAyMjEzNzQ2WhcNMjAwNTAyMjEzNzQ2WjB0MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMR4wHAYDVQQDExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQCxp4nT9qfu9O10iJyewYXHlN+WEh79Noor9nhM6enUNbCbhX9vS+8c/3eIVazS
# YnVBTqLzW7xWN1bCcItDbsEzKEE2BswSun7J9xCaLwcGHKFr+qWUlz7hh9RcmjYS
# kOGNybOfrgj3sm0DStoK8ljwEyUVeRfMHx9E/7Ca/OEq2cXBT3L0fVnlEkfal310
# EFCLDo2BrE35NGRjG+/nnZiqKqEh5lWNk33JV8/I0fIcUKrLEmUGrv0CgC7w2cjm
# bBhBIJ+0KzSnSWingXol/3iUdBBy4QQNH767kYGunJeY08RjHMIgjJCdAoEM+2mX
# v1phaV7j+M3dNzZ/cdsz3oDfAgMBAAGjggGCMIIBfjAfBgNVHSUEGDAWBgorBgEE
# AYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQU3f8Aw1sW72WcJ2bo/QSYGzVrRYcw
# VAYDVR0RBE0wS6RJMEcxLTArBgNVBAsTJE1pY3Jvc29mdCBJcmVsYW5kIE9wZXJh
# dGlvbnMgTGltaXRlZDEWMBQGA1UEBRMNMjMwMDEyKzQ1NDEzNjAfBgNVHSMEGDAW
# gBRIbmTlUAXTgqoXNzcitW2oynUClTBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8v
# d3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NybC9NaWNDb2RTaWdQQ0EyMDExXzIw
# MTEtMDctMDguY3JsMGEGCCsGAQUFBwEBBFUwUzBRBggrBgEFBQcwAoZFaHR0cDov
# L3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9jZXJ0cy9NaWNDb2RTaWdQQ0EyMDEx
# XzIwMTEtMDctMDguY3J0MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQELBQADggIB
# AJTwROaHvogXgixWjyjvLfiRgqI2QK8GoG23eqAgNjX7V/WdUWBbs0aIC3k49cd0
# zdq+JJImixcX6UOTpz2LZPFSh23l0/Mo35wG7JXUxgO0U+5drbQht5xoMl1n7/TQ
# 4iKcmAYSAPxTq5lFnoV2+fAeljVA7O43szjs7LR09D0wFHwzZco/iE8Hlakl23ZT
# 7FnB5AfU2hwfv87y3q3a5qFiugSykILpK0/vqnlEVB0KAdQVzYULQ/U4eFEjnis3
# Js9UrAvtIhIs26445Rj3UP6U4GgOjgQonlRA+mDlsh78wFSGbASIvK+fkONUhvj8
# B8ZHNn4TFfnct+a0ZueY4f6aRPxr8beNSUKn7QW/FQmn422bE7KfnqWncsH7vbNh
# G929prVHPsaa7J22i9wyHj7m0oATXJ+YjfyoEAtd5/NyIYaE4Uu0j1EhuYUo5VaJ
# JnMaTER0qX8+/YZRWrFN/heps41XNVjiAawpbAa0fUa3R9RNBjPiBnM0gvNPorM4
# dsV2VJ8GluIQOrJlOvuCrOYDGirGnadOmQ21wPBoGFCWpK56PxzliKsy5NNmAXcE
# x7Qb9vUjY1WlYtrdwOXTpxN4slzIht69BaZlLIjLVWwqIfuNrhHKNDM9K+v7vgrI
# bf7l5/665g0gjQCDCN6Q5sxuttTAEKtJeS/pkpI+DbZ/MIIHejCCBWKgAwIBAgIK
# YQ6Q0gAAAAAAAzANBgkqhkiG9w0BAQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNV
# BAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jv
# c29mdCBDb3Jwb3JhdGlvbjEyMDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlm
# aWNhdGUgQXV0aG9yaXR5IDIwMTEwHhcNMTEwNzA4MjA1OTA5WhcNMjYwNzA4MjEw
# OTA5WjB+MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UE
# BxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSgwJgYD
# VQQDEx9NaWNyb3NvZnQgQ29kZSBTaWduaW5nIFBDQSAyMDExMIICIjANBgkqhkiG
# 9w0BAQEFAAOCAg8AMIICCgKCAgEAq/D6chAcLq3YbqqCEE00uvK2WCGfQhsqa+la
# UKq4BjgaBEm6f8MMHt03a8YS2AvwOMKZBrDIOdUBFDFC04kNeWSHfpRgJGyvnkmc
# 6Whe0t+bU7IKLMOv2akrrnoJr9eWWcpgGgXpZnboMlImEi/nqwhQz7NEt13YxC4D
# dato88tt8zpcoRb0RrrgOGSsbmQ1eKagYw8t00CT+OPeBw3VXHmlSSnnDb6gE3e+
# lD3v++MrWhAfTVYoonpy4BI6t0le2O3tQ5GD2Xuye4Yb2T6xjF3oiU+EGvKhL1nk
# kDstrjNYxbc+/jLTswM9sbKvkjh+0p2ALPVOVpEhNSXDOW5kf1O6nA+tGSOEy/S6
# A4aN91/w0FK/jJSHvMAhdCVfGCi2zCcoOCWYOUo2z3yxkq4cI6epZuxhH2rhKEmd
# X4jiJV3TIUs+UsS1Vz8kA/DRelsv1SPjcF0PUUZ3s/gA4bysAoJf28AVs70b1FVL
# 5zmhD+kjSbwYuER8ReTBw3J64HLnJN+/RpnF78IcV9uDjexNSTCnq47f7Fufr/zd
# sGbiwZeBe+3W7UvnSSmnEyimp31ngOaKYnhfsi+E11ecXL93KCjx7W3DKI8sj0A3
# T8HhhUSJxAlMxdSlQy90lfdu+HggWCwTXWCVmj5PM4TasIgX3p5O9JawvEagbJjS
# 4NaIjAsCAwEAAaOCAe0wggHpMBAGCSsGAQQBgjcVAQQDAgEAMB0GA1UdDgQWBBRI
# bmTlUAXTgqoXNzcitW2oynUClTAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTAL
# BgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBRyLToCMZBD
# uRQFTuHqp8cx0SOJNDBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3JsLm1pY3Jv
# c29mdC5jb20vcGtpL2NybC9wcm9kdWN0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFf
# MDNfMjIuY3JsMF4GCCsGAQUFBwEBBFIwUDBOBggrBgEFBQcwAoZCaHR0cDovL3d3
# dy5taWNyb3NvZnQuY29tL3BraS9jZXJ0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFf
# MDNfMjIuY3J0MIGfBgNVHSAEgZcwgZQwgZEGCSsGAQQBgjcuAzCBgzA/BggrBgEF
# BQcCARYzaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9kb2NzL3ByaW1h
# cnljcHMuaHRtMEAGCCsGAQUFBwICMDQeMiAdAEwAZQBnAGEAbABfAHAAbwBsAGkA
# YwB5AF8AcwB0AGEAdABlAG0AZQBuAHQALiAdMA0GCSqGSIb3DQEBCwUAA4ICAQBn
# 8oalmOBUeRou09h0ZyKbC5YR4WOSmUKWfdJ5DJDBZV8uLD74w3LRbYP+vj/oCso7
# v0epo/Np22O/IjWll11lhJB9i0ZQVdgMknzSGksc8zxCi1LQsP1r4z4HLimb5j0b
# pdS1HXeUOeLpZMlEPXh6I/MTfaaQdION9MsmAkYqwooQu6SpBQyb7Wj6aC6VoCo/
# KmtYSWMfCWluWpiW5IP0wI/zRive/DvQvTXvbiWu5a8n7dDd8w6vmSiXmE0OPQvy
# CInWH8MyGOLwxS3OW560STkKxgrCxq2u5bLZ2xWIUUVYODJxJxp/sfQn+N4sOiBp
# mLJZiWhub6e3dMNABQamASooPoI/E01mC8CzTfXhj38cbxV9Rad25UAqZaPDXVJi
# hsMdYzaXht/a8/jyFqGaJ+HNpZfQ7l1jQeNbB5yHPgZ3BtEGsXUfFL5hYbXw3MYb
# BL7fQccOKO7eZS/sl/ahXJbYANahRr1Z85elCUtIEJmAH9AAKcWxm6U/RXceNcbS
# oqKfenoi+kiVH6v7RyOA9Z74v2u3S5fi63V4GuzqN5l5GEv/1rMjaHXmr/r8i+sL
# gOppO6/8MO0ETI7f33VtY5E90Z1WTk+/gFcioXgRMiF670EKsT/7qMykXcGhiJtX
# cVZOSEXAQsmbdlsKgEhr/Xmfwb1tbWrJUnMTDXpQzTGCFlEwghZNAgEBMIGVMH4x
# CzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRt
# b25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01p
# Y3Jvc29mdCBDb2RlIFNpZ25pbmcgUENBIDIwMTECEzMAAAFSm0CfUFaZdYgAAAAA
# AVIwDQYJYIZIAWUDBAIBBQCggdIwGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQw
# HAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEINX6
# QXS/Zw7cXHjaTcPPT4DlmhvBF8s5ZdVF5P0cmPYQMGYGCisGAQQBgjcCAQwxWDBW
# oDiANgBOAEEAVgBXAGUAYgBDAGwAaQBlAG4AdABNAGEAbgBhAGcAZQBtAGUAbgB0
# AC4AcABzAG0AMaEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20wDQYJKoZIhvcN
# AQEBBQAEggEAMlam4i/0VQpLOvSoqeOjdKXOhXPIvod+EBG061Dp0YWozYfMYoAq
# lqz6x9Lalc1sSVpFUvLDujOKtM+dnRl6+PZNOlm1P83XHl18j64RJN/eRT7O38VO
# Ysc85Z/OHLZV05OoQPkNiclJw/o3ftJUCyAsE6Cwt4KZ+KyT4rdcdw6lf/S6jnAX
# ChqM1KyQMz7hHDxIxTNINPXpXEYxAGhWE2KtfKNx4QdDiE9LhSd4Vq3B92uKcrgc
# C3V1pM9BoKiouUEhnT8hPOKQLyQbRnahJqWjCza3g8v8K27izIPQrmu81fH8Xibv
# gMnll7lLFaDzexOabWyko5o35yXSvC3rsKGCE7cwghOzBgorBgEEAYI3AwMBMYIT
# ozCCE58GCSqGSIb3DQEHAqCCE5AwghOMAgEDMQ8wDQYJYIZIAWUDBAIBBQAwggFY
# BgsqhkiG9w0BCRABBKCCAUcEggFDMIIBPwIBAQYKKwYBBAGEWQoDATAxMA0GCWCG
# SAFlAwQCAQUABCAEMhzux4oAB2eqVTLaNXBXquGe2NVb8WrQFMBpGE1+mwIGXa4l
# 4xfSGBMyMDE5MTEwNjIzMDg1Ni43NTFaMAcCAQGAAgH0oIHUpIHRMIHOMQswCQYD
# VQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEe
# MBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSkwJwYDVQQLEyBNaWNyb3Nv
# ZnQgT3BlcmF0aW9ucyBQdWVydG8gUmljbzEmMCQGA1UECxMdVGhhbGVzIFRTUyBF
# U046QjhFQy0zMEE0LTcxNDQxJTAjBgNVBAMTHE1pY3Jvc29mdCBUaW1lLVN0YW1w
# IFNlcnZpY2Wggg8fMIIGcTCCBFmgAwIBAgIKYQmBKgAAAAAAAjANBgkqhkiG9w0B
# AQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNV
# BAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEyMDAG
# A1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlmaWNhdGUgQXV0aG9yaXR5IDIwMTAw
# HhcNMTAwNzAxMjEzNjU1WhcNMjUwNzAxMjE0NjU1WjB8MQswCQYDVQQGEwJVUzET
# MBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMV
# TWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1T
# dGFtcCBQQ0EgMjAxMDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKkd
# Dbx3EYo6IOz8E5f1+n9plGt0VBDVpQoAgoX77XxoSyxfxcPlYcJ2tz5mK1vwFVMn
# BDEfQRsalR3OCROOfGEwWbEwRA/xYIiEVEMM1024OAizQt2TrNZzMFcmgqNFDdDq
# 9UeBzb8kYDJYYEbyWEeGMoQedGFnkV+BVLHPk0ySwcSmXdFhE24oxhr5hoC732H8
# RsEnHSRnEnIaIYqvS2SJUGKxXf13Hz3wV3WsvYpCTUBR0Q+cBj5nf/VmwAOWRH7v
# 0Ev9buWayrGo8noqCjHw2k4GkbaICDXoeByw6ZnNPOcvRLqn9NxkvaQBwSAJk3jN
# /LzAyURdXhacAQVPIk0CAwEAAaOCAeYwggHiMBAGCSsGAQQBgjcVAQQDAgEAMB0G
# A1UdDgQWBBTVYzpcijGQ80N7fEYbxTNoWoVtVTAZBgkrBgEEAYI3FAIEDB4KAFMA
# dQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAW
# gBTV9lbLj+iiXGJo0T2UkFvXzpoYxDBWBgNVHR8ETzBNMEugSaBHhkVodHRwOi8v
# Y3JsLm1pY3Jvc29mdC5jb20vcGtpL2NybC9wcm9kdWN0cy9NaWNSb29DZXJBdXRf
# MjAxMC0wNi0yMy5jcmwwWgYIKwYBBQUHAQEETjBMMEoGCCsGAQUFBzAChj5odHRw
# Oi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpL2NlcnRzL01pY1Jvb0NlckF1dF8yMDEw
# LTA2LTIzLmNydDCBoAYDVR0gAQH/BIGVMIGSMIGPBgkrBgEEAYI3LgMwgYEwPQYI
# KwYBBQUHAgEWMWh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9QS0kvZG9jcy9DUFMv
# ZGVmYXVsdC5odG0wQAYIKwYBBQUHAgIwNB4yIB0ATABlAGcAYQBsAF8AUABvAGwA
# aQBjAHkAXwBTAHQAYQB0AGUAbQBlAG4AdAAuIB0wDQYJKoZIhvcNAQELBQADggIB
# AAfmiFEN4sbgmD+BcQM9naOhIW+z66bM9TG+zwXiqf76V20ZMLPCxWbJat/15/B4
# vceoniXj+bzta1RXCCtRgkQS+7lTjMz0YBKKdsxAQEGb3FwX/1z5Xhc1mCRWS3Tv
# QhDIr79/xn/yN31aPxzymXlKkVIArzgPF/UveYFl2am1a+THzvbKegBvSzBEJCI8
# z+0DpZaPWSm8tv0E4XCfMkon/VWvL/625Y4zu2JfmttXQOnxzplmkIz/amJ/3cVK
# C5Em4jnsGUpxY517IW3DnKOiPPp/fZZqkHimbdLhnPkd/DjYlPTGpQqWhqS9nhqu
# BEKDuLWAmyI4ILUl5WTs9/S/fmNZJQ96LjlXdqJxqgaKD4kWumGnEcua2A5HmoDF
# 0M2n0O99g/DhO3EJ3110mCIIYdqwUB5vvfHhAN/nMQekkzr3ZUd46PioSKv33nJ+
# YWtvd6mBy6cJrDm77MbL2IK0cs0d9LiFAR6A+xuJKlQ5slvayA1VmXqHczsI5pgt
# 6o3gMy4SKfXAL1QnIffIrE7aKLixqduWsqdCosnPGUFN4Ib5KpqjEWYw07t0Mkvf
# Y3v1mYovG8chr1m1rtxEPJdQcdeh0sVV42neV8HR3jDA/czmTfsNv11P6Z0eGTgv
# vM9YBS7vDaBQNdrvCScc1bN+NR4Iuto229Nfj950iEkSMIIE9TCCA92gAwIBAgIT
# MwAAAP1ELKDxNXIEqQAAAAAA/TANBgkqhkiG9w0BAQsFADB8MQswCQYDVQQGEwJV
# UzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UE
# ChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGlt
# ZS1TdGFtcCBQQ0EgMjAxMDAeFw0xOTA5MDYyMDQxMDdaFw0yMDEyMDQyMDQxMDda
# MIHOMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMH
# UmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSkwJwYDVQQL
# EyBNaWNyb3NvZnQgT3BlcmF0aW9ucyBQdWVydG8gUmljbzEmMCQGA1UECxMdVGhh
# bGVzIFRTUyBFU046QjhFQy0zMEE0LTcxNDQxJTAjBgNVBAMTHE1pY3Jvc29mdCBU
# aW1lLVN0YW1wIFNlcnZpY2UwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQCidDm5ptw5cCJo2b7fyT1SxrI1t6fKkPn0/mFhwax9D6KTVlz2qbEm3dflQIR5
# /R0LJR7nj/IhGmRRcq25HstlKLtXtRwxSP34zyguJXvvWNX1kezDrGBQeHpkRLzK
# aWI54TrSVW6/6+6I0sKmw9GY9AZepkzQMJuwVizj5Y3vnQVsGdEnLvrBzWYz8ijD
# zZjQEcUXL4j2Xs29jjvL7WuNFmSvFdMGDU3Qt9Ixxqppcv3xROlCmYVVRhRbmCiV
# be7eDfgUetkSqoXq0sX1RRDi7EotruSmNfDiYZgrVLXpm0oC1P2zk8P4zRvqodD2
# eiA9xYi/hGofixUB2IeQeojTAgMBAAGjggEbMIIBFzAdBgNVHQ4EFgQUcgA6KpRj
# jklF/AXn0+YebQtMJAIwHwYDVR0jBBgwFoAU1WM6XIoxkPNDe3xGG8UzaFqFbVUw
# VgYDVR0fBE8wTTBLoEmgR4ZFaHR0cDovL2NybC5taWNyb3NvZnQuY29tL3BraS9j
# cmwvcHJvZHVjdHMvTWljVGltU3RhUENBXzIwMTAtMDctMDEuY3JsMFoGCCsGAQUF
# BwEBBE4wTDBKBggrBgEFBQcwAoY+aHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3Br
# aS9jZXJ0cy9NaWNUaW1TdGFQQ0FfMjAxMC0wNy0wMS5jcnQwDAYDVR0TAQH/BAIw
# ADATBgNVHSUEDDAKBggrBgEFBQcDCDANBgkqhkiG9w0BAQsFAAOCAQEAQtF27e/1
# IhgQuoAepcM1mtCzCDPXQ4dS1VSrfBvKGritK7nBY/Hb0A5DJj6lIJgt8s1b0gaG
# rA2q2MHRuX4cHtrb7y+1APPRmf2bZdA8FflpYzX92SyBMiBejzRsTnZnLGskISpX
# OTvOGWVd4oCg6Mci4ukSpD7zJsk46OlLBXEYYgcybixcPzeZa8eTpCqWnyElSKrQ
# vUWJyE1uwzd+WURIgZ92HFZWV5N39YUM7I0NCm2I08vLf9r45uyjNyoDWh60Cv/K
# zMHn5CaDUC62BYQ/e2rFLamzXgQmRZYTa+MM8Da8OXqq5Fg1QrALHQWkh21VBBAU
# LZ9HgjpyIZePp6GCA60wggKVAgEBMIH+oYHUpIHRMIHOMQswCQYDVQQGEwJVUzET
# MBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMV
# TWljcm9zb2Z0IENvcnBvcmF0aW9uMSkwJwYDVQQLEyBNaWNyb3NvZnQgT3BlcmF0
# aW9ucyBQdWVydG8gUmljbzEmMCQGA1UECxMdVGhhbGVzIFRTUyBFU046QjhFQy0z
# MEE0LTcxNDQxJTAjBgNVBAMTHE1pY3Jvc29mdCBUaW1lLVN0YW1wIFNlcnZpY2Wi
# JQoBATAJBgUrDgMCGgUAAxUAookkkDcTSBmVY9a15F2iI/mgjzSggd4wgdukgdgw
# gdUxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdS
# ZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKTAnBgNVBAsT
# IE1pY3Jvc29mdCBPcGVyYXRpb25zIFB1ZXJ0byBSaWNvMScwJQYDVQQLEx5uQ2lw
# aGVyIE5UUyBFU046NERFOS0wQzVFLTNFMDkxKzApBgNVBAMTIk1pY3Jvc29mdCBU
# aW1lIFNvdXJjZSBNYXN0ZXIgQ2xvY2swDQYJKoZIhvcNAQEFBQACBQDhbNBEMCIY
# DzIwMTkxMTA2MDQ1MzI0WhgPMjAxOTExMDcwNDUzMjRaMHQwOgYKKwYBBAGEWQoE
# ATEsMCowCgIFAOFs0EQCAQAwBwIBAAICJhwwBwIBAAICG7AwCgIFAOFuIcQCAQAw
# NgYKKwYBBAGEWQoEAjEoMCYwDAYKKwYBBAGEWQoDAaAKMAgCAQACAxbjYKEKMAgC
# AQACAwehIDANBgkqhkiG9w0BAQUFAAOCAQEAldl0m54lwVpkrrs7jujrt2GjBS03
# 6/YaGVlZZwEyxU/qxzo+xt0DjDW8BUDk6fRCoiUlmr1DMj8tGB6U5lOl7pe5N1jA
# A/R2nXCR1RPgxrv9NnUsAam5B5YVMBqyUWPklV2TPCKr+ujX5MgePe341eS52QCn
# 9PjIdQIVZOww2PWE1FotEexOxBRbLPD1Mz85Bg5+NBE1plr94SErPG28RZKQAqK+
# oHj1w3+/9s8A3XgE7G8qbTi9Ewl1u4tO3o23DRN57FhsuSHw031spSMCMK3bFsLX
# 6HXzSzGYGvRn59e6Et11wS6lhaeGj1XagRV3fCxwcFcQuou/wXDVBCYM4TGCAvUw
# ggLxAgEBMIGTMHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAw
# DgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24x
# JjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwAhMzAAAA/UQs
# oPE1cgSpAAAAAAD9MA0GCWCGSAFlAwQCAQUAoIIBMjAaBgkqhkiG9w0BCQMxDQYL
# KoZIhvcNAQkQAQQwLwYJKoZIhvcNAQkEMSIEIAIwVi6HHWJp+x8cFW2zgYQsT9T+
# Ch+EFvFzjRQ4R0S6MIHiBgsqhkiG9w0BCRACDDGB0jCBzzCBzDCBsQQUookkkDcT
# SBmVY9a15F2iI/mgjzQwgZgwgYCkfjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMK
# V2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0
# IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0Eg
# MjAxMAITMwAAAP1ELKDxNXIEqQAAAAAA/TAWBBS+gVm76PsoXjiEorF4VwqXLNre
# STANBgkqhkiG9w0BAQsFAASCAQCHC9SFM5eVTqgWtE/4CtvJQqkLL6RnvbzrhsOc
# pe1F+tirQe4w5A7DtTwxlBxwj8kF53zMc/y/kVNqXDhReFkMUTA7Ip6jkl10/ag2
# HxOCT0AZFxggcOLdmrmyT08QJEkMuiznYt7/ZKd29d7pLKXx9pknNa4urrlEnQmz
# 55fsCRHhvU4gF85lerdLLdQdxOQBafJNLxexQXNimou32uXDqLpfPzu5Txzd+vV+
# 2LLSZ67dwtFMM6S9Kz5f2fwaIRFTDKk3Th9FlTMKuVXwXJBo/U/aXl4PnRJW0kaN
# jb1OZ+4z70fXEWpITLds5f56Eh7mQlxLbDIJjaayQgzXylQC
# SIG # End signature block
