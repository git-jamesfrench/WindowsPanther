# Packages to remove when installing

$selectors = @(
	'Microsoft.Microsoft3DViewer';
	'Microsoft.BingSearch';
	'Clipchamp.Clipchamp';
	'Microsoft.549981C3F5F10';
	'Microsoft.Windows.DevHome';
	'MicrosoftCorporationII.MicrosoftFamily';
	'Microsoft.WindowsFeedbackHub';
	'Microsoft.GetHelp';
	'Microsoft.Getstarted';
	'microsoft.windowscommunicationsapps';
	'Microsoft.WindowsMaps';
	'Microsoft.MixedReality.Portal';
	'Microsoft.BingNews';
	'Microsoft.MicrosoftOfficeHub';
	'Microsoft.Office.OneNote';
	'Microsoft.OutlookForWindows';
    'Microsoft.OutlookUpdate';
	'Microsoft.Paint';
	'Microsoft.MSPaint';
	'Microsoft.People';
	'Microsoft.PowerAutomateDesktop';
	'MicrosoftCorporationII.QuickAssist';
	'Microsoft.SkypeApp';
	'Microsoft.MicrosoftSolitaireCollection';
	'Microsoft.MicrosoftStickyNotes';
	'MicrosoftTeams';
	'MSTeams';
	'Microsoft.Todos';
	'Microsoft.Wallet';
	'Microsoft.BingWeather';
	'Microsoft.YourPhone';
	'Microsoft.ZuneVideo';
);
$getCommand = {
  Get-AppxProvisionedPackage -Online;
};
$filterCommand = {
  $_.DisplayName -eq $selector;
};
$removeCommand = {
  [CmdletBinding()]
  param(
    [Parameter( Mandatory, ValueFromPipeline )]
    $InputObject
  );
  process {
    $InputObject | Remove-AppxProvisionedPackage -AllUsers -Online -ErrorAction 'Continue';
  }
};
$type = 'Package';
$installed = & $getCommand;
foreach( $selector in $selectors ) {
    $result = [ordered] @{
        Selector = $selector;
    };
    $found = $installed | Where-Object -FilterScript $filterCommand;
    if( $found ) {
        $result.Output = $found | & $removeCommand;
    }
}