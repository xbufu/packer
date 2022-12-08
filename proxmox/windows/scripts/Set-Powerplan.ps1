Try {
  Write-Output "Set power plan to high performance"

  $HighPerf = powercfg -l | %{if($_.contains("High performance")) {$_.split()[3]}}

  # $HighPerf cannot be $null, we try activate this power profile with powercfg
  # 
  if ($HighPerf -eq $null)
  {
    throw "Error: HighPerf is null"
  }

  $CurrPlan = $(powercfg -getactivescheme).split()[3]

  if ($CurrPlan -ne $HighPerf) {powercfg -setactive $HighPerf}

  # Disable screensaver
  Set-ItemProperty "HKCU:\Control Panel\Desktop" -Name ScreenSaveActive -Value 0 -Type DWord
  powercfg -x -monitor-timeout-ac 0
  powercfg -x -monitor-timeout-dc 0

} Catch {
  Write-Warning -Message "Unable to set power plan to high performance"
  Write-Warning $Error[0]
}
