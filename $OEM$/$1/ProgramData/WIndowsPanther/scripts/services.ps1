$selectors = @(
    'Print.Fax.Scan',
    'Language.Handwriting',
    'MathRecognizer',
    'OneCoreUAP.OneSync',
    'Microsoft.Windows.MSPaint',
    'App.Support.QuickAssist',
    'Language.Speech',
    'Language.TextToSpeech',
    'App.StepsRecorder',
    'Microsoft.Windows.WordPad'
);

$getCommand = {
    Get-WindowsCapability -Online | Where-Object { $_.State -notin @('NotPresent', 'Removed') }
};

$filterCommand = {
    param ($selector)
    ($_.Name -split '~')[0] -eq $selector
};

$removeCommand = {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $InputObject
    )
    process {
        $InputObject | Remove-WindowsCapability -Online -ErrorAction 'Continue'
    }
};

$type = 'Capability';
$logfile = 'C:\Windows\Setup\Scripts\RemoveCapabilities.log';

& {
    $installed = & $getCommand;
    foreach ($selector in $selectors) {
        $result = [ordered]@{
            Selector = $selector;
        };
        $found = $installed | Where-Object { & $filterCommand $selector };
        if ($found) {
            $result.Output = $found | & $removeCommand;
            if ($?) {
                $result.Message = "$type removed.";
            } else {
                $result.Message = "$type not removed.";
                $result.Error = $Error[0];
            }
        } else {
            $result.Message = "$type not installed.";
        }
        $result | ConvertTo-Json -Depth 3 -Compress;
    }
} *>&1 >> $logfile;

$selectors = @(
    'Microsoft.Microsoft3DViewer',
    'Microsoft.BingSearch',
    'Clipchamp.Clipchamp',
    'Microsoft.549981C3F5F10',
    'Microsoft.Windows.DevHome',
    'MicrosoftCorporationII.MicrosoftFamily',
    'Microsoft.WindowsFeedbackHub',
    'Microsoft.GetHelp',
    'Microsoft.Getstarted',
    'microsoft.windowscommunicationsapps',
    'Microsoft.WindowsMaps',
    'Microsoft.MixedReality.Portal',
    'Microsoft.BingNews',
    'Microsoft.MicrosoftOfficeHub',
    'Microsoft.Office.OneNote',
    'Microsoft.OutlookForWindows',
    'Microsoft.OutlookUpdate',
    'Microsoft.Paint',
    'Microsoft.MSPaint',
    'Microsoft.People',
    'Microsoft.PowerAutomateDesktop',
    'MicrosoftCorporationII.QuickAssist',
    'Microsoft.SkypeApp',
    'Microsoft.MicrosoftSolitaireCollection',
    'Microsoft.MicrosoftStickyNotes',
    'MicrosoftTeams',
    'MSTeams',
    'Microsoft.Todos',
    'Microsoft.Wallet',
    'Microsoft.BingWeather',
    'Microsoft.YourPhone',
    'Microsoft.ZuneVideo'
);

$getCommand = {
    Get-AppxProvisionedPackage -Online
};

$filterCommand = {
    param ($selector)
    $_.DisplayName -eq $selector
};

$removeCommand = {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $InputObject
    )
    process {
        $InputObject | Remove-AppxProvisionedPackage -AllUsers -Online -ErrorAction 'Continue'
    }
};

$type = 'Package';
$logfile = 'C:\Windows\Setup\Scripts\RemovePackages.log';

& {
    $installed = & $getCommand;
    foreach ($selector in $selectors) {
        $result = [ordered]@{
            Selector = $selector;
        };
        $found = $installed | Where-Object { & $filterCommand $selector };
        if ($found) {
            $result.Output = $found | & $removeCommand;
            if ($?) {
                $result.Message = "$type removed.";
            } else {
                $result.Message = "$type not removed.";
                $result.Error = $Error[0];
            }
        } else {
            $result.Message = "$type not installed.";
        }
        $result | ConvertTo-Json -Depth 3 -Compress;
    }
} *>&1 >> $logfile;

$servicesConfig = @{
    "AJRouter" = "Disabled"
    "ALG" = "Manual"
    "AppIDSvc" = "Manual"
    "AppMgmt" = "Manual"
    "AppReadiness" = "Manual"
    "AppVClient" = "Disabled"
    "AppXSvc" = "Manual"
    "Appinfo" = "Manual"
    "AssignedAccessManagerSvc" = "Disabled"
    "AudioEndpointBuilder" = "Automatic"
    "Audiosrv" = "Automatic"
    "AxInstSV" = "Manual"
    "BDESVC" = "Manual"
    "BFE" = "Automatic"
    "BITS" = "AutomaticDelayedStart"
    "BTAGService" = "Manual"
    "BcastDVRUserService_*" = "Manual"
    "BluetoothUserService_*" = "Manual"
    "BrokerInfrastructure" = "Automatic"
    "Browser" = "Manual"
    "BthAvctpSvc" = "Automatic"
    "BthHFSrv" = "Automatic"
    "CDPSvc" = "Manual"
    "CDPUserSvc_*" = "Automatic"
    "COMSysApp" = "Manual"
    "CaptureService_*" = "Manual"
    "CertPropSvc" = "Manual"
    "ClipSVC" = "Manual"
    "ConsentUxUserSvc_*" = "Manual"
    "CoreMessagingRegistrar" = "Automatic"
    "CredentialEnrollmentManagerUserSvc_*" = "Manual"
    "CryptSvc" = "Automatic"
    "CscService" = "Manual"
    "DPS" = "Automatic"
    "DcomLaunch" = "Automatic"
    "DcpSvc" = "Manual"
    "DevQueryBroker" = "Manual"
    "DeviceAssociationBrokerSvc_*" = "Manual"
    "DeviceAssociationService" = "Manual"
    "DeviceInstall" = "Manual"
    "DevicePickerUserSvc_*" = "Manual"
    "DevicesFlowUserSvc_*" = "Manual"
    "Dhcp" = "Automatic"
    "DiagTrack" = "Disabled"
    "DialogBlockingService" = "Disabled"
    "DispBrokerDesktopSvc" = "Automatic"
    "DisplayEnhancementService" = "Manual"
    "DmEnrollmentSvc" = "Manual"
    "Dnscache" = "Automatic"
    "DoSvc" = "AutomaticDelayedStart"
    "DsSvc" = "Manual"
    "DsmSvc" = "Manual"
    "DusmSvc" = "Automatic"
    "EFS" = "Manual"
    "EapHost" = "Manual"
    "EntAppSvc" = "Manual"
    "EventLog" = "Automatic"
    "EventSystem" = "Automatic"
    "FDResPub" = "Manual"
    "Fax" = "Manual"
    "FontCache" = "Automatic"
    "FrameServer" = "Manual"
    "FrameServerMonitor" = "Manual"
    "GraphicsPerfSvc" = "Manual"
    "HomeGroupListener" = "Manual"
    "HomeGroupProvider" = "Manual"
    "HvHost" = "Manual"
    "IEEtwCollectorService" = "Manual"
    "IKEEXT" = "Manual"
    "InstallService" = "Manual"
    "InventorySvc" = "Manual"
    "IpxlatCfgSvc" = "Manual"
    "KeyIso" = "Automatic"
    "KtmRm" = "Manual"
    "LSM" = "Automatic"
    "LanmanServer" = "Automatic"
    "LanmanWorkstation" = "Automatic"
    "LicenseManager" = "Manual"
    "LxpSvc" = "Manual"
    "MSDTC" = "Manual"
    "MSiSCSI" = "Manual"
    "MapsBroker" = "AutomaticDelayedStart"
    "McpManagementService" = "Manual"
    "MessagingService_*" = "Manual"
    "MicrosoftEdgeElevationService" = "Manual"
    "MixedRealityOpenXRSvc" = "Manual"
    "MpsSvc" = "Automatic"
    "MsKeyboardFilter" = "Manual"
    "NPSMSvc_*" = "Manual"
    "NaturalAuthentication" = "Manual"
    "NcaSvc" = "Manual"
    "NcbService" = "Manual"
    "NcdAutoSetup" = "Manual"
    "NetSetupSvc" = "Manual"
    "NetTcpPortSharing" = "Disabled"
    "Netlogon" = "Automatic"
    "Netman" = "Manual"
    "NgcCtnrSvc" = "Manual"
    "NgcSvc" = "Manual"
    "NlaSvc" = "Manual"
    "OneSyncSvc_*" = "Automatic"
    "P9RdrService_*" = "Manual"
    "PNRPAutoReg" = "Manual"
    "PNRPsvc" = "Manual"
    "PcaSvc" = "Manual"
    "PeerDistSvc" = "Manual"
    "PenService_*" = "Manual"
    "PerfHost" = "Manual"
    "PhoneSvc" = "Manual"
    "PimIndexMaintenanceSvc_*" = "Manual"
    "PlugPlay" = "Manual"
    "PolicyAgent" = "Manual"
    "Power" = "Automatic"
    "PrintNotify" = "Manual"
    "PrintWorkflowUserSvc_*" = "Manual"
    "ProfSvc" = "Automatic"
    "PushToInstall" = "Manual"
    "QWAVE" = "Manual"
    "RasAuto" = "Manual"
    "RasMan" = "Manual"
    "RemoteAccess" = "Disabled"
    "RemoteRegistry" = "Disabled"
    "RetailDemo" = "Manual"
    "RmSvc" = "Manual"
    "RpcEptMapper" = "Automatic"
    "RpcLocator" = "Manual"
    "RpcSs" = "Automatic"
    "SCPolicySvc" = "Manual"
    "SCardSvr" = "Manual"
    "SDRSVC" = "Manual"
    "SEMgrSvc" = "Manual"
    "SENS" = "Automatic"
    "SNMPTRAP" = "Manual"
    "SSDPSRV" = "Manual"
    "SamSs" = "Automatic"
    "ScDeviceEnum" = "Manual"
    "Schedule" = "Automatic"
    "SecurityHealthService" = "Manual"
    "Sense" = "Manual"
    "SensorDataService" = "Manual"
    "SensorService" = "Manual"
    "SensrSvc" = "Manual"
    "SessionEnv" = "Manual"
    "SgrmBroker" = "Automatic"
    "SharedAccess" = "Manual"
    "SharedRealitySvc" = "Manual"
    "ShellHWDetection" = "Automatic"
    "SmsRouter" = "Manual"
    "Spooler" = "Automatic"
    "SstpSvc" = "Manual"
    "StateRepository" = "Manual"
    "StiSvc" = "Manual"
    "StorSvc" = "Manual"
    "SysMain" = "Automatic"
    "SystemEventsBroker" = "Automatic"
    "TabletInputService" = "Manual"
    "TapiSrv" = "Manual"
    "TermService" = "Automatic"
    "TextInputManagementService" = "Manual"
    "Themes" = "Automatic"
    "TieringEngineService" = "Manual"
    "TimeBroker" = "Manual"
    "TimeBrokerSvc" = "Manual"
    "TokenBroker" = "Manual"
    "TrkWks" = "Automatic"
    "TroubleshootingSvc" = "Manual"
    "TrustedInstaller" = "Manual"
    "UI0Detect" = "Manual"
    "UdkUserSvc_*" = "Manual"
    "UevAgentService" = "Disabled"
    "UmRdpService" = "Manual"
    "UnistoreSvc_*" = "Manual"
    "UserDataSvc_*" = "Manual"
    "UserManager" = "Automatic"
    "UsoSvc" = "Manual"
    "VGAuthService" = "Automatic"
    "VMTools" = "Automatic"
    "VSS" = "Manual"
    "VacSvc" = "Manual"
    "VaultSvc" = "Automatic"
    "W32Time" = "Manual"
    "WEPHOSTSVC" = "Manual"
    "WFDSConMgrSvc" = "Manual"
    "WMPNetworkSvc" = "Manual"
    "WManSvc" = "Manual"
    "WPDBusEnum" = "Manual"
    "WSService" = "Manual"
    "WSearch" = "AutomaticDelayedStart"
    "WaaSMedicSvc" = "Manual"
    "WalletService" = "Manual"
    "WarpJITSvc" = "Manual"
    "WbioSrvc" = "Manual"
    "Wcmsvc" = "Automatic"
    "WcsPlugInService" = "Manual"
    "WdNisSvc" = "Manual"
    "WdiServiceHost" = "Manual"
    "WdiSystemHost" = "Manual"
    "WebClient" = "Manual"
    "Wecsvc" = "Manual"
    "WerSvc" = "Manual"
    "WiaRpc" = "Manual"
    "WinDefend" = "Automatic"
    "WinHttpAutoProxySvc" = "Manual"
    "WinRM" = "Manual"
    "Winmgmt" = "Automatic"
    "WlanSvc" = "Automatic"
    "WpcMonSvc" = "Manual"
    "WpnService" = "Manual"
    "WpnUserService_*" = "Automatic"
    "XblAuthManager" = "Manual"
    "XblGameSave" = "Manual"
    "XboxGipSvc" = "Manual"
    "XboxNetApiSvc" = "Manual"
    "autotimesvc" = "Manual"
    "bthserv" = "Manual"
    "camsvc" = "Manual"
    "cbdhsvc_*" = "Manual"
    "cloudidsvc" = "Manual"
    "dcsvc" = "Manual"
    "defragsvc" = "Manual"
    "diagnosticshub.standardcollector.service" = "Manual"
    "diagsvc" = "Manual"
    "dmwappushservice" = "Manual"
    "dot3svc" = "Manual"
    "edgeupdate" = "Manual"
    "edgeupdatem" = "Manual"
    "embeddedmode" = "Manual"
    "fdPHost" = "Manual"
    "fhsvc" = "Manual"
    "gpsvc" = "Automatic"
    "hidserv" = "Manual"
    "icssvc" = "Manual"
    "iphlpsvc" = "Automatic"
    "lfsvc" = "Manual"
    "lltdsvc" = "Manual"
    "lmhosts" = "Manual"
    "msiserver" = "Manual"
    "netprofm" = "Manual"
    "nsi" = "Automatic"
    "p2pimsvc" = "Manual"
    "p2psvc" = "Manual"
    "perceptionsimulation" = "Manual"
    "pla" = "Manual"
    "seclogon" = "Manual"
    "shpamsvc" = "Disabled"
    "smphost" = "Manual"
    "spectrum" = "Manual"
    "sppsvc" = "AutomaticDelayedStart"
    "ssh-agent" = "Disabled"
    "svsvc" = "Manual"
    "swprv" = "Manual"
    "tiledatamodelsvc" = "Automatic"
    "tzautoupdate" = "Disabled"
    "uhssvc" = "Disabled"
    "upnphost" = "Manual"
    "vds" = "Manual"
    "vm3dservice" = "Manual"
    "vmicguestinterface" = "Manual"
    "vmicheartbeat" = "Manual"
    "vmickvpexchange" = "Manual"
    "vmicrdv" = "Manual"
    "vmicshutdown" = "Manual"
    "vmictimesync" = "Manual"
    "vmicvmsession" = "Manual"
    "vmicvss" = "Manual"
    "vmvss" = "Manual"
    "wbengine" = "Manual"
    "wcncsvc" = "Manual"
    "webthreatdefsvc" = "Manual"
    "webthreatdefusersvc_*" = "Automatic"
    "wercplsupport" = "Manual"
    "wisvc" = "Manual"
    "wlidsvc" = "Manual"
    "wlpasvc" = "Manual"
    "wmiApSrv" = "Manual"
    "workfolderssvc" = "Manual"
    "wscsvc" = "AutomaticDelayedStart"
    "wuauserv" = "Manual"
    "wudfsvc" = "Manual"
}

foreach ($servicePattern in $servicesConfig.Keys) {
    $startupType = $servicesConfig[$servicePattern]

    # Find services matching the pattern (wildcards allowed)
    $matchingServices = Get-Service -Name $servicePattern -ErrorAction SilentlyContinue

    if ($matchingServices) {
        foreach ($service in $matchingServices) {
            # Adjust for 'AutomaticDelayedStart'
            if ($startupType -eq "AutomaticDelayedStart") {
                Set-Service -Name $service.Name -StartupType Automatic
                sc.exe config $service.Name start= delayed-auto | Out-Null
            } else {
                Set-Service -Name $service.Name -StartupType $startupType
            }

            Write-Host "Successfully set $($service.Name) to $startupType."
        }
    } else {
        Write-Warning "No services found matching the pattern: $servicePattern."
    }
}

$selectors = @(
    'Recall'
);

$getCommand = {
    Get-WindowsOptionalFeature -Online | Where-Object { $_.State -notin @('Disabled', 'DisabledWithPayloadRemoved') }
};

$filterCommand = {
    param ($selector)
    $_.FeatureName -eq $selector
};

$removeCommand = {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $InputObject
    )
    process {
        $InputObject | Disable-WindowsOptionalFeature -Online -Remove -NoRestart -ErrorAction 'Continue'
    }
};

$type = 'Feature';
$logfile = 'C:\Windows\Setup\Scripts\RemoveFeatures.log';

& {
    $installed = & $getCommand;
    foreach ($selector in $selectors) {
        $result = [ordered]@{
            Selector = $selector;
        };
        $found = $installed | Where-Object { & $filterCommand $selector };
        if ($found) {
            $result.Output = $found | & $removeCommand;
            if ($?) {
                $result.Message = "$type removed.";
            } else {
                $result.Message = "$type not removed.";
                $result.Error = $Error[0];
            }
        } else {
            $result.Message = "$type not installed.";
        }
        $result | ConvertTo-Json -Depth 3 -Compress;
    }
} *>&1 >> $logfile;
