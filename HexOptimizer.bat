@echo off
setlocal EnableExtensions EnableDelayedExpansion
cls
chcp 65001 >nul
title Hex+ Optimizer V1.1

for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"

mode con: cols=95 lines=32

set "C=!ESC![38;2;0;220;180m"
set "P=!ESC![38;2;255;60;120m"
set "Y=!ESC![38;2;255;200;50m"
set "W=!ESC![38;2;230;230;240m"
set "G=!ESC![38;2;80;80;90m"
set "R=!ESC![0m"

set "RESET=!R!"

fltmc >nul 2>&1
if errorlevel 1 (
    set "SELF=%~f0"
    set "SELF=!SELF:'=''!"
    echo.
    echo !P!  Administrator rights required - requesting elevation...!R!
    powershell -NoProfile -Command "Start-Process -FilePath '!SELF!' -Verb RunAs" >nul 2>&1
    if errorlevel 1 (
        echo !P!  Elevation failed or was cancelled. Right click the file and run it as Administrator.!R!
        pause >nul
    )
    exit /b
)

goto menu

:show_logo
cls
echo.
echo.
echo !R!!ESC![38;2;255;140;0m          ██╗  ██╗███████╗██╗  ██╗    ██╗      !RESET!
echo !ESC![38;2;255;155;0m          ██║  ██║██╔════╝╚██╗██╔╝    ██║      !RESET!
echo !ESC![38;2;255;170;0m          ███████║█████╗   ╚███╔╝ ██████████╗ !RESET!
echo !ESC![38;2;255;185;0m          ██╔══██║██╔══╝   ██╔██╗ ╚═══██╔═══╝ !RESET!
echo !ESC![38;2;255;200;0m          ██║  ██║███████╗██╔╝ ██╗    ██║      !RESET!
echo !ESC![38;2;255;215;0m          ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝    ╚═╝      !RESET!
echo.
echo !ESC![38;2;255;215;0m   ██████╗ ██████╗ ████████╗██╗███╗   ███╗██╗███████╗███████╗██████╗ !RESET!
echo !ESC![38;2;255;200;0m  ██╔═══██╗██╔══██╗╚══██╔══╝██║████╗ ████║██║╚════██║██╔════╝██╔══██╗!RESET!
echo !ESC![38;2;255;185;0m  ██║   ██║██████╔╝   ██║   ██║██╔████╔██║██║  ███╔═╝█████╗  ██████╔╝!RESET!
echo !ESC![38;2;255;170;0m  ██║   ██║██╔═══╝    ██║   ██║██║╚██╔╝██║██║ ██╔══╝ ██╔══╝  ██╔══██╗!RESET!
echo !ESC![38;2;255;155;0m  ╚██████╔╝██║        ██║   ██║██║ ╚═╝ ██║██║███████╗███████╗██║  ██║!RESET!
echo !ESC![38;2;255;140;0m   ╚═════╝ ╚═╝        ╚═╝   ╚═╝╚═╝     ╚═╝╚═╝╚══════╝╚══════╝╚═╝  ╚═╝!RESET!
echo.
echo !ESC![38;2;120;220;200m                    made by @wylziz!RESET!
echo.
exit /b 0

:menu
set "DISABLE_STORE="
set "DISABLE_WU="
set "DISABLE_WIFI="
set "EXTRA_AGGR="
call :show_logo
echo !G!  -----------------------------------------------------------!R!
echo !W!   MAIN CONSOLE!R!                        Fuck Paid Optimizers
echo !G!  -----------------------------------------------------------!R!
echo.
echo !Y!   [1]!W!  Start optimization sequence!R!
echo !Y!   [0]!W!  Abort and exit!R!
echo.
set "opt="
set /p "opt=!C!  > !R!"
if "!opt!"=="0" goto exit_app
if "!opt!"=="1" goto config_store
goto menu

:exit_app
echo.
echo !P!  Session closed.!R!
timeout /t 2 >nul
exit /b 0

:config_store
call :show_logo
echo !P!  --------------------------------------------------------------!R!
echo !P!   STORE MODULE!R!
echo !P!  --------------------------------------------------------------!R!
echo.
echo   Remove Microsoft Store access?
echo.
echo !Y!   [1]!W!  Yes - lock it down!R!
echo !Y!   [2]!W!  No  - leave it alone!R!
echo.
set "opt="
set /p "opt=!C!  choice > !R!"
if "!opt!"=="1" (
    set "DISABLE_STORE=1"
    goto config_wu
)
if "!opt!"=="2" (
    set "DISABLE_STORE=0"
    goto config_wu
)
if /i "!opt!"=="y" (
    set "DISABLE_STORE=1"
    goto config_wu
)
if /i "!opt!"=="n" (
    set "DISABLE_STORE=0"
    goto config_wu
)
goto config_store

:config_wu
call :show_logo
echo !P!  --------------------------------------------------------------!R!
echo !P!   UPDATE MODULE!R!
echo !P!  --------------------------------------------------------------!R!
echo.
echo   Kill Windows Update services?
echo.
echo !Y!   [1]!W!  Yes - full lockdown!R!
echo !Y!   [2]!W!  No  - keep them running!R!
echo.
set "opt="
set /p "opt=!C!  choice > !R!"
if "!opt!"=="1" (
    set "DISABLE_WU=1"
    goto config_network
)
if "!opt!"=="2" (
    set "DISABLE_WU=0"
    goto config_network
)
if /i "!opt!"=="y" (
    set "DISABLE_WU=1"
    goto config_network
)
if /i "!opt!"=="n" (
    set "DISABLE_WU=0"
    goto config_network
)
goto config_wu

:config_network
call :show_logo
echo !P!  --------------------------------------------------------------!R!
echo !P!   NETWORK MODULE!R!
echo !P!  --------------------------------------------------------------!R!
echo.
echo   Connection type?
echo.
echo !Y!   [1]!W!  Ethernet - disable WiFi service!R!
echo !Y!   [2]!W!  WiFi     - keep WiFi service active!R!
echo.
set "opt="
set /p "opt=!C!  choice > !R!"
if "!opt!"=="1" (
    set "DISABLE_WIFI=1"
    goto config_extra
)
if "!opt!"=="2" (
    set "DISABLE_WIFI=0"
    goto config_extra
)
goto config_network

:config_extra
call :show_logo
echo !P!  --------------------------------------------------------------!R!
echo !P!   AGGRESSIVE MODULE!R!
echo !P!  --------------------------------------------------------------!R!
echo.
echo   Extra tweaks: disable UAC, Base Filtering Engine
echo   [firewall], SamSs, Netman and the NVIDIA containers?
echo   !Y!Can break the firewall, Network Connections UI and the NVIDIA app.!R!
echo.
echo !Y!   [1]!W!  Yes - apply them!R!
echo !Y!   [2]!W!  No  - skip them!R!
echo.
set "opt="
set /p "opt=!C!  choice > !R!"
if "!opt!"=="1" (
    set "EXTRA_AGGR=1"
    goto run_tweak
)
if "!opt!"=="2" (
    set "EXTRA_AGGR=0"
    goto run_tweak
)
if /i "!opt!"=="y" (
    set "EXTRA_AGGR=1"
    goto run_tweak
)
if /i "!opt!"=="n" (
    set "EXTRA_AGGR=0"
    goto run_tweak
)
goto config_extra

:run_tweak
if not defined DISABLE_STORE set "DISABLE_STORE=1"
if not defined DISABLE_WU set "DISABLE_WU=1"
if not defined DISABLE_WIFI set "DISABLE_WIFI=0"
if not defined EXTRA_AGGR set "EXTRA_AGGR=0"
call :show_logo
echo !P!  --------------------------------------------------------------!R!
echo !P!   FINAL CHECK!R!
echo !P!  --------------------------------------------------------------!R!
echo.
if "!DISABLE_STORE!"=="1" echo   Store access     : !Y!LOCKED!R!
if "!DISABLE_STORE!"=="0" echo   Store access     : !Y!OPEN!R!
if "!DISABLE_WU!"=="1"    echo   Windows Update   : !Y!LOCKED!R!
if "!DISABLE_WU!"=="0"    echo   Windows Update   : !Y!OPEN!R!
if "!DISABLE_WIFI!"=="1"  echo   WiFi service     : !Y!DISABLED!R!
if "!DISABLE_WIFI!"=="0"  echo   WiFi service     : !Y!ACTIVE!R!
if "!EXTRA_AGGR!"=="1"    echo   Aggressive mod.  : !Y!ON!R!
if "!EXTRA_AGGR!"=="0"    echo   Aggressive mod.  : !Y!OFF!R!
echo.
echo !C!  Sequence starts in 5 seconds...!R!
timeout /t 5 >nul
echo.

echo Decompressing operating system (CompactOS: never)...
compact /compactos:never >nul 2>&1

reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d 0 /f >nul 2>&1
sc config VSS start= demand >nul 2>&1
sc start VSS >nul 2>&1
sc config swprv start= demand >nul 2>&1
sc start swprv >nul 2>&1
echo Creating restore point...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Enable-ComputerRestore -Drive ($env:SystemDrive + '\')" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description 'Hex+ Optimizer' -RestorePointType 'MODIFY_SETTINGS'" >nul 2>&1
set "HEX_KEYS_BACKUP=%USERPROFILE%\Desktop\hexplus_backup_keys"
mkdir "%HEX_KEYS_BACKUP%" >nul 2>&1
>> "%HEX_KEYS_BACKUP%\hexplus_log.txt" echo started %date% %time% store=!DISABLE_STORE! update=!DISABLE_WU! wifi=!DISABLE_WIFI! aggressive=!EXTRA_AGGR!
reg export "HKLM\SYSTEM\CurrentControlSet\Services" "%HEX_KEYS_BACKUP%\hklm_services.reg" /y >nul 2>&1
reg export "HKLM\SYSTEM\CurrentControlSet\Control" "%HEX_KEYS_BACKUP%\hklm_control.reg" /y >nul 2>&1
reg export "HKLM\SOFTWARE\Policies" "%HEX_KEYS_BACKUP%\hklm_policies.reg" /y >nul 2>&1
reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" "%HEX_KEYS_BACKUP%\hklm_currentversion.reg" /y >nul 2>&1
reg export "HKCU\Software\Microsoft\Windows\CurrentVersion" "%HEX_KEYS_BACKUP%\hkcu_currentversion.reg" /y >nul 2>&1
reg export "HKCU\Control Panel" "%HEX_KEYS_BACKUP%\hkcu_controlpanel.reg" /y >nul 2>&1
bcdedit /export "%HEX_KEYS_BACKUP%\bcd_backup" >nul 2>&1
for /f "tokens=2 delims=:(" %%G in ('powercfg /getactivescheme') do for %%H in (%%G) do powercfg /export "%HEX_KEYS_BACKUP%\power_scheme.pow" %%H >nul 2>&1
powershell -NoProfile -Command "Get-CimInstance Win32_Service | Select-Object Name,StartMode,State | Export-Csv -NoTypeInformation -Path '%HEX_KEYS_BACKUP%\services_before.csv'" >nul 2>&1
netsh int tcp show global > "%HEX_KEYS_BACKUP%\tcp_global_before.txt" 2>&1
echo @echo off> "%HEX_KEYS_BACKUP%\restore_keys.bat"
echo for %%%%F in ^("%%~dp0*.reg"^) do reg import "%%%%F">> "%HEX_KEYS_BACKUP%\restore_keys.bat"
echo pause>> "%HEX_KEYS_BACKUP%\restore_keys.bat"
reg export HKLM "%USERPROFILE%\Desktop\hexplus_backup.reg" /y >nul 2>&1

set "HEX_LAPTOP=0"
for /f %%B in ('powershell -NoProfile -Command "if (Get-CimInstance Win32_Battery -ErrorAction SilentlyContinue) { 1 } else { 0 }" 2^>nul') do set "HEX_LAPTOP=%%B"
if "!HEX_LAPTOP!"=="0" (
    for /f %%G in ('powershell -NoProfile -Command "$o = powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61; if ($o -match '([0-9a-fA-F]{8}(-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12})') { $Matches[1] }" 2^>nul') do (
        powercfg /changename %%G "Hex+" "Hex+ Ultimate Performance - tuned for maximum FPS and lowest latency: no CPU throttling, no core parking, no power saving." >nul 2>&1
        powercfg /setactive %%G >nul 2>&1
    )
)

set "MM=HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"
set "PREFETCH=%MM%\PrefetchParameters"
set "IOSYS=HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System"
set "FS=HKLM\SYSTEM\CurrentControlSet\Control\FileSystem"
set "DWM=HKLM\SOFTWARE\Microsoft\Windows\DWM"
set "GD=HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers"
set "GDS=%GD%\Scheduler"
set "GDMM=%GD%\MemoryManagement"
set "GDPOWER=%GD%\Power"
set "POWER=HKLM\SYSTEM\CurrentControlSet\Control\Power"
set "GFX_CLASS=HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}"
set "GPU_CLASS_KEY=%GFX_CLASS%"

bcdedit /deletevalue useplatformclock >nul 2>&1
bcdedit /set x2apicpolicy enable >nul 2>&1
bcdedit /set configaccesspolicy default >nul 2>&1
bcdedit /set bootmenupolicy standard >nul 2>&1
bcdedit /set ems off >nul 2>&1
bcdedit /set tscsyncpolicy enhanced >nul 2>&1
powercfg -h off >nul 2>&1

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1

reg add "%MM%" /v "LargeSystemCache" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%MM%" /v "DisablePagingExecutive" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "ZeroPageThreadPriority" /t REG_DWORD /d 31 /f >nul 2>&1
reg add "%MM%" /v "MemoryManagementPriority" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "DisableMemoryThrottling" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "DisablePageSplitting" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "DisableMemoryScrubbing" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "PoolUsageMaximum" /t REG_DWORD /d 60 /f >nul 2>&1
reg add "%MM%" /v "MoveImages" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%MM%" /v "FeatureSettings" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "ClearPageFileAtShutdown" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%MM%" /v "SessionViewSize" /t REG_DWORD /d 192 /f >nul 2>&1
reg add "%MM%" /v "SessionPoolSize" /t REG_DWORD /d 128 /f >nul 2>&1
reg add "%MM%" /v "SystemViewSize" /t REG_DWORD /d 24576 /f >nul 2>&1
reg add "%MM%" /v "EnforceWriteProtection" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "TrimWorkingSet" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%MM%" /v "WriteWatch" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%MM%" /v "MapTransferCount" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%MM%" /v "DisablePagingOfKernelStacks" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "DisablePoolTagging" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "SystemCacheReserve" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "LargePageAlways" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "DisableBackgroundScavenging" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "FeatureSettingsOverride" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "%MM%" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "%MM%" /v "PoolAllocationPriority" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "MemoryPriority" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "NonPagedPoolMaximum" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%MM%" /v "DisableMemoryCompression" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "EnablePageCombining" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%MM%" /v "DisablePageCombining" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "NumaNodeSelectionPolicy" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "DramPowerManagement" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%MM%" /v "DisableDriverPaging" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "PrioritizeForegroundApplications" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "DisableWorkingSetAging" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "DisableKernelStackPaging" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "LargePageMinimum" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%MM%" /v "NonPagedPoolSize" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%MM%" /v "SystemCacheDirtyPageThreshold" /t REG_DWORD /d 81920 /f >nul 2>&1
reg add "%MM%" /v "AvoidLargePageCollisions" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "PhysicalAddressExtension" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "NonPagedPoolQuota" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%MM%" /v "PagedPoolQuota" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%MM%" /v "FirstLevelDataCache" /t REG_DWORD /d 65536 /f >nul 2>&1
reg add "%MM%" /v "PhysicalMemoryAllocationPolicy" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%MM%" /v "EnableCfg" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%MM%" /v "HotPatch" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%MM%" /v "McGlobalShortBankQueueDepth" /t REG_DWORD /d 16 /f >nul 2>&1
reg add "%MM%" /v "McBankQueueDepth" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "%MM%" /v "McMaxChannelCount" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "%MM%" /v "DisableMemoryPatrolScrub" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "NumaCrossNodeAccess" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "%MM%" /v "SharedUserData" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "MappedCommitLimit" /t REG_DWORD /d 0xFFFFFFFF /f >nul 2>&1
reg add "%MM%" /v "CommitLimit" /t REG_DWORD /d 0xFFFFFFFF /f >nul 2>&1
reg add "%MM%" /v "IoModification" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%MM%" /v "GameModeCacheSize" /t REG_DWORD /d 1073741824 /f >nul 2>&1
reg add "%MM%" /v "GameModeEnabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%MM%" /v "GameModeCachePriority" /t REG_DWORD /d 15 /f >nul 2>&1

reg add "%PREFETCH%" /v "EnablePrefetcher" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%PREFETCH%" /v "EnableSuperfetch" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%PREFETCH%" /v "SfTracingState" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%PREFETCH%" /v "EnableBootTrace" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%PREFETCH%" /v "EnableReadAhead" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%PREFETCH%" /v "EnableSeekAhead" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%PREFETCH%" /v "MaxReadAheadSize" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%PREFETCH%" /v "PrefetchAttempts" /t REG_DWORD /d 0 /f >nul 2>&1
powershell -NoProfile -Command "Disable-MMAgent -MemoryCompression -PageCombining" >nul 2>&1

reg add "%IOSYS%" /v "EnableIoRing" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%IOSYS%" /v "IoRingMaxSubmitQueueSize" /t REG_DWORD /d 65536 /f >nul 2>&1
reg add "%IOSYS%" /v "CountOperations" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%IOSYS%" /v "InterruptSteeringDisabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%IOSYS%" /v "BypassIosEnable" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%IOSYS%" /v "DisableLookAside" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%IOSYS%" /v "IoPriorityHint" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "%IOSYS%" /v "IoNoWorkQueue" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%IOSYS%" /v "DisableIoBuffering" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%IOSYS%" /v "DisableThreadLibraryCalls" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%IOSYS%" /v "OptimizationFlags" /t REG_DWORD /d 0x400000 /f >nul 2>&1
reg add "%IOSYS%" /v "IoReadOperationLimit" /t REG_DWORD /d 65536 /f >nul 2>&1
reg add "%IOSYS%" /v "IoWriteOperationLimit" /t REG_DWORD /d 65536 /f >nul 2>&1
reg add "%IOSYS%" /v "IoOtherOperationLimit" /t REG_DWORD /d 65536 /f >nul 2>&1
reg add "%IOSYS%" /v "IOMaximumLength" /t REG_DWORD /d 1048576 /f >nul 2>&1
reg add "%IOSYS%" /v "IOMatchDeadline" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Storage" /v "DisableDeleteNotification" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Storage" /v "ZeroPoweredNTDisks" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Storage" /v "ShortStreakQueuing" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Disk" /v "EnableCache" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\disk\Parameters" /v "TimeOutValue" /t REG_DWORD /d 180 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "DisableWriteCacheBufferFlush" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "InterruptPriority" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "DpcIsolation" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "BypassIoEnable" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "IdlePowerMode" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "DisableIdlePowerManagement" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "MessageNumberLimit" /t REG_DWORD /d 2048 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "NvmeCommandTimeout" /t REG_DWORD /d 300 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "NvmeMaxIoConcurrency" /t REG_DWORD /d 128 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Interrupt Management\Affinity Policy" /v "DeviceExecutionMode" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d 31 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSIXSupported" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storport\Parameters" /v "MaximumTransferLength" /t REG_DWORD /d 4294967295 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storport\Parameters" /v "NumberOfRequests" /t REG_DWORD /d 512 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storport\Parameters" /v "ThreadPriority" /t REG_DWORD /d 31 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storport\Parameters" /v "InterruptPriority" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storport\Parameters" /v "DpcIsolation" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storport\Parameters" /v "DisableIdleTimeout" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TSFairShare\Disk" /v "EnableFairShare" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TSFairShare\NetFS" /v "EnableFairShare" /t REG_DWORD /d 0 /f >nul 2>&1
fsutil behavior set disablelastaccess 1 >nul 2>&1
fsutil behavior set disable8dot3 1 >nul 2>&1
fsutil behavior set mftzone 4 >nul 2>&1
fsutil behavior set encryptpagingfile 0 >nul 2>&1
fsutil behavior set disablecompression 1 >nul 2>&1
fsutil behavior set disableencryption 1 >nul 2>&1
fsutil behavior set memoryusage 2 >nul 2>&1

reg add "%FS%" /v "NtfsDisableLastAccessUpdate" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%FS%" /v "NtfsMftZoneReservation" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "%FS%" /v "NtfsDisable8dot3NameCreation" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%FS%" /v "NtfsMemoryUsage" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "%FS%" /v "ContigFileAllocSize" /t REG_DWORD /d 64 /f >nul 2>&1
reg add "%FS%" /v "NtfsDisableEncryption" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%FS%" /v "MaximumTunnelEntries" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%FS%" /v "MaximumTunnelEntryAgeInSeconds" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%FS%" /v "NameCache" /t REG_DWORD /d 512 /f >nul 2>&1
reg add "%FS%" /v "PathCache" /t REG_DWORD /d 128 /f >nul 2>&1
reg add "%FS%" /v "LongPathsEnabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%FS%" /v "RefsDisableLastAccessUpdate" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%FS%" /v "NtfsDisableCompression" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%FS%" /v "NtfsAllowExtendedCharacter8dot3Rename" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Ntfs" /v "DisableReadAhead" /t REG_DWORD /d 1 /f >nul 2>&1

reg add "HKCU\Software\Microsoft\DirectX\UserGpuPreferences" /v "DirectXUserGlobalSettings" /t REG_SZ /d "SwapEffectUpgradeEnable=1;" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Khronos\Vulkan\ImplicitLayers" /v "DisableValidation" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "MaxContexts" /t REG_DWORD /d 4096 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "MaxLoaderThreads" /t REG_DWORD /d 16 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "ContextReordering" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D\11.0" /v "DisableClearOnAllocate" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D\12.0" /v "DisableClearOnAllocate" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D\12.0" /v "EnableAsyncCompute" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D\12.0" /v "DisablePsoEviction" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D\Drivers" /v "SoftwareOnly" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\DirectDraw" /v "EmulationOnly" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%DWM%" /v "UseHWDrawList" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%DWM%" /v "ForceSoftwareD3D" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%DWM%" /v "EnableIndependentFlip" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%DWM%" /v "EnableMachineCheck" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%DWM%" /v "AlwaysHibernateThumbnails" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%DWM%" /v "DisableProcessWindowsGhosting" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%DWM%" /v "MaxQueuedBuffers" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%DWM%" /v "OverlaySupported" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%DWM%" /v "ForceDirectFlip" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%DWM%" /v "DisableOverlays" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GD%" /v "HwSchMode" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "%GD%" /v "HwSch_QueueDepth" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GD%" /v "HwSch_MaxPendingCommand" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GD%" /v "TdrDdiDelay" /t REG_DWORD /d 10 /f >nul 2>&1
reg add "%GD%" /v "TdrDelay" /t REG_DWORD /d 10 /f >nul 2>&1
reg add "%GD%" /v "DmaRemappingCompatible" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GD%" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GD%" /v "EnableDirtyRectangles" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GD%" /v "FrameQueueMode" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GD%" /v "FSE_Enable" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GD%" /v "DisableWddm2Checks" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GD%" /v "PowerSettingEnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GD%" /v "EnableAsyncPresentation" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GD%" /v "PlatformSupportMiracast" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GD%" /v "IommuUsage" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GD%" /v "D3D12DisableSharedDynamicValueManagement" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GD%" /v "DisableMemoryEncryption" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GD%" /v "VerifyDriverLevel" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GD%" /v "MaxFrameLatency" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GD%" /v "TdrLevel" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "%GD%" /v "EnableMultiPlaneOverlay3DDIs" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GD%" /v "ForceDirectFlip" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GD%" /v "DisableOverlays" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GD%" /v "HighPriorityCompletionMode" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GD%" /v "GpuPriorityChangeMode" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GD%" /v "DCIControl" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GDMM%" /v "DirectStorageForceFlush" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GDPOWER%" /v "InvalidateDynamicPstate" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GDPOWER%" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GDPOWER%" /v "RmDisableRegistryCaching" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GDPOWER%" /v "EnablePowerBudget" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GDPOWER%" /v "IgnoreBatteryVoltageSag" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GDS%" /v "EnableComputePreemption" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GDS%" /v "VsyncIdleTimeout" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GDS%" /v "EnableVsyncClockGroup" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GDS%" /v "GpuPriority" /t REG_DWORD /d 31 /f >nul 2>&1
reg add "%GDS%" /v "PreemptionLevel" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GDS%" /v "MicrocodeQueuePriority" /t REG_DWORD /d 31 /f >nul 2>&1
reg add "%GDS%" /v "EnableAsyncCompute" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GDS%" /v "EnableMidGfxPreemption" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GDS%" /v "EnableSCGMidBufferPreemption" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GDS%" /v "SchedulePolicy" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "%GDS%" /v "GpuResourceAccessPriority" /t REG_DWORD /d 31 /f >nul 2>&1
reg add "%GDS%" /v "EnableYield" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GDS%" /v "EnablePreemptiveScheduling" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GDS%" /v "EnableCudaContextPreemption" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GDS%" /v "PollStatusIterations" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl\Parameters" /v "ThreadPriority" /t REG_DWORD /d 15 /f >nul 2>&1

reg add "HKCU\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AudioCaptureEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "CursorCaptureEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "MicrophoneCaptureEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_DSEBehavior" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Priority" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "GameModeEnabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "GameModeUseNullRenderer" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f >nul 2>&1

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 10 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "Priority" /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Priority" /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Background Only" /t REG_SZ /d "False" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Latency Sensitive" /t REG_SZ /d "True" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d 10000 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Clock Rate" /t REG_DWORD /d 10000 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Affinity" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Background Only" /t REG_SZ /d "False" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Latency Sensitive" /t REG_SZ /d "True" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Affinity" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Clock Rate" /t REG_DWORD /d 10000 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{36fc9e60-c465-11cf-8056-444553540000}" /v "IdleEnable" /t REG_DWORD /d 0 /f >nul 2>&1
for /f "tokens=*" %%K in ('reg query "%GPU_CLASS_KEY%" /s /v "DriverDesc" 2^>nul ^| findstr /i "HKEY_"') do (
    reg add "%%K" /v "MessageSignaledInterrupts" /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%K" /v "MSISupported" /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%K" /v "EnableAspm" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "%%K" /v "PciLatencyTimerControl" /t REG_DWORD /d 32 /f >nul 2>&1
    reg add "%%K\Interrupt Management\Affinity Policy" /v "Strategy" /t REG_DWORD /d 2 /f >nul 2>&1
    reg add "%%K\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d 4 /f >nul 2>&1
)
powershell -NoProfile -Command "Get-PnpDevice -Class Display -PresentOnly -ErrorAction SilentlyContinue | Where-Object { $_.InstanceId -like 'PCI\*' } | ForEach-Object { $k = 'HKLM:\SYSTEM\CurrentControlSet\Enum\' + $_.InstanceId + '\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties'; New-Item -Path $k -Force -ErrorAction SilentlyContinue | Out-Null; New-ItemProperty -Path $k -Name 'MSISupported' -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null }" >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E96F-E325-11CE-BFC1-08002BE10318}\0000" /v "ForceProcessHighPriority" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\HidUsb" /v "IdleEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PCI" /v "EnableMsi" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PCI" /v "MessageSignaledInterrupt" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PCI" /v "BusSolverMaxDepth" /t REG_DWORD /d 32 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PCI" /v "BusCheck" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PCI" /v "PerfOptimize" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pci" /v "PciLatencyTimerControl" /t REG_DWORD /d 32 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pci" /v "LinkDisableAspm" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v "PciBufferSize" /t REG_DWORD /d 64 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USB" /v "DisableSelectiveSuspend" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBXHCI\Parameters" /v "InterruptModeration" /t REG_DWORD /d 0 /f >nul 2>&1

set "SC_DISABLED=DiagTrack dmwappushservice WerSvc DPS WdiServiceHost WdiSystemHost PcaSvc diagnosticshub.standardcollector.service diagsvc SysMain RemoteRegistry RemoteAccess WinRM iphlpsvc BDESVC EFS SCardSvr ScDeviceEnum Fax MapsBroker PhoneSvc TapiSrv AJRouter WpcMonSvc ALG EntAppSvc wisvc RetailDemo WMPNetworkSvc StiSvc SensorService SensrSvc SensorDataService XboxGipSvc XblAuthManager XboxNetApiSvc XblGameSave SEMgrSvc uhssvc upfc microsoftedgeupdater microsoftedgeupdatem EsifTelemetryService ipfsvc AeLookupSvc WSAIFabricSvc edgeupdate edgeupdatem DsSvc WarpSvc NvTelemetryContainer Wecsvc NetTcpPortSharing perceptionsimulation spectrum MixedRealityOpenXRSvc BcastDVRUserService icssvc DmEnrollmentSvc embeddedmode GraphicsPerfSvc HvHost IpxlatCfgSvc jhi_service KtmRm LxpSvc McpManagementService MicrosoftEdgeElevationService NetSetupSvc NcdAutoSetup p2pimsvc p2psvc PerfHost pla PolicyAgent PNRPAutoReg PNRPsvc QWAVE RasAuto RasMan RpcLocator shpamsvc smphost SmsRouter SNMPTRAP svsvc TroubleshootingSvc tzautoupdate WebClient WEPHOSTSVC wercplsupport WFDSConMgrSvc WiaRpc WManSvc wmiApSrv WPDBusEnum LicenseManager fhsvc defragsvc TieringEngineService UdkUserSvc Spooler SharedAccess WwanSvc"

for %%S in (%SC_DISABLED%) do (
    sc config %%S start= disabled >nul 2>&1
)

if "!DISABLE_STORE!"=="1" (
    sc config InstallService start= disabled >nul 2>&1
    sc config PushToInstall start= disabled >nul 2>&1
) else (
    sc config InstallService start= demand >nul 2>&1
    sc config PushToInstall start= demand >nul 2>&1
)

if "!DISABLE_WU!"=="1" (
    sc config wuauserv start= disabled >nul 2>&1
    sc config dosvc start= disabled >nul 2>&1
    sc config UsoSvc start= disabled >nul 2>&1
    sc config WaaSMedicSvc start= disabled >nul 2>&1
    sc config bits start= disabled >nul 2>&1
) else (
    sc config wuauserv start= demand >nul 2>&1
    sc config dosvc start= demand >nul 2>&1
    sc config UsoSvc start= demand >nul 2>&1
    sc config WaaSMedicSvc start= demand >nul 2>&1
    sc config bits start= demand >nul 2>&1
)

for %%S in ("AMD Crash Defender Service" "AUEPLauncher" "NvTelemetryContainer") do (
    sc config "%%~S" start= disabled >nul 2>&1
)

sc delete edgeupdate >nul 2>&1
sc delete edgeupdatem >nul 2>&1
sc config TabletInputService start= auto >nul 2>&1
sc config IntelAudioService start= demand >nul 2>&1
sc config AppXSvc start= demand >nul 2>&1
sc config ClipSVC start= demand >nul 2>&1
sc config camsvc start= auto >nul 2>&1
sc config SDRSVC start= demand >nul 2>&1
sc config StorSvc start= demand >nul 2>&1
sc config TrkWks start= auto >nul 2>&1
sc config vds start= demand >nul 2>&1
sc config RtkAudioUniversalService start= auto >nul 2>&1
sc config bthserv start= auto >nul 2>&1
sc config BthAvctpSvc start= auto >nul 2>&1
sc config Themes start= auto >nul 2>&1
sc config FontCache start= auto >nul 2>&1
sc config CDPSvc start= auto >nul 2>&1
sc config CDPUserSvc start= demand >nul 2>&1
sc config BTAGService start= auto >nul 2>&1
sc config W32Time start= demand >nul 2>&1

for %%S in (%SC_DISABLED%) do (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%S" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
)

if "!DISABLE_STORE!"=="1" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\InstallService" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\PushToInstall" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
) else (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\InstallService" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\PushToInstall" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
)

if "!DISABLE_WU!"=="1" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\bits" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\dosvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
) else (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\bits" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\dosvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppXSvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTAGService" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthAvctpSvc" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\bthserv" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\camsvc" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPSvc" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ClipSVC" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DispBrokerDesktopSvc" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\FontCache" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\KeyIso" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\RtkAudioUniversalService" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SDRSVC" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\StorSvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\swprv" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TabletInputService" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Themes" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TrkWks" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\vds" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
set "SC_EXTRA=EventLog AppIDSvc CredentialEnrollmentManagerUserSvc DeviceAssociationBrokerSvc PrintWorkflowUserSvc SgrmBroker WinHttpAutoProxySvc WMIRegistrationService igccservice cplspcon esifsvc LMS cphs DSAService DSAUpdateService RstMwService SystemUsageReportSvc_QUEENCREEK iaStorAfsService RzActionSvc CortexLauncherService HapticService logi_lamparray_service LGHUBUpdaterService FvSVC"
for %%S in (%SC_EXTRA%) do (
    reg query "HKLM\SYSTEM\CurrentControlSet\Services\%%S" >nul 2>&1 && (
        sc config %%S start= disabled >nul 2>&1
        reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%S" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
    )
)

reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "4294967295" /f >nul 2>&1

powershell -NoProfile -Command "Clear-RecycleBin -Confirm:$false -ErrorAction SilentlyContinue" >nul 2>&1

for %%A in (
    "Microsoft.BingNews"
    "Microsoft.BingWeather"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.People"
    "Microsoft.PowerAutomateDesktop"
    "Microsoft.Todos"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.WindowsMaps"
    "Microsoft.YourPhone"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "Microsoft.SkypeApp"
    "Clipchamp.Clipchamp"
    "Microsoft.Bing"
    "Microsoft.OutlookForWindows"
    "Microsoft.DevHome"
    "Microsoft.Windows.DevHome"
    "Microsoft.WebExperiencePack"
    "Microsoft.Windows.Ai.Copilot.Provider"
    "Microsoft.Copilot"
    "MSTeams"
    "Microsoft.MicrosoftEdge.Stable"
) do (
    powershell -NoProfile -Command "Get-AppxPackage *%%~A* | Remove-AppxPackage" >nul 2>&1
)

powershell -NoProfile -Command "Get-AppxPackage -AllUsers *MixedReality.Portal* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *windowscommunicationsapps* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *OutlookForWindows* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *MSPaint* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *ScreenSketch* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *MicrosoftStickyNotes* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *WindowsSoundRecorder* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -NoProfile -Command "Disable-WindowsOptionalFeature -Online -FeatureName 'WorkFolders-Client', 'SMB1Protocol' -NoRestart" >nul 2>&1
powershell -NoProfile -Command "Set-MpPreference -SubmitSamplesConsent 2" >nul 2>&1

for %%A in (
    "Microsoft.ApplicationCompatibilityEnhancements"
    "Microsoft.AV1VideoExtension"
    "Microsoft.AVCEncoderVideoExtension"
    "Microsoft.Edge.GameAssist"
    "Microsoft.GamingApp"
    "Microsoft.GamingServices"
    "Microsoft.HEIFImageExtension"
    "Microsoft.HEVCVideoExtension"
    "Microsoft.MPEG2VideoExtension"
    "Microsoft.OneDriveSync"
    "Microsoft.RawImageExtension"
    "Microsoft.StartExperiencesApp"
    "Microsoft.VP9VideoExtensions"
    "Microsoft.WebMediaExtensions"
    "Microsoft.WebpImageExtension"
    "Microsoft.WindowsAlarms"
    "Microsoft.WindowsCalculator"
    "Microsoft.WindowsCamera"
    "Microsoft.WindowsNotepad"
    "Microsoft.WindowsTerminal"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxGamingOverlay"
    "Microsoft.XboxIdentityProvider"
    "Microsoft.XboxSpeechToTextOverlay"
    "MicrosoftCorporationII.MicrosoftFamily"
    "MicrosoftCorporationII.QuickAssist"
    "MicrosoftWindows.CrossDevice"
    "MicrosoftWindows.LKG.TwinSxS"
    "Microsoft.WidgetsPlatformRuntime"
    "Microsoft.Paint"
) do (
    powershell -NoProfile -Command "Get-AppxPackage *%%~A* | Remove-AppxPackage" >nul 2>&1
)

logman stop "Microsoft-Windows-Storage-Storport-Operational" -ets >nul 2>&1
logman stop "Microsoft-Windows-Rdp-Graphics-RdpIdd-Trace" -ets >nul 2>&1
logman stop "Microsoft-Windows-Kernel-Processor-Power" -ets >nul 2>&1
logman stop "Microsoft-Windows-UserModePowerService" -ets >nul 2>&1
logman stop "Microsoft-Windows-Ntfs-Operational" -ets >nul 2>&1
logman stop "Microsoft-Windows-DeviceSetupManager-Admin" -ets >nul 2>&1
logman stop "Circular Kernel Context Logger" -ets >nul 2>&1
logman stop "UBPM" -ets >nul 2>&1
logman stop "AutoLogger-Diagtrack-Listener" -ets >nul 2>&1
logman stop "NetCore" -ets >nul 2>&1
logman stop "ContextLogger" -ets >nul 2>&1
logman stop "CloudExperienceHost" -ets >nul 2>&1
wevtutil cl System >nul 2>&1
wevtutil cl Application >nul 2>&1
wevtutil cl Security >nul 2>&1
wevtutil cl Setup >nul 2>&1
wevtutil.exe set-log "Microsoft-Windows-SleepStudy/Diagnostic" /e:false >nul 2>&1
wevtutil.exe set-log "Microsoft-Windows-Kernel-Processor-Power/Diagnostic" /e:false >nul 2>&1
wevtutil.exe set-log "Microsoft-Windows-UserModePowerService/Diagnostic" /e:false >nul 2>&1

reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\Privacy" /v "DisconnectedState" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\Privacy" /v "ContentSlotState" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\OSM" /v "Enablelogging" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\OSM" /v "EnableUpload" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\EdgeUpdate" /v "DoNotUpdateToEdgeWithChromium" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "BackgroundModeEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "MetricsReportingEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "PersonalizationReportingEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "UserFeedbackAllowed" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "BackgroundModeEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\Main" /v "AllowPrelaunch" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\WebView2" /v "TelemetryEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "UpdateDefault" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "DisableAutoUpdateChecksCheckboxValue" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "Update{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}" /t REG_DWORD /d 0 /f >nul 2>&1

reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338380Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338381Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338382Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RemediationRequired" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SoftLandingEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesAllowed" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v "ScoobeSystemSettingEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableTailoredExperiencesWithDiagnosticData" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v "Value" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v "Value" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Installer" /v "DisableCoInstallers" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\DataCollection" /v "MaxTelemetryAllowed" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableSoftLanding" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightFeatures" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightOnActionCenter" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightWindowsWelcomeExperience" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "LimitEnhancedDiagnosticData" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator" /v "NoActiveProbe" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableActivityFeed /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v UploadUserActivities /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableAIDataAnalysis" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CI\Policy" /v "VerifiedAndReputablePolicyState" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\NlaSvc\Parameters\Internet" /v "EnableActiveProbing" /t REG_DWORD /d "0" /f >nul 2>&1

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\AggregatorHost.exe" /v "Debugger" /t REG_SZ /d "nul" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\CompatTelRunner.exe" /v "Debugger" /t REG_SZ /d "nul" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\DeviceCensus.exe" /v "Debugger" /t REG_SZ /d "nul" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "PagePriority" /t REG_DWORD /d 5 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\explorer.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\explorer.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\explorer.exe\PerfOptions" /v "PagePriority" /t REG_DWORD /d 5 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchHost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchHost.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchHost.exe\PerfOptions" /v "PagePriority" /t REG_DWORD /d 5 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ShellExperienceHost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ShellExperienceHost.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ShellExperienceHost.exe\PerfOptions" /v "PagePriority" /t REG_DWORD /d 5 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\spoolsv.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WMIADAP.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WMIADAP.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WmiPrvSE.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%POWER%" /v "DisableSensorWatchdog" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%POWER%" /v "FabricClockGating" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%POWER%" /v "LclkClockGating" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%POWER%" /v "ProcessorPerformanceMinimum" /t REG_DWORD /d 100 /f >nul 2>&1
reg add "%POWER%" /v "ProcessorPerformanceMaximum" /t REG_DWORD /d 100 /f >nul 2>&1
reg add "%POWER%" /v "ProcessorPerformanceMaximumPolicy" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%POWER%" /v "CpuUtilizationPercentage" /t REG_DWORD /d 100 /f >nul 2>&1
reg add "%POWER%" /v "EnergyEstimationDisabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%POWER%" /v "ResponsiveModeEnabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%POWER%" /v "AcceleratedHibernateEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%POWER%" /v "EnergyEfficientTurbo" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%POWER%" /v "TurboBoostEnabled" /t REG_DWORD /d 1 /f >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 5d76a269-e800-44e8-a5b7-062e75e9b736 1 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1
reg add "%POWER%" /v "VRReadyEnabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%POWER%" /v "VRMode" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%POWER%" /v "LowLatencyMode" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%POWER%" /v "LowLatencyState" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "%POWER%" /v "MemoryPerformanceMode" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%POWER%" /v "MemoryTimingOverride" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%POWER%" /v "USB3PowerEnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%POWER%" /v "S0AutoPowerDownTimer" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%POWER%" /v "CpuComputeEfficiencyEnabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%POWER%" /v "CpuBusyBudgeting" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%POWER%" /v "UnifiedStackPolicy" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%POWER%" /v "FastS4" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%POWER%" /v "HiberFileEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%POWER%\PowerSettings" /v "DefaultPowerSchemeValues" /t REG_BINARY /d 000000 /f >nul 2>&1
reg add "%POWER%\PowerThresholds" /v "AcThermalScalingRatio" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%POWER%\PowerThresholds" /v "DcThermalScalingRatio" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%POWER%\PowerThresholds" /v "AcLineStatus" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%POWER%\PowerThresholds" /v "BatteryFlag" /t REG_DWORD /d 0 /f >nul 2>&1
set "ProgramFilesRobloxPath="
set "AppDataRobloxPath="
set "LatestDiscordPath="
for /f "delims=" %%R in ('dir "C:\Program Files (x86)\Roblox\Versions\version-*" /ad /b /o:-d 2^>nul') do (
    set "ProgramFilesRobloxPath=C:\Program Files (x86)\Roblox\Versions\%%R\RobloxPlayerBeta.exe"
    goto :HEX_PRIO_RBX1
)
:HEX_PRIO_RBX1
for /f "delims=" %%R in ('dir "%USERPROFILE%\AppData\Local\Roblox\Versions\version-*" /ad /b /o:-d 2^>nul') do (
    set "AppDataRobloxPath=%USERPROFILE%\AppData\Local\Roblox\Versions\%%R\RobloxPlayerBeta.exe"
    goto :HEX_PRIO_RBX2
)
:HEX_PRIO_RBX2
for /f "delims=" %%D in ('dir "%USERPROFILE%\AppData\Local\Discord\app-*" /ad /b /o:-d 2^>nul') do (
    set "LatestDiscordPath=%USERPROFILE%\AppData\Local\Discord\%%D\Discord.exe"
    goto :HEX_PRIO_DSC
)
:HEX_PRIO_DSC

set "regKeyGP=HKCU\SOFTWARE\Microsoft\DirectX\UserGpuPreferences"
set "regKeyPR=HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options"
set "regKeyFO=HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"
reg add "%regKeyGP%" /f >nul 2>&1

set "games[0]=%ProgramFilesRobloxPath%"
set "games[1]=%AppDataRobloxPath%"
set "games[2]=C:\Program Files\Epic Games\Fortnite\FortniteGame\Binaries\Win64\FortniteClient-Win64-Shipping.exe"
set "games[3]=C:\Program Files\Epic Games\RocketLeague\Binaries\Win64\RocketLeague.exe"
set "games[4]=C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\game\bin\win64\cs2.exe"
set "games[5]=C:\Program Files (x86)\Steam\steamapps\common\Tom Clancy's Rainbow Six Siege\RainbowSix.exe"
set "games[6]=C:\Program Files (x86)\Steam\steamapps\common\Overwatch\Overwatch.exe"
set "games[7]=C:\Program Files (x86)\Steam\steamapps\common\Trove\Games\Trove\Live\Trove.exe"
set "games[8]=C:\Program Files (x86)\Steam\steamapps\common\VRChat\VRChat.exe"
set "games[9]=C:\Program Files (x86)\Steam\steamapps\common\FPSAimTrainer\FPSAimTrainer.exe"
set "games[10]=C:\Program Files (x86)\Steam\steamapps\common\Mafia The Old Country\MafiaTheOldCountry\Binaries\Win64\MafiaTheOldCountry.exe"
set "games[11]=C:\Program Files (x86)\Steam\steamapps\common\The Forest\TheForest.exe"
set "games[12]=C:\Program Files (x86)\Steam\steamapps\common\Dying Light 2\ph\work\bin\x64\DyingLightGame_x64_rwdi.exe"
set "games[13]=C:\Program Files (x86)\Steam\steamapps\common\Schedule I\Schedule I.exe"
set "games[14]=C:\Program Files (x86)\Steam\steamapps\common\Far Cry 3\bin\farcry3_d3d11.exe"
set "games[15]=C:\Program Files (x86)\Steam\steamapps\common\Sons Of The Forest\SonsOfTheForest.exe"
set "games[16]=C:\Program Files (x86)\Steam\steamapps\common\Mafia Definitive Edition\mafiadefinitiveedition.exe"
set "games[17]=C:\Program Files (x86)\Steam\steamapps\common\The Outlast Trials\OPP\Binaries\Win64\TOTClient-Win64-Shipping.exe"
set "games[18]=%USERPROFILE%\AppData\Local\osu^!\osu^!.exe"
set "games[19]=C:\Riot Games\VALORANT\live\VALORANT.exe"
set "games[20]=C:\Program Files\Epic Games\VALORANT\VALORANT.exe"
set "games[21]=C:\Program Files (x86)\Steam\steamapps\common\Grand Theft Auto V\GTA5.exe"
set "games[22]=C:\Program Files\Epic Games\GTAV\GTAV.exe"
set "games[23]=C:\Program Files\Rockstar Games\Grand Theft Auto V\GTA5.exe"
set "games[24]=C:\Program Files\Epic Games\Apex\Apex.exe"
set "games[25]=C:\Program Files (x86)\Steam\steamapps\common\Apex Legends\Apex Legends.exe"
set "games[26]=C:\Program Files (x86)\Electronic Arts\Apex\Apex.exe"
set "games[27]=C:\Program Files (x86)\Steam\steamapps\common\Call of Duty Black Ops\BlackOps.exe"
set "games[28]=C:\Program Files (x86)\Steam\steamapps\common\Call of Duty Black Ops II\BlackOps2.exe"
set "games[29]=C:\Program Files (x86)\Steam\steamapps\common\Call of Duty Black Ops III\BlackOps3.exe"
set "games[30]=C:\Program Files (x86)\Battle.net\Call of Duty Black Ops 4\BlackOps4.exe"
set "games[31]=C:\Program Files (x86)\Steam\steamapps\common\Call of Duty Black Ops Cold War\BlackOpsColdWar.exe"
set "games[32]=C:\Program Files (x86)\Battle.net\Call of Duty Black Ops Cold War\BlackOpsColdWar.exe"
set "games[33]=C:\Program Files (x86)\Steam\steamapps\common\Call of Duty Black Ops 6\BlackOps6.exe"
set "games[34]=C:\Program Files (x86)\Battle.net\Call of Duty Black Ops 6\BlackOps6.exe"
set "games[35]=C:\Program Files (x86)\Steam\steamapps\common\Call of Duty Modern Warfare\modernwarfare.exe"
set "games[36]=C:\Program Files (x86)\Battle.net\Call of Duty Modern Warfare\modernwarfare.exe"
set "games[37]=C:\Program Files (x86)\Steam\steamapps\common\Call of Duty Modern Warfare II\cod22-cod.exe"
set "games[38]=C:\Program Files (x86)\Battle.net\Call of Duty Modern Warfare II\cod22-cod.exe"
set "games[39]=C:\Program Files (x86)\Steam\steamapps\common\Call of Duty Modern Warfare III\cod23-cod.exe"
set "games[40]=C:\Program Files (x86)\Battle.net\Call of Duty Modern Warfare III\cod23-cod.exe"
set "games[41]=C:\Program Files\Genshin Impact\Genshin Impact Game\GenshinImpact.exe"
set "games[42]=C:\Program Files\Epic Games\Genshin Impact\Genshin Impact Game\GenshinImpact.exe"
set "games[43]=C:\Program Files (x86)\Steam\steamapps\common\Dead by Daylight\DeadByDaylight\Binaries\Win64\DeadByDaylight-Win64-Shipping.exe"
set "games[44]=C:\Program Files\Epic Games\Dead by Daylight\DeadByDaylight\Binaries\Win64\DeadByDaylight-EGS-Shipping.exe"
set "games[45]=C:\Program Files (x86)\Steam\steamapps\common\Aimlabs\AimLab_tb.exe"
set "games[46]=C:\Program Files\Epic Games\Aimlabs\AimLab_tb.exe"
set "games[47]=C:\Program Files (x86)\Ubisoft\Ubisoft Game Launcher\games\Tom Clancy's Rainbow Six Siege\RainbowSix.exe"

set "apps[0]=%LatestDiscordPath%"
set "apps[1]=%USERPROFILE%\AppData\Roaming\Spotify\Spotify.exe"
set "apps[2]=C:\Program Files (x86)\MSI Afterburner\MSIAfterburner.exe"
set "apps[3]=C:\Program Files (x86)\Epic Games\Launcher\Portal\Binaries\Win64\EpicGamesLauncher.exe"
set "apps[4]=C:\Program Files (x86)\Epic Games\Launcher\Engine\Binaries\Win64\EpicWebHelper.exe"
set "apps[5]=C:\Program Files (x86)\Epic Games\Launcher\Engine\Binaries\Win64\CrashReportClient.exe"
set "apps[6]=C:\Program Files (x86)\Steam\Steam.exe"
set "apps[7]=C:\Program Files (x86)\Steam\bin\cef\cef.win7x64\steamwebhelper.exe"
set "apps[8]=C:\Program Files (x86)\Battle.net\Battle.net.exe"
set "apps[9]=C:\Program Files\Core Temp\Core Temp.exe"
set "apps[10]=C:\Program Files (x86)\CapFrameX\CapFrameX.exe"
set "apps[11]=C:\Program Files\CPUID\HWMonitor\HWMonitor.exe"
set "apps[12]=C:\Program Files\VideoLAN\VLC\vlc.exe"
set "apps[13]=C:\Program Files\Google\Chrome\Application\chrome.exe"
set "apps[14]=C:\Program Files\Open-Shell\StartMenu.exe"
set "apps[15]=C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"
set "apps[16]=%USERPROFILE%\AppData\Local\Programs\Opera GX\launcher.exe"

set "other[0]=Adobe Premiere Pro.exe"
set "other[1]=VegasPro.exe"
set "other[2]=Resolve.exe"
set "other[3]=blender.exe"
set "other[4]=shotcut.exe"
set "other[5]=HandBrake.exe"
set "other[6]=capcut.exe"
set "other[7]=Cinebench.exe"
set "other[8]=3DMark.exe"
set "other[9]=LatMon.exe"
set "other[10]=y-cruncher.exe"
set "other[11]=TM5.exe"
set "other[12]=linpack_xeon64.exe"
set "other[13]=node.exe"
set "other[14]=UnRAR.exe"
set "other[15]=Rar.exe"
set "other[16]=7z.exe"

for /L %%i in (0,1,47) do (
    set "currentPath=!games[%%i]!"
    if defined currentPath if exist "!currentPath!" (
        for %%a in ("!currentPath!") do set "exeName=%%~nxa"
        reg add "%regKeyGP%" /v "!currentPath!" /t REG_SZ /d "GpuPreference=2;" /f >nul 2>&1
        reg query "%regKeyPR%\!exeName!\PerfOptions" /v "CpuPriorityClass" >nul 2>&1 || reg add "%regKeyPR%\!exeName!\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "3" /f >nul 2>&1
        reg add "%regKeyFO%" /v "!currentPath!" /t REG_SZ /d "~ DISABLEDXMAXIMIZEDWINDOWEDMODE HIGHDPIAWARE" /f >nul 2>&1
    )
)

for /L %%i in (0,1,16) do (
    set "currentPath=!apps[%%i]!"
    if defined currentPath if exist "!currentPath!" (
        for %%a in ("!currentPath!") do set "exeName=%%~nxa"
        reg add "%regKeyGP%" /v "!currentPath!" /t REG_SZ /d "GpuPreference=1;" /f >nul 2>&1
        reg query "%regKeyPR%\!exeName!\PerfOptions" /v "CpuPriorityClass" >nul 2>&1 || reg add "%regKeyPR%\!exeName!\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul 2>&1
    )
)

for /L %%i in (0,1,16) do (
    set "exeName=!other[%%i]!"
    reg add "%regKeyPR%\!exeName!\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "3" /f >nul 2>&1
)

reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "FeatureTestControl" /t REG_DWORD /d 113 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDriverManagement" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Perflib" /v "Disable Performance Counters" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Perflib" /v "ExtensibleCounters" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Perflib\009" /v "Collect Timeout" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GD%" /v "DpiMapIommuContiguous" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GD%" /v "MaximumFrameLatency" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GD%" /v "CS_Disable" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GD%" /v "D3D9AsyncQueue" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GDS%" /v "VsyncCpuThreadPriority" /t REG_DWORD /d 15 /f >nul 2>&1
reg add "%GDS%" /v "ThreadPriority" /t REG_DWORD /d 31 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WHEA\Policy" /v "DisableMCAPolling" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WHEA\Policy" /v "DisableOffline" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ACPI\Parameters" /v "EnableMsi" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ACPI\Parameters" /v "InterruptSyntax" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\partmgr" /v "StaggeredSpinWatches" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PerfData" /v "Disable Performance Counters" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PerfData" /v "ForceSingleDPC" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PerfData" /v "BufferSize" /t REG_DWORD /d 0 /f >nul 2>&1
reg delete "%MM%" /v "ThirdLevelDataCache" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" /v "StartupDelay" /t REG_DWORD /d 0 /f >nul 2>&1

powercfg /setacvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPREFERENCE 1 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPOWER 100 >nul 2>&1
powercfg /setdcvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPREFERENCE 1 >nul 2>&1
powercfg /setdcvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPOWER 100 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\CredentialGuard" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\KernelShadowStacks" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\SystemGuard" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%POWER%" /v "HibernateEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d 0 /f >nul 2>&1

fsutil behavior set DisableDeleteNotify 0 >nul 2>&1

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Recovery" /v "QuickMachineRecoveryEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /v "InstallEveryDevice" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storahci\Parameters\Device" /v "EnableHIPM" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storahci\Parameters\Device" /v "EnableDIPM" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storahci\Parameters\Device" /v "IdlePowerMode" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storahci\Parameters\Device" /v "DisableIdlePowerManagement" /t REG_DWORD /d 1 /f >nul 2>&1

echo [*] Applying network adapter power / offload tweaks...
set "NIC_CLASS=HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}"
for /f "tokens=*" %%K in ('reg query "%NIC_CLASS%" /v "*SpeedDuplex" /s 2^>nul ^| findstr "HKEY"') do (
    for %%V in (
        "@ReceiveBuffers|REG_SZ|2048" "@TransmitBuffers|REG_SZ|1024" "EnablePME|REG_SZ|0" "@DeviceSleepOnDisconnect|REG_SZ|0"
        "@EEE|REG_SZ|0" "@ModernStandbyWoLMagicPacket|REG_SZ|0" "@SelectiveSuspend|REG_SZ|0" "@WakeOnMagicPacket|REG_SZ|0"
        "@WakeOnPattern|REG_SZ|0" "AutoPowerSaveModeEnabled|REG_SZ|0" "EEELinkAdvertisement|REG_SZ|0" "EeePhyEnable|REG_SZ|0"
        "EnableGreenEthernet|REG_SZ|0" "EnableModernStandby|REG_SZ|0" "GigaLite|REG_SZ|0" "PnPCapabilities|REG_DWORD|24"
        "PowerDownPll|REG_SZ|0" "PowerSavingMode|REG_SZ|0" "ReduceSpeedOnPowerDown|REG_SZ|0" "S5WakeOnLan|REG_SZ|0"
        "SavePowerNowEnabled|REG_SZ|0" "ULPMode|REG_SZ|0" "WakeOnLink|REG_SZ|0" "WakeOnSlot|REG_SZ|0"
        "WakeUpModeCap|REG_SZ|0" "WaitAutoNegComplete|REG_SZ|0" "@FlowControl|REG_SZ|0" "WolShutdownLinkSpeed|REG_SZ|2"
        "WakeOnMagicPacketFromS5|REG_SZ|2" "@PMNSOffload|REG_SZ|0" "@PMARPOffload|REG_SZ|0" "@NicAutoPowerSaver|REG_SZ|0"
        "@PMWiFiRekeyOffload|REG_SZ|0" "EnablePowerManagement|REG_SZ|0" "ForceWakeFromMagicPacketOnModernStandby|REG_SZ|0" "WakeFromS5|REG_SZ|0"
        "WakeOn|REG_SZ|0" "OBFFEnabled|REG_SZ|0" "DMACoalescing|REG_SZ|0" "EnableSavePowerNow|REG_SZ|0"
        "EnableD0PHYFlexibleSpeed|REG_SZ|0" "EnablePHYWakeUp|REG_SZ|0" "EnablePHYFlexibleSpeed|REG_SZ|0" "AllowAllSpeedsLPLU|REG_SZ|0"
        "@EnableDynamicPowerGating|REG_SZ|0" "EnableD3ColdInS0|REG_SZ|0" "LatencyToleranceReporting|REG_SZ|0" "EnableAspm|REG_SZ|0"
        "LTROBFF|REG_SZ|0" "S0MgcPkt|REG_SZ|0" "@TCPChecksumOffloadIPv4|REG_SZ|3" "@TCPChecksumOffloadIPv6|REG_SZ|3"
        "@TCPConnectionOffloadIPv4|REG_SZ|3" "@TCPConnectionOffloadIPv6|REG_SZ|3" "@TCPUDPChecksumOffloadIPv4|REG_SZ|3" "@TCPUDPChecksumOffloadIPv6|REG_SZ|3"
        "@UDPChecksumOffloadIPv4|REG_SZ|3" "@UDPChecksumOffloadIPv6|REG_SZ|3" "@UdpRsc|REG_SZ|0" "@UsoIPv4|REG_SZ|0"
        "@UsoIPv6|REG_SZ|0" "@RscIPv6|REG_SZ|0" "@RscIPv4|REG_SZ|0" "@IPsecOffloadV2IPv4|REG_SZ|0"
        "@IPsecOffloadV2|REG_SZ|0" "@IPsecOffloadV1IPv4|REG_SZ|0" "@LsoV1IPv4|REG_SZ|0" "@LsoV2IPv4|REG_SZ|0"
        "@LsoV2IPv6|REG_SZ|0" "@IPChecksumOffloadIPv4|REG_SZ|3" "WakeFromPowerOff|REG_SZ|0" "LogLinkStateEvent|REG_SZ|16"
        "@InterruptModeration|REG_SZ|0" "ITR|REG_SZ|0"
    ) do (
        for /f "tokens=1-3 delims=|" %%a in ("%%~V") do (
            set "NIC_VAL=%%a"
            set "NIC_VAL=!NIC_VAL:@=*!"
            reg query "%%K" /v "!NIC_VAL!" >nul 2>&1 && reg add "%%K" /v "!NIC_VAL!" /t %%b /d "%%c" /f >nul 2>&1
        )
    )
)

echo [*] Disabling UCPD (User Choice Protection Driver)...
sc config ucpd start= disabled >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ucpd" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\AppxDeploymentClient\UCPD velocity" /Disable >nul 2>&1

powercfg /hibernate off >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\NVIDIA Corporation\Global\NVTweak" /v "DisplayPowerSaving" /t REG_DWORD /d 0 /f >nul 2>&1

echo [*] Disabling legacy optional features (IIS, MSMQ, WCF, SMB1, Telnet, .NET 3.5, PowerShell 2...)
powershell -NoProfile -Command "$n=@('Client-ProjFS','HypervisorPlatform','IIS-ApplicationDevelopment','IIS-ApplicationInit','IIS-ASP','IIS-ASPNET','IIS-ASPNET45','IIS-BasicAuthentication','IIS-CGI','IIS-CommonHttpFeatures','IIS-CustomLogging','IIS-DefaultDocument','IIS-DirectoryBrowsing','IIS-FTPExtensibility','IIS-FTPServer','IIS-FTPSvc','IIS-HealthAndDiagnostics','IIS-HostableWebCore','IIS-HttpCompressionDynamic','IIS-HttpCompressionStatic','IIS-HttpErrors','IIS-HttpLogging','IIS-HttpRedirect','IIS-HttpTracing','IIS-IIS6ManagementCompatibility','IIS-IPSecurity','IIS-ISAPIExtensions','IIS-ISAPIFilter','IIS-LegacyScripts','IIS-LoggingLibraries','IIS-ManagementConsole','IIS-ManagementScriptingTools','IIS-ManagementService','IIS-Metabase','IIS-NetFxExtensibility','IIS-NetFxExtensibility45','IIS-Performance','IIS-RequestFiltering','IIS-RequestMonitor','IIS-Security','IIS-ServerSideIncludes','IIS-StaticContent','IIS-URLAuthorization','IIS-WebDAV','IIS-WebServer','IIS-WebServerManagementTools','IIS-WebServerRole','IIS-WebSockets','IIS-WMICompatibility','LegacyComponents','MicrosoftWindowsPowershellV2','MicrosoftWindowsPowershellV2Root','MSMQ-Container','MSMQ-DCOMProxy','MSMQ-HTTP','MSMQ-Multicast','MSMQ-Server','MSMQ-Triggers','MSRDC-Infrastructure','NetFx3','Printing-Foundation-LPDPrintService','Printing-Foundation-LPRPortMonitor','Printing-PrintToPDFServices-Features','SimpleTCP','SMB1Protocol-Client','SMB1Protocol-Deprecation','SMB1Protocol-Server','TelnetClient','TFTP','TIFFIFilter','WAS-ConfigurationAPI','WAS-NetFxEnvironment','WAS-ProcessModel','WAS-WindowsActivationService','WCF-HTTP-Activation','WCF-HTTP-Activation45','WCF-MSMQ-Activation45','WCF-NonHTTP-Activation','WCF-Pipe-Activation45','WCF-TCP-Activation45','Windows-Identity-Foundation'); Get-WindowsOptionalFeature -Online -ErrorAction SilentlyContinue | Where-Object { $_.State -eq 'Enabled' -and $n -contains $_.FeatureName } | ForEach-Object { Disable-WindowsOptionalFeature -Online -FeatureName $_.FeatureName -NoRestart -ErrorAction SilentlyContinue | Out-Null }" >nul 2>&1

if "!EXTRA_AGGR!"=="1" (
    echo [*] Aggressive module: disabling extra services and UAC...
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "FilterAdministratorToken" /t REG_DWORD /d 0 /f >nul 2>&1
    for %%S in (BFE SamSs Netman NVDisplay.ContainerLocalSystem NvContainerLocalSystem) do (
        sc config %%S start= disabled >nul 2>&1
        reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%S" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
    )
)

if "!DISABLE_STORE!"=="0" goto :STORE_ENABLED

:STORE_DISABLED
echo [*] Disabling Microsoft Store [preserving AppX for Defender UI]...
net stop InstallService /y >nul 2>&1
net stop PushToInstall /y >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "DisallowRun" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /v "1" /t REG_SZ /d "StoreDesktopExtension.exe" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableConsumerAccountStateContent" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "RemoveWindowsStore" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "DisableStoreApps" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d 2 /f >nul 2>&1
taskkill /f /im StoreDesktopExtension.exe >nul 2>&1

schtasks /Change /TN "Microsoft\Windows\InstallService\ScanForUpdates" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\ScanForUpdatesAsUser" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\SmartRetry" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\WakeUpAndContinueUpdates" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\WakeUpAndScanForUpdates" /Disable >nul 2>&1
goto :STORE_COMMON

:STORE_ENABLED
echo [*] Keeping Microsoft Store enabled and functional...
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "RemoveWindowsStore" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "DisableStoreApps" /t REG_DWORD /d 0 /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /v "1" /f >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\ScanForUpdates" /Enable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\ScanForUpdatesAsUser" /Enable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\SmartRetry" /Enable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\WakeUpAndContinueUpdates" /Enable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\WakeUpAndScanForUpdates" /Enable >nul 2>&1

:STORE_COMMON

sc config DiagTrack start= disabled >nul 2>&1
sc config dmwappushservice start= disabled >nul 2>&1
sc config WerSvc start= disabled >nul 2>&1

if "!DISABLE_WU!"=="0" goto :WU_SHIELD

:WU_LOCKDOWN
echo [*] Disabling Windows Update and services [Full Lock]...
net stop wuauserv /y >nul 2>&1
net stop bits /y >nul 2>&1
net stop dosvc /y >nul 2>&1
net stop usosvc /y >nul 2>&1
net stop WaaSMedicSvc /y >nul 2>&1
net stop stisvc /y >nul 2>&1

rd /s /q "%systemroot%\SoftwareDistribution" >nul 2>&1
del /f /q "%systemroot%\system32\catroot2\*.*" >nul 2>&1

sc triggerinfo wuauserv delete >nul 2>&1
sc triggerinfo usosvc delete >nul 2>&1
sc triggerinfo WaaSMedicSvc delete >nul 2>&1
sc triggerinfo bits delete >nul 2>&1
sc triggerinfo stisvc start/disabled >nul 2>&1
sc config AarSvc start= disabled >nul 2>&1
sc config ADPSvc start= disabled >nul 2>&1
sc config AJRouter start= disabled >nul 2>&1
sc config ALG start= disabled >nul 2>&1
sc config AppMgmt start= disabled >nul 2>&1
sc config AppReadiness start= disabled >nul 2>&1
sc config AssignedAccessManagerSvc start= disabled >nul 2>&1
sc config autotimesvc start= disabled >nul 2>&1
sc config AxInstSV start= disabled >nul 2>&1
sc config BcastDVRUserService start= disabled >nul 2>&1
sc config BDESVC start= disabled >nul 2>&1
sc config BITS start= disabled >nul 2>&1
sc config BluetoothUserService start= disabled >nul 2>&1
sc config BTAGService start= disabled >nul 2>&1
sc config BthAvctpSvc start= disabled >nul 2>&1
sc config bthserv start= disabled >nul 2>&1
sc config CaptureService start= disabled >nul 2>&1
sc config cbdhsvc start= disabled >nul 2>&1
sc config CDPUserSvc start= disabled >nul 2>&1
sc config CDPSvc start= disabled >nul 2>&1
sc config CertPropSvc start= disabled >nul 2>&1
sc config CloudBackupRestoreSvc start= disabled >nul 2>&1
sc config cloudidsvc start= disabled >nul 2>&1
sc config COMSysApp start= disabled >nul 2>&1
sc config ConsentUxUserSvc start= disabled >nul 2>&1
sc config CscService start= disabled >nul 2>&1
sc config dcsvc start= disabled >nul 2>&1
sc config defragsvc start= demand >nul 2>&1
sc config DeviceAssociationService start= disabled >nul 2>&1
sc config DeviceInstall start= disabled >nul 2>&1
sc config DevicePickerUserSvc start= disabled >nul 2>&1
sc config DevicesFlowUserSvc start= disabled >nul 2>&1
sc config DevQueryBroker start= disabled >nul 2>&1
sc config diagnosticshub.standardcollector.service start= disabled >nul 2>&1
sc config diagsvc start= disabled >nul 2>&1
sc config DispBrokerDesktopSvc start= auto >nul 2>&1
sc config DisplayEnhancementService start= disabled >nul 2>&1
sc config DmEnrollmentSvc start= disabled >nul 2>&1
sc config dmwappushservice start= disabled >nul 2>&1
sc config dot3svc start= disabled >nul 2>&1
sc config DsmSvc start= disabled >nul 2>&1
sc config DsSvc start= disabled >nul 2>&1
sc config Eaphost start= disabled >nul 2>&1
sc config edgeupdate start= disabled >nul 2>&1
sc config edgeupdatem start= disabled >nul 2>&1
sc config EFS start= disabled >nul 2>&1
sc config EventSystem start= demand >nul 2>&1
sc config fdPHost start= disabled >nul 2>&1
sc config FDResPub start= disabled >nul 2>&1
sc config fhsvc start= disabled >nul 2>&1
sc config FontCache start= disabled >nul 2>&1
sc config FrameServer start= disabled >nul 2>&1
sc config FrameServerMonitor start= disabled >nul 2>&1
sc config GameInputSvc start= disabled >nul 2>&1
sc config GraphicsPerfSvc start= disabled >nul 2>&1
sc config hpatchmon start= disabled >nul 2>&1
sc config hidserv start= disabled >nul 2>&1
sc config HvHost start= disabled >nul 2>&1
sc config icssvc start= disabled >nul 2>&1
sc config IKEEXT start= disabled >nul 2>&1
sc config InventorySvc start= disabled >nul 2>&1
sc config IpxlatCfgSvc start= disabled >nul 2>&1
sc config KtmRm start= disabled >nul 2>&1
sc config LanmanServer start= disabled >nul 2>&1
sc config LanmanWorkstation start= disabled >nul 2>&1
sc config lfsvc start= disabled >nul 2>&1
sc config LocalKdc start= disabled >nul 2>&1
sc config LicenseManager start= disabled >nul 2>&1
sc config lltdsvc start= disabled >nul 2>&1
sc config lmhosts start= disabled >nul 2>&1
sc config LxpSvc start= disabled >nul 2>&1
sc config MapsBroker start= disabled >nul 2>&1
sc config McpManagementService start= disabled >nul 2>&1
sc config McmSvc start= disabled >nul 2>&1
sc config MessagingService start= disabled >nul 2>&1
sc config midisrv start= disabled >nul 2>&1
sc config MSDTC start= disabled >nul 2>&1
sc config MSiSCSI start= disabled >nul 2>&1
sc config NaturalAuthentication start= disabled >nul 2>&1
sc config NcaSvc start= disabled >nul 2>&1
sc config NcbService start= disabled >nul 2>&1
sc config NcdAutoSetup start= disabled >nul 2>&1
sc config Netlogon start= disabled >nul 2>&1
sc config NetSetupSvc start= disabled >nul 2>&1
sc config NetTcpPortSharing start= disabled >nul 2>&1
sc config NPSMSvc start= disabled >nul 2>&1
sc config OneSyncSvc start= disabled >nul 2>&1
sc config p2pimsvc start= disabled >nul 2>&1
sc config p2psvc start= disabled >nul 2>&1
sc config P9RdrService start= disabled >nul 2>&1
sc config PeerDistSvc start= disabled >nul 2>&1
sc config PenService start= disabled >nul 2>&1
sc config perceptionsimulation start= disabled >nul 2>&1
sc config PerfHost start= disabled >nul 2>&1
sc config PhoneSvc start= disabled >nul 2>&1
sc config PimIndexMaintenanceSvc start= disabled >nul 2>&1
sc config pla start= disabled >nul 2>&1
sc config PNRPAutoReg start= disabled >nul 2>&1
sc config PNRPsvc start= disabled >nul 2>&1
sc config PolicyAgent start= disabled >nul 2>&1
sc config PrintDeviceConfigurationService start= disabled >nul 2>&1
sc config PrintNotify start= disabled >nul 2>&1
sc config PrintScanBrokerService start= disabled >nul 2>&1
sc config QWAVE start= disabled >nul 2>&1
sc config RasAuto start= disabled >nul 2>&1
sc config RasMan start= disabled >nul 2>&1
sc config refsdedupsvc start= disabled >nul 2>&1
sc config RemoteAccess start= disabled >nul 2>&1
sc config RemoteRegistry start= disabled >nul 2>&1
sc config RetailDemo start= disabled >nul 2>&1
sc config RmSvc start= disabled >nul 2>&1
sc config RpcLocator start= disabled >nul 2>&1
sc config SCardSvr start= disabled >nul 2>&1
sc config ScDeviceEnum start= disabled >nul 2>&1
sc config SCPolicySvc start= disabled >nul 2>&1
sc config SDRSVC start= disabled >nul 2>&1
sc config seclogon start= disabled >nul 2>&1
sc config SENS start= disabled >nul 2>&1
sc config Sense start= disabled >nul 2>&1
sc config SensorDataService start= disabled >nul 2>&1
sc config SensorService start= disabled >nul 2>&1
sc config SensrSvc start= disabled >nul 2>&1
sc config SEMgrSvc start= disabled >nul 2>&1
sc config SessionEnv start= disabled >nul 2>&1
sc config SharedAccess start= disabled >nul 2>&1
sc config SharedRealitySvc start= disabled >nul 2>&1
sc config ShellHWDetection start= disabled >nul 2>&1
sc config shpamsvc start= disabled >nul 2>&1
sc config SmsRouter start= disabled >nul 2>&1
sc config smphost start= disabled >nul 2>&1
sc config SNMPTrap start= disabled >nul 2>&1
sc config spectrum start= disabled >nul 2>&1
sc config Spooler start= disabled >nul 2>&1
sc config SSDPSRV start= disabled >nul 2>&1
sc config ssh-agent start= disabled >nul 2>&1
sc config SstpSvc start= disabled >nul 2>&1
sc config stisvc start= disabled >nul 2>&1
sc config StorSvc start= disabled >nul 2>&1
sc config svsvc start= disabled >nul 2>&1
sc config TapiSrv start= disabled >nul 2>&1
sc config TermService start= disabled >nul 2>&1
sc config Themes start= disabled >nul 2>&1
sc config TieringEngineService start= disabled >nul 2>&1
sc config TokenBroker start= disabled >nul 2>&1
sc config TrkWks start= disabled >nul 2>&1
sc config TroubleshootingSvc start= disabled >nul 2>&1
sc config tzautoupdate start= disabled >nul 2>&1
sc config UevAgentService start= disabled >nul 2>&1
sc config uhssvc start= disabled >nul 2>&1
sc config UmRdpService start= disabled >nul 2>&1
sc config UnistoreSvc start= disabled >nul 2>&1
sc config upnphost start= disabled >nul 2>&1
sc config UserDataSvc start= disabled >nul 2>&1
sc config VacSvc start= disabled >nul 2>&1
sc config VaultSvc start= disabled >nul 2>&1
sc config vds start= disabled >nul 2>&1
sc config vmicguestinterface start= disabled >nul 2>&1
sc config vmicheartbeat start= disabled >nul 2>&1
sc config vmickvpexchange start= disabled >nul 2>&1
sc config vmicrdv start= disabled >nul 2>&1
sc config vmicshutdown start= disabled >nul 2>&1
sc config vmictimesync start= disabled >nul 2>&1
sc config vmicvmsession start= disabled >nul 2>&1
sc config vmicvss start= disabled >nul 2>&1
sc config W32Time start= disabled >nul 2>&1
sc config WalletService start= disabled >nul 2>&1
sc config WarpJITSvc start= disabled >nul 2>&1
sc config wbengine start= disabled >nul 2>&1
sc config WbioSrvc start= disabled >nul 2>&1
sc config Wcmsvc start= disabled >nul 2>&1
sc config wcncsvc start= disabled >nul 2>&1
sc config WdiServiceHost start= disabled >nul 2>&1
sc config WdiSystemHost start= disabled >nul 2>&1
sc config WebClient start= disabled >nul 2>&1
sc config webthreatdefusersvc start= disabled >nul 2>&1
sc config webthreatdefsvc start= disabled >nul 2>&1
sc config Wecsvc start= disabled >nul 2>&1
sc config WEPHOSTSVC start= disabled >nul 2>&1
sc config wercplsupport start= disabled >nul 2>&1
sc config WerSvc start= disabled >nul 2>&1
sc config WFDSConMgrSvc start= disabled >nul 2>&1
sc config whesvc start= disabled >nul 2>&1
sc config WiaRpc start= disabled >nul 2>&1
sc config WinRM start= disabled >nul 2>&1
sc config wisvc start= disabled >nul 2>&1
if "!DISABLE_WIFI!"=="1" (sc config WlanSvc start= disabled >nul 2>&1) else (sc config WlanSvc start= auto >nul 2>&1)
sc config wlidsvc start= disabled >nul 2>&1
sc config wlpasvc start= disabled >nul 2>&1
sc config WManSvc start= disabled >nul 2>&1
sc config wmiApSrv start= disabled >nul 2>&1
sc config WMPNetworkSvc start= disabled >nul 2>&1
sc config workfolderssvc start= disabled >nul 2>&1
sc config WpcMonSvc start= disabled >nul 2>&1
sc config WPDBusEnum start= disabled >nul 2>&1
sc config WpnUserService start= disabled >nul 2>&1
sc config WpnService start= disabled >nul 2>&1
sc config wuqisvc start= disabled >nul 2>&1
sc config WSAIFabricSvc start= disabled >nul 2>&1
sc config WSearch start= disabled >nul 2>&1
sc config WwanSvc start= disabled >nul 2>&1
sc config XblAuthManager start= disabled >nul 2>&1
sc config XblGameSave start= disabled >nul 2>&1
sc config XboxGipSvc start= disabled >nul 2>&1
sc config XboxNetApiSvc start= disabled >nul 2>&1

reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesExpiryTime" /t REG_SZ /d "2099-12-31T23:59:59Z" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesStartTime" /t REG_SZ /d "2026-01-01T00:00:00Z" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesStartTime" /t REG_SZ /d "2026-01-01T00:00:00Z" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesStartTime" /t REG_SZ /d "2026-01-01T00:00:00Z" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesEndTime" /t REG_SZ /d "2099-12-31T23:59:59Z" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesEndTime" /t REG_SZ /d "2099-12-31T23:59:59Z" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesRequested" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "IsExpanded" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stisvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\UpdateModelTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\USO_UxBroker" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Report policies" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Work" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\Scheduled Start" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\Automatic App Update" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WaaSMedic\PerformRemediation" /Disable >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableWindowsUpdateAccess" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DoNotConnectToWindowsUpdateInternetLocations" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "SetDisableUXWUAccess" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoRebootWithLoggedOnUsers" /t REG_DWORD /d 1 /f >nul 2>&1

powershell -NoProfile -Command "$services = @('wuauserv', 'stisvc', 'WaaSMedicSvc'); foreach ($service in $services) { $path = 'HKLM:\SYSTEM\CurrentControlSet\Services\' + $service; if (Test-Path $path) { $acl = Get-Acl $path; $arguments = New-Object System.Security.AccessControl.RegistryAccessRule('Everyone', 'FullControl', 'Allow'); $acl.SetAccessRule($arguments); Set-Acl $path $acl; Set-ItemProperty -Path $path -Name 'Start' -Value 4 } }" >nul 2>&1
goto :WU_FINISH

:WU_SHIELD
echo [*] Configuring Windows Update with Anti-Revert Shield...
net start wuauserv >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /Enable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task" /Enable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\UpdateModelTask" /Enable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\USO_UxBroker" /Enable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Report policies" /Enable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Work" /Enable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\Scheduled Start" /Enable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\Automatic App Update" /Enable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WaaSMedic\PerformRemediation" /Enable >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesRequested" /t REG_DWORD /d 0 /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesExpiryTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesStartTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesStartTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesStartTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesEndTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesEndTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableWindowsUpdateAccess" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DoNotConnectToWindowsUpdateInternetLocations" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "TargetReleaseVersion" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 0 /f >nul 2>&1
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v DisplayVersion 2^>nul') do (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "TargetReleaseVersionInfo" /t REG_SZ /d "%%a" /f >nul 2>&1
)

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoRebootWithLoggedOnUsers" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "SetDisableUXWUAccess" /t REG_DWORD /d 0 /f >nul 2>&1

:WU_FINISH

if exist "%SystemRoot%\SysWOW64\OneDriveSetup.exe" (
    "%SystemRoot%\SysWOW64\OneDriveSetup.exe" /uninstall >nul 2>&1
) else if exist "%SystemRoot%\System32\OneDriveSetup.exe" (
    "%SystemRoot%\System32\OneDriveSetup.exe" /uninstall >nul 2>&1
)

rd "%USERPROFILE%\OneDrive" /s /q >nul 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /s /q >nul 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /s /q >nul 2>&1
reg delete "HKCU\Software\Microsoft\OneDrive" /f >nul 2>&1
reg add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{04271989-C4D2-9950-BDF1-DD622415241E}" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F02C1A0D-BE21-4350-88B0-7367FC96EFF3}" /f >nul 2>&1
taskkill /f /im OneDrive.exe >nul 2>&1
winget uninstall --silent --accept-source-agreements Microsoft.OneDrive >nul 2>&1
reg load "hku\Default" "C:\Users\Default\NTUSER.DAT" >nul 2>&1
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f >nul 2>&1
reg unload "hku\Default" >nul 2>&1
del /f /q "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" >nul 2>&1

rd /s /q "C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization" >nul 2>&1
DISM.exe /Online /Set-ReservedStorageState /State:Disabled >nul 2>&1
rd /s /q "%WINDIR%\Logs" >nul 2>&1
rd /s /q "%WINDIR%\Installer\$PatchCache$" >nul 2>&1
rd /s /q "%SystemDrive%\OneDriveTemp" >nul 2>&1
rd /s /q "%LocalAppData%\Temp" >nul 2>&1
rd /s /q "%SystemRoot%\System32\SleepStudy" >nul 2>&1
del /f /s /q "C:\Windows\Temp\*.*" >nul 2>&1
del /f /q "C:\Windows\Prefetch\*.*" >nul 2>&1
rd /s /q "C:\Windows\SoftwareDistribution\Download" >nul 2>&1
md "C:\Windows\SoftwareDistribution\Download" >nul 2>&1
del /f /s /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
del /f /q "%LOCALAPPDATA%\IconCache.db" >nul 2>&1
del /f /s /q "%LocalAppData%\NVIDIA\DXCache\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\AMD\DXCache\*.*" >nul 2>&1
rd /s /q "%LocalAppData%\Temp\mozilla-temp-files" >nul 2>&1
rd /s /q "%LOCALAPPDATA%\Microsoft\GameDVR" >nul 2>&1
rd /s /q "%LOCALAPPDATA%\Microsoft\Edge" >nul 2>&1
del /s /f /q "C:\Windows\Logs\*.log" >nul 2>&1
del /f /s /q "C:\Windows\inf\*.log" >nul 2>&1
del /f /s /q "C:\ProgramData\Microsoft\Windows\WER\*.*" >nul 2>&1
rd /s /q "C:\ProgramData\Microsoft\Windows\WER\ReportArchive" >nul 2>&1
rd /s /q "C:\ProgramData\Microsoft\Windows\WER\ReportQueue" >nul 2>&1
del /q /f /s "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache\*" >nul 2>&1
del /q /f /s "%AppData%\Mozilla\Firefox\Profiles\*.default\cache2\*" >nul 2>&1
del /q /f /s "%AppData%\Microsoft\Windows\Recent\*" >nul 2>&1
rd /s /q "%AppData%\Discord\Cache" >nul 2>&1
rd /s /q "%AppData%\Discord\Code Cache" >nul 2>&1
rd /s /q "%SystemDrive%\$GetCurrent" >nul 2>&1
rd /s /q "%SystemDrive%\$Windows.~BT" >nul 2>&1
rd /s /q "%SystemDrive%\$Windows.~WS" >nul 2>&1
del /f /q "C:\Windows\System32\DriverStore\FileRepository\*.tmp" >nul 2>&1
del /f /q "C:\Windows\System32\DriverStore\FileRepository\*.log" >nul 2>&1
del /f /s /q "C:\Windows\panther\*.*" >nul 2>&1
rd /s /q "C:\Windows\panther" >nul 2>&1
del /f /q %windir%\inf\setupapi.dev.log >nul 2>&1
del /f /q %windir%\inf\setupapi.setup.log >nul 2>&1
del /f /s /q %windir%\System32\DriverStore\Temp\*.* >nul 2>&1
rd /s /q "%LocalAppData%\Microsoft\Windows\WebCache" >nul 2>&1
md "%LocalAppData%\Microsoft\Windows\WebCache" >nul 2>&1
rd /s /q "%LocalAppData%\Spotify\Data" >nul 2>&1
md "%LocalAppData%\Spotify\Data" >nul 2>&1
del /f /s /q "%ProgramData%\USOPrivate\UpdateStore" >nul 2>&1
ipconfig /release >nul 2>&1
ipconfig /renew >nul 2>&1
arp -d * >nul 2>&1
nbtstat -R >nul 2>&1
nbtstat -RR >nul 2>&1
ipconfig /flushdns >nul 2>&1
ipconfig /registerdns >nul 2>&1

powercfg /change monitor-timeout-ac 0 >nul 2>&1
powercfg /change monitor-timeout-dc 0 >nul 2>&1
powercfg /change standby-timeout-ac 0 >nul 2>&1
powercfg /change standby-timeout-dc 0 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMIN 100 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX 100 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PERFBOOSTMODE 2 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PERFEPP 0 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 100 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMAXCORES 100 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR SYSCOOLPOL 1 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT SUB_PCIEXPRESS ASPM 0 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT SUB_DISK DISKIDLE 0 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 d4e98f31-5ffe-4ce1-be31-1b38b384c009 0 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT 19cbb8fa-5279-450e-9fac-8a3d5fedd0c1 12bbebe6-58d6-4636-95bb-3217ef867c1a 0 >nul 2>&1
powercfg /setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMIN 100 >nul 2>&1
powercfg /setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX 100 >nul 2>&1
powercfg /setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR PERFBOOSTMODE 2 >nul 2>&1
powercfg /setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR PERFEPP 0 >nul 2>&1
powercfg /setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 100 >nul 2>&1
powercfg /setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMAXCORES 100 >nul 2>&1
powercfg /setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR SYSCOOLPOL 1 >nul 2>&1
powercfg /setdcvalueindex SCHEME_CURRENT SUB_PCIEXPRESS ASPM 0 >nul 2>&1
powercfg /setdcvalueindex SCHEME_CURRENT SUB_DISK DISKIDLE 0 >nul 2>&1
powercfg /setdcvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >nul 2>&1
powercfg /setdcvalueindex SCHEME_CURRENT 2a737441-1930-4402-8d77-b2bebba308a3 d4e98f31-5ffe-4ce1-be31-1b38b384c009 0 >nul 2>&1
powercfg /setdcvalueindex SCHEME_CURRENT 19cbb8fa-5279-450e-9fac-8a3d5fedd0c1 12bbebe6-58d6-4636-95bb-3217ef867c1a 0 >nul 2>&1
powercfg -setactive SCHEME_CURRENT >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v "TimerCoalescing" /t REG_BINARY /d "0000000000000000000000000000000000000000000000000000000000000000" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "AllowHibernate" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergySaverState" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "MSDisabled" /t REG_DWORD /d "1" /f >nul 2>&1
powershell -NoProfile -Command "Get-WmiObject MSPowerDeviceEnable -Namespace root\wmi | ForEach-Object { $_.Enable = $false; $_.psbase.Put() }" >nul 2>&1

schtasks /delete /tn "MicrosoftEdgeUpdateTaskMachineUA" /f >nul 2>&1
schtasks /delete /tn "MicrosoftEdgeUpdateTaskMachineCore" /f >nul 2>&1
schtasks /delete /tn "MicrosoftEdgeUpdateBrowserReplacementServer" /f >nul 2>&1
schtasks /Delete /TN "Microsoft\Windows\Maps\MapsUpdateTask" /F >nul 2>&1
schtasks /Delete /TN "Microsoft\Windows\Maps\MapsToastTask" /F >nul 2>&1
schtasks /Delete /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /F >nul 2>&1
schtasks /Delete /TN "Microsoft\Windows\Shell\FamilySafetyRefreshTask" /F >nul 2>&1
schtasks /Delete /TN "Microsoft\Windows\Application Experience\PcaPatchDbTask" /F >nul 2>&1

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v "Value" /t REG_SZ /d "Allow" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v LetAppsAccessMicrophone /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" /v "Value" /t REG_SZ /d "Allow" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "Deny" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v "Value" /t REG_SZ /d "Allow" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" /v "Value" /t REG_SZ /d "Allow" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsRunInBackground" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v "Status" /t REG_DWORD /d "0" /f >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AppModel" /v Start /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" /v Start /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Circular Kernel Context Logger" /v "Start" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" /v Start /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger" /v Start /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DiagLog" /v "Start" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\FaultTolerantHeap" /v "Start" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\GraphicsPerf" /v "Start" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\NtfsLog" /v Start /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\ReadyBoot" /v "Start" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TCPIPTrafficLogger" /v "Start" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\UBPM" /v Start /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WdiContextLog" /v "Start" /t REG_DWORD /d 0 /f >nul 2>&1
del /f /q "C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" >nul 2>&1
echo. > "C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl"
icacls "C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" /deny SYSTEM:(F) >nul 2>&1
icacls "C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" /deny "EVERYONE":(F) >nul 2>&1

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability" /v "TimeStampInterval" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability" /v "LastAliveStamp" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "NMICrashDump" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "LogEvent" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "SendAlert" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WerSvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

reg add "HKCU\Console" /v "VirtualTerminalLevel" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility" /v DynamicScrollbars /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "5000" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "5000" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "50" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "FontSmoothing" /t REG_SZ /d "2" /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9e3e078012000000 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v SmoothScroll /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "Disabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.Windows.Photos_8wekyb3d8bbwe" /v "Disabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.Windows.Photos_8wekyb3d8bbwe" /v "DisabledByUser" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "DesktopProcess" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisablePreviewPane" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewAlphaSelect" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_TOASTS_ABOVE_LOCK" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Personalization\DesktopSlideshow" /v "Skip" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAMeetNow" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SystemSettings\AccountNotifications" /v "EnableAccountNotifications" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags" /v "AITEnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoLowDiskSpaceChecks" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "LinkResolveIgnoreLinkInfo" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DelayedDesktopSwitchTimeout" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" /v "ActivationType" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisablePCA" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableEngine" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\StorageSense" /v "AllowStorageSenseGlobal" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\Maps" /v "AutoUpdateEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d "122" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\ToggleKeys" /v "Flags" /t REG_SZ /d "58" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /t REG_SZ /d "" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarMn" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAl" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v "LaunchTo" /t REG_DWORD /d "1" >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewShadow" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /v "EnthusiastMode" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "SettingsPageVisibility" /t REG_SZ /d "hide:home" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v "EnableFeeds" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Education" /v "IsEducationEnvironment" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v "HideRecommendedSection" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\NewsAndInterests" /v "AllowNewsAndInterests" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "HideRecommendedSection" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d 100 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d 100 /f >nul 2>&1
reg add "HKCU\Control Panel\Keyboard" /v "KeyboardDelay" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Keyboard" /v "KeyboardSpeed" /t REG_SZ /d "31" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseSensitivity" /t REG_SZ /d "10" /f >nul 2>&1

reg add "HKCU\Control Panel\Desktop" /v PaintDesktopVersion /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "WaitForIdleState" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "01" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "1024" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "2048" /t REG_DWORD /d 30 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "04" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "32" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "02" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "128" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "08" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "256" /t REG_DWORD /d 0 /f >nul 2>&1

powershell -NoProfile -Command "Set-CimInstance -Query 'Select * from Win32_ComputerSystem' -Property @{AutomaticManagedPagefile=$False}" >nul 2>&1
powershell -NoProfile -Command "Set-CimInstance -Query 'Select * from Win32_PageFileSetting where Name=\"C:\\pagefile.sys\"' -Property @{InitialSize=8192; MaximumSize=16384}" >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\FTH" /v "CheckPointPeriod" /t REG_DWORD /d 4294967295 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\FTH" /v "CrashVelocity" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "DisableFTH" /t REG_SZ /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Wdf\Kmdf\Diagnostics" /v "RetrieveVerboseLogs" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Wdf\Wdf01000" /v "DbgBreakOnError" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Wdf\Wdf01000" /v "LogPages" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Wdf\Wdf01000" /v "VerboseOn" /t REG_DWORD /d 0 /f >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "8000" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\BootControl" /v "BootProgressAnimation" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PnP" /v "DisableTargetDeviceLogging" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PnP" /v "DeviceActionRequests" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Windows" /v "NoPopupsOnBoot" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Windows" /v "ErrorMode" /t REG_DWORD /d 2 /f >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Appinfo" /v "Start" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppReadiness" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthA2dp" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthLEEnum" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthMini" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHMODEM" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHPORT" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHUSB" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPSvc" /v "Start" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Csc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DeviceAssociationService" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DevicesFlowUserSvc" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DsmSvc" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DusmSvc" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\EventSystem" /v "Start" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\FDResPub" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\gpsvc" /v "Start" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\HPOSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\i8042prt" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\IKEEXT" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Microsoft_Bluetooth_AvrcpTransport" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\MidiSrv" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\mpssvc" /v "Start" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\msiserver" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Netprofm" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ossrs" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PimIndexMaintenanceSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SENS" /v "Start" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Themes" /v "Start" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UdkUserSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\whesvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WSService" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\xbgm" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
set "DRV_EXTRA=1394ohci AcpiDev acpipagr AcpiPmi acpitime amdsata amdsbs amdxata AppvVemgr arcsas atapi b06bdrv bam beep bowser cdfs cdrom cht4tiscsi cht4vbd circlass dam ebdrv fdc flpydisk gencounter HidIr hvcrash hvservice hyperkbd HyperVideo ItSas35i MEIx64 NdisCap NdisVirtualBus Ndu rdpbus scfilter sfloppy SgrmAgent SpatialGraphFilter Synth3dVsc TsUsbFlt TsUsbGD tsusbhub udfs UevAgentDriver umbus usbcir usbprint Vid vmgid vwifibus vwififlt vwifimp WacomPen wanarp wanarpv6"
for %%D in (%DRV_EXTRA%) do (
    reg query "HKLM\SYSTEM\CurrentControlSet\Services\%%D" >nul 2>&1 && reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%D" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
)

reg add "%POWER%" /v "PlatformAoAcOverride" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%POWER%" /v "PlatformRoleOverride" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%POWER%" /v "EventProcessorEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%POWER%" /v "HibernateEnabledDefault" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "EnablePerformanceStates" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "FrequencyToPerfStateThreshold" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "IdleResidencyDuration" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "PerfBoostState" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "ResponsivenessReductionThreshold" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "CpuIdle" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "CpuIdleThread" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "ThreadThrottleAdditiveLowOffset" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "ThreadThrottleAdditiveHighOffset" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "FastThrottle" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "LatencyThrottleOffset" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "PerfAutoSmoothing" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "PerfAutoSmoothingEnabled" /t REG_DWORD /d 0 /f >nul 2>&1

reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDXGI" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D12" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D11" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D10" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D9" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D8" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D7" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D6" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D5" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D4" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D3" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D2" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D1" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectDraw" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectSound" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectInput" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectPlay" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectShow" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectMusic" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectAnimation" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DRM" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DImmediateMode" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DRetainedMode" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DHardwareAbstractionLayer" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DReferenceRasterizer" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DNullRasterizer" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DRGBRasterizer" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DMMXRasterizer" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSE" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSE2" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSE3" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSSE3" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSE41" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSE42" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DAVX" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DAVX2" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DAVX512" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DFMA" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DFMA3" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DFMA4" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DBMI1" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DBMI2" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DTBM" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DLZCNT" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DPOPCNT" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DRDRAND" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DRDSEED" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DADX" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DMPX" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSGX" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DCET" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBT" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSS" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSB" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSBD" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBPB" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "MinQueueDepth" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameQueueSize" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameQueueDepth" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameQueuePolicy" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameQueueTimeout" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameQueueThreshold" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PreemptionAffinity" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ12Priority" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "InterruptPrioritySeparation" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "HeapSegmentCommit" /t REG_DWORD /d 1048576 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "HeapSegmentReserve" /t REG_DWORD /d 16777216 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "Heap_ForceLFH" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "FastDeadlockReliance" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "ParallelProcessorMinimum" /t REG_DWORD /d 100 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "LFH_Aggressive_Enable" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "WorkerFactoryThreadIdleTimeout" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MaximumDpcStackDepth" /t REG_DWORD /d 512 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MinimumDpcRate" /t REG_DWORD /d 100 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "InterruptTimerRate" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DpcWatchdogProfileOffset" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "GlobalTimerResolutionRequests" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "DynamicHeteroCpuPolicyMask" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "DefaultDynamicHeteroCpuPolicy" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "DynamicHeteroCpuPolicyImportant" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "DynamicHeteroCpuPolicyImportantShort" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "DynamicHeteroCpuPolicyImportantPriority" /t REG_DWORD /d "8" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "SerializeTimerExpiration" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "EnablePerCpuClockTickScheduling" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "TimerCheckFlags" /t REG_DWORD /d "0" /f >nul 2>&1

reg add "%MM%" /v "SystemCacheLimit" /t REG_DWORD /d 0xFFFFFFFF /f >nul 2>&1
reg add "%MM%" /v "VirtualizationFlags" /t REG_DWORD /d 0 /f >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Enum\SCSI\Disk&Ven_NVMe\Device Parameters\Disk" /v "CacheIsPowerProtected" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\SCSI\Disk&Ven_NVMe\Device Parameters\Disk" /v "UserWriteCacheSetting" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\disk" /v "TimeoutValue" /t REG_DWORD /d 10 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Partmgr\Parameters" /v "IoLatencyCap" /t REG_DWORD /d 1 /f >nul 2>&1

powershell -NoProfile -Command "$edgePath = (Get-Item 'C:\Program Files (x86)\Microsoft\Edge\Application\*\Installer\setup.exe').FullName; Start-Process $edgePath -ArgumentList '--uninstall', '--system-level', '--verbose-logging', '--force-uninstall' -Wait" >nul 2>&1

rmdir /s /q "C:\Program Files (x86)\Microsoft\EdgeUpdate" >nul 2>&1

taskkill /f /im MicrosoftEdgeUpdate.exe >nul 2>&1
taskkill /f /im msedge.exe >nul 2>&1
rd /s /q "C:\Program Files (x86)\Microsoft\Edge" >nul 2>&1
rd /s /q "C:\Program Files (x86)\Microsoft\EdgeCore" >nul 2>&1
rd /s /q "C:\Program Files (x86)\Microsoft\Temp" >nul 2>&1
del /f /q "%AppData%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk" >nul 2>&1
del /f /q "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk" >nul 2>&1
del /f /q "%AppData%\Microsoft\Internet Explorer\Quick Launch\Microsoft Edge.lnk" >nul 2>&1
del /f /q "C:\Users\Public\Desktop\Microsoft Edge.lnk" >nul 2>&1
reg delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge Update" /f >nul 2>&1
takeown /f "C:\Windows\SystemApps\Microsoft.MicrosoftEdgeDevToolsClient_8wekyb3d8bbwe" /r /d y >nul 2>&1
icacls "C:\Windows\SystemApps\Microsoft.MicrosoftEdgeDevToolsClient_8wekyb3d8bbwe" /grant Administrators:F /t >nul 2>&1
rd /s /q "C:\Windows\SystemApps\Microsoft.MicrosoftEdgeDevToolsClient_8wekyb3d8bbwe" >nul 2>&1
for /f "tokens=1" %%V in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" ^| findstr /I "MicrosoftEdge" ^| findstr /V "HKEY_"') do (
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "%%V" /f >nul 2>&1
)
for /f "tokens=2 delims=:" %%S in ('sc query state^= all ^| findstr /i "SERVICE_NAME" ^| findstr /i "Edge"') do (
    set "EDGE_SVC=%%S"
    set "EDGE_SVC=!EDGE_SVC:~1!"
    net stop "!EDGE_SVC!" >nul 2>&1
    sc config "!EDGE_SVC!" start= disabled >nul 2>&1
    sc delete "!EDGE_SVC!" >nul 2>&1
)

winget uninstall cortana --accept-source-agreements --accept-package-agreements >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensorService" /v Start /t REG_DWORD /d 3 /f >nul 2>&1

taskkill /f /im SearchHost.exe >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Control\BackupRestore\FilesNotToSnapshot" /v "OneDriveSetupLogs" /t REG_MULTI_SZ /d "%ProgramFiles%\Microsoft OneDrive\setup\logs\* /s" /f >nul 2>&1

diskperf -N >nul 2>&1
verifier /reset >nul 2>&1

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\7zFM.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\7zG.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\obs64.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\qemu-system-x86_64.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WinRAR.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\BetGame.exe\PerfOptions" /v "WorkingSetLimitInKB" /t REG_DWORD /d 0 /f >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v "DisabledComponents" /t REG_DWORD /d "255" /f >nul 2>&1
powershell -NoProfile -Command "Disable-NetAdapterBinding -Name '*' -ComponentID ms_tcpip6" >nul 2>&1
netsh interface teredo set state disabled >nul 2>&1
netsh int tcp set global autotuninglevel=normal >nul 2>&1
netsh int tcp set global rss=enabled >nul 2>&1
netsh int tcp set global rsc=disabled >nul 2>&1
netsh int tcp set global ecncapability=disabled >nul 2>&1
netsh int tcp set global timestamps=disabled >nul 2>&1
netsh int tcp set global initialrto=2000 >nul 2>&1
netsh int tcp set global nonsackrttresiliency=disabled >nul 2>&1
netsh int tcp set global maxsynretransmissions=2 >nul 2>&1
netsh int tcp set global fastopen=enabled >nul 2>&1
netsh int tcp set global pacingprofile=off >nul 2>&1
netsh int tcp set heuristics disabled >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DefaultTTL" /t REG_DWORD /d 64 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "Tcp1323Opts" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxUserPort" /t REG_DWORD /d 65534 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpTimedWaitDelay" /t REG_DWORD /d 30 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUDiscovery" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SackOpts" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxDataRetransmissions" /t REG_DWORD /d 5 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "FastSendDatagramThreshold" /t REG_DWORD /d 64000 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "IgnorePushBitOnReceives" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "NonBlockingSendSpecialBuffering" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "CacheHashTableBucketSize" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "CacheHashTableSize" /t REG_DWORD /d 384 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "MaxCacheEntryTtlLimit" /t REG_DWORD /d 64000 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "MaxSOACacheEntryTtlLimit" /t REG_DWORD /d 301 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v "NonBestEffortLimit" /t REG_DWORD /d 0 /f >nul 2>&1
for /f "tokens=*" %%K in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" 2^>nul ^| findstr /i "HKEY"') do (
    reg add "%%K" /v "TcpAckFrequency" /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%K" /v "TCPNoDelay" /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%K" /v "TcpDelAckTicks" /t REG_DWORD /d 0 /f >nul 2>&1
)
powershell -NoProfile -Command "Get-NetAdapter -Physical | ForEach-Object { Disable-NetAdapterPowerManagement -Name $_.Name -NoRestart -ErrorAction SilentlyContinue }" >nul 2>&1
powershell -NoProfile -Command "foreach($p in 'Energy-Efficient Ethernet','Green Ethernet','Power Saving Mode','Advanced EEE','Ultra Low Power Mode'){ Set-NetAdapterAdvancedProperty -Name '*' -DisplayName $p -DisplayValue 'Disabled' -ErrorAction SilentlyContinue }" >nul 2>&1

powershell -NoProfile -Command "$dis=[byte[]](3,0,0,0,0,0,0,0,0,0,0,0); $map=@(@('HKCU:\Software\Microsoft\Windows\CurrentVersion\Run','HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run'),@('HKLM:\Software\Microsoft\Windows\CurrentVersion\Run','HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run'),@('HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Run','HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run32')); foreach ($m in $map) { if (Test-Path $m[0]) { if (-not (Test-Path $m[1])) { New-Item -Path $m[1] -Force | Out-Null }; (Get-Item $m[0]).GetValueNames() | Where-Object { $_ } | ForEach-Object { Set-ItemProperty -Path $m[1] -Name $_ -Value $dis -Type Binary } } }" >nul 2>&1
for %%F in ("%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\*") do (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\StartupFolder" /v "%%~nxF" /t REG_BINARY /d 030000000000000000000000 /f >nul 2>&1
)
for %%F in ("%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\*") do (
    reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\StartupFolder" /v "%%~nxF" /t REG_BINARY /d 030000000000000000000000 /f >nul 2>&1
)

set "HEX_FILES_BACKUP=%USERPROFILE%\Desktop\hexplus_backup_files"
mkdir "%HEX_FILES_BACKUP%" >nul 2>&1

reg add "HKLM\System\ControlSet001\Control\FeatureManagement\Overrides\8\1387020943" /v "EnabledStateOptions" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\System\ControlSet001\Control\FeatureManagement\Overrides\8\1387020943" /v "EnabledState" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\System\ControlSet001\Control\FeatureManagement\Overrides\8\1387020943" /v "Variant" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\System\ControlSet001\Control\FeatureManagement\Overrides\8\1387020943" /v "VariantPayload" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\System\ControlSet001\Control\FeatureManagement\Overrides\8\1387020943" /v "VariantPayloadKind" /t REG_DWORD /d "0" /f >nul 2>&1

for %%S in ("C:\Windows\SystemApps\Microsoft.LockApp_cw5n1h2txyewy\LockApp.exe" "C:\Windows\System32\smartscreen.exe" "C:\Windows\SystemApps\Microsoft.Windows.AppRep.ChxApp_cw5n1h2txyewy\CHXSmartScreen.exe" "C:\Windows\System32\mobsync.exe" "C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\CrossDeviceResume.exe") do (
    if exist "%%~S" (
        takeown /F "%%~S" >nul 2>&1
        icacls "%%~S" /grant administrators:F >nul 2>&1
        copy /Y "%%~S" "%HEX_FILES_BACKUP%" >nul 2>&1
        del "%%~S" /s /f /q >nul 2>&1
    )
)

for %%X in ("GameBarPresenceWriter.exe" "GameBarPresenceWriter.proxy.dll" "GameChatOverlayExt.dll" "GameChatTranscription.dll" "GamePanel.exe" "GamePanelExternalHook.dll" "gamestreamingext.dll" "GameSystemToastIcon.contrast-white.png" "GameSystemToastIcon.png" "gameux.dll" "gamingtcui.dll" "XblAuthManager.dll" "XblAuthManagerProxy.dll" "XblAuthTokenBrokerExt.dll" "XblGameSave.dll" "XblGameSaveExt.dll" "XblGameSaveProxy.dll" "XblGameSaveTask.exe" "XboxNetApiSvc.dll" "Windows.Gaming.Preview.dll" "Windows.Gaming.UI.GameBar.dll" "Windows.Gaming.XboxLive.Storage.dll") do (
    if exist "C:\Windows\System32\%%~X" (
        takeown /F "C:\Windows\System32\%%~X" >nul 2>&1
        icacls "C:\Windows\System32\%%~X" /grant administrators:F >nul 2>&1
        copy /Y "C:\Windows\System32\%%~X" "%HEX_FILES_BACKUP%" >nul 2>&1
        del "C:\Windows\System32\%%~X" /s /f /q >nul 2>&1
    )
)

powershell -NoProfile -Command "Set-MpPreference -ScanAvgCPULoadFactor 20 -EnableLowCpuPriority $true -DisableCatchupFullScan $true -DisableCatchupQuickScan $true -ScanOnlyIfIdleEnabled $true" >nul 2>&1
powershell -NoProfile -Command "Disable-MMAgent -ApplicationPreLaunch" >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f >nul 2>&1

for %%A in (
    "Microsoft.549981C3F5F10"
    "MicrosoftWindows.Client.WebExperience"
    "Microsoft.3DBuilder"
    "Microsoft.Office.OneNote"
    "Microsoft.MicrosoftPowerBIForWindows"
    "Microsoft.NetworkSpeedTest"
    "Microsoft.WindowsReadingList"
    "Microsoft.Messaging"
    "Microsoft.WindowsFeedback"
    "Microsoft.Print3D"
    "Microsoft.MSPaint"
    "Microsoft.Whiteboard"
    "Microsoft.549981C3F5F10~"
) do (
    powershell -NoProfile -Command "Get-AppxPackage *%%~A* | Remove-AppxPackage" >nul 2>&1
    powershell -NoProfile -Command "Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -like '*%%~A*'} | Remove-AppxProvisionedPackage -Online" >nul 2>&1
)

reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v "EnableFeeds" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d 0 /f >nul 2>&1
taskkill /f /im Widgets.exe >nul 2>&1
taskkill /f /im WidgetService.exe >nul 2>&1

set "SC_EXTREME=PimIndexMaintenanceSvc OneSyncSvc MessagingService CaptureService cbdhsvc DusmSvc WalletService WpnUserService DevicesFlowUserSvc PrintWorkflowUserSvc UevAgentService ConsentUxUserSvc ScreenshotService"
for %%S in (%SC_EXTREME%) do (
    sc config %%S start= disabled >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%S" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
)

schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Shell\IndexerAutomaticMaintenance" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Chkdsk\ProactiveScan" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Clip\License Validation" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable >nul 2>&1

for %%P in (Widgets WidgetService YourPhone PeopleApp SkypeApp SkypeBackgroundHost GameBar GameBarFTServer msteams OneDrive Cortana) do (
    taskkill /f /im "%%P.exe" >nul 2>&1
)

reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /t REG_DWORD /d 5 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v "EnableMulticast" /t REG_DWORD /d 0 /f >nul 2>&1
for /f "tokens=*" %%K in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces" 2^>nul ^| findstr /i "Tcpip_"') do (
    reg add "%%K" /v "NetbiosOptions" /t REG_DWORD /d 2 /f >nul 2>&1
)
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d 255 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /v "DisableAutoplay" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "AllowClipboardHistory" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "AllowCrossDeviceClipboard" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "StartupDelayInMSec" /t REG_DWORD /d 0 /f >nul 2>&1
powershell -NoProfile -Command "foreach($p in 'Interrupt Moderation','Flow Control','Large Send Offload v2 (IPv4)','Large Send Offload v2 (IPv6)','Wake on Magic Packet','Wake on pattern match'){ Set-NetAdapterAdvancedProperty -Name '*' -DisplayName $p -DisplayValue 'Disabled' -ErrorAction SilentlyContinue }" >nul 2>&1

set "CPU_VENDOR=Unknown"
set "CPU_MODEL="

for /f "tokens=2,*" %%A in ('reg query "HKLM\HARDWARE\DESCRIPTION\System\CentralProcessor\0" /v "VendorIdentifier" 2^>nul ^| findstr /i "VendorIdentifier"') do (
    echo %%B | findstr /i "AuthenticAMD" >nul && set "CPU_VENDOR=AMD"
    echo %%B | findstr /i "GenuineIntel" >nul && set "CPU_VENDOR=INTEL"
)
for /f "tokens=2,*" %%A in ('reg query "HKLM\HARDWARE\DESCRIPTION\System\CentralProcessor\0" /v "ProcessorNameString" 2^>nul ^| findstr /i "ProcessorNameString"') do (
    set "CPU_MODEL=%%B"
)

if "!CPU_VENDOR!"=="Unknown" (
    for /f "tokens=*" %%A in ('powershell -NoProfile -Command "(Get-CimInstance Win32_Processor -ErrorAction SilentlyContinue | Select-Object -First 1).Manufacturer" 2^>nul') do (
        echo %%A | findstr /i "AMD" >nul && set "CPU_VENDOR=AMD"
        echo %%A | findstr /i "Intel" >nul && set "CPU_VENDOR=INTEL"
    )
)

if defined CPU_MODEL (
    echo CPU Detected: !CPU_VENDOR! [!CPU_MODEL!]
) else (
    echo CPU Detected: !CPU_VENDOR!
)

echo ===================================================
echo PHASE 2: GPU DETECTION
echo ===================================================

set "GPU1_VENDOR=None"
set "GPU1_NAME="
set "GPU2_VENDOR=None"
set "GPU2_NAME="
set "HAS_INTEL_GPU=0"
set "HAS_NVIDIA_GPU=0"
set "HAS_AMD_GPU=0"
set "HAS_DGPU=0"
set /a count=0

for /f "tokens=*" %%K in ('reg query "%GPU_CLASS_KEY%" /s /v "DriverDesc" 2^>nul ^| findstr /i "HKEY_"') do (
    set "CURRENT_KEY=%%K"
    set "DEV_VENDOR=Unknown"
    set "DEV_DESC="

    for /f "tokens=2,*" %%A in ('reg query "!CURRENT_KEY!" /v "DriverDesc" 2^>nul ^| findstr /i "DriverDesc"') do set "DEV_DESC=%%B"

    echo !DEV_DESC! | findstr /i "NVIDIA" >nul && set "DEV_VENDOR=NVIDIA"
    echo !DEV_DESC! | findstr /i "Intel" >nul && set "DEV_VENDOR=INTEL"
    echo !DEV_DESC! | findstr /i /c:"AMD" /c:"Radeon" /c:"Advanced Micro Devices" >nul && set "DEV_VENDOR=AMD"

    if "!DEV_VENDOR!"=="Unknown" (
        reg query "!CURRENT_KEY!" /v "MatchingDeviceId" 2^>nul | findstr /i "VEN_10DE" >nul && set "DEV_VENDOR=NVIDIA"
        reg query "!CURRENT_KEY!" /v "MatchingDeviceId" 2^>nul | findstr /i "VEN_8086" >nul && set "DEV_VENDOR=INTEL"
        reg query "!CURRENT_KEY!" /v "MatchingDeviceId" 2^>nul | findstr /i "VEN_1002" >nul && set "DEV_VENDOR=AMD"
    )

    if "!DEV_VENDOR!"=="Unknown" (
        reg query "!CURRENT_KEY!" /v "HardwareID" 2^>nul | findstr /i "VEN_10DE" >nul && set "DEV_VENDOR=NVIDIA"
        reg query "!CURRENT_KEY!" /v "HardwareID" 2^>nul | findstr /i "VEN_8086" >nul && set "DEV_VENDOR=INTEL"
        reg query "!CURRENT_KEY!" /v "HardwareID" 2^>nul | findstr /i "VEN_1002" >nul && set "DEV_VENDOR=AMD"
    )

    if not "!DEV_VENDOR!"=="Unknown" (
        set /a count+=1
        if !count! equ 1 (
            set "GPU1_VENDOR=!DEV_VENDOR!"
            set "GPU1_NAME=!DEV_DESC!"
        )
        if !count! equ 2 (
            set "GPU2_VENDOR=!DEV_VENDOR!"
            set "GPU2_NAME=!DEV_DESC!"
        )
        call :CHECK_IGPU_KEY "!DEV_VENDOR!" "!CURRENT_KEY!"
        if "!IS_IGPU!"=="0" set "HAS_DGPU=1"
        if "!DEV_VENDOR!"=="INTEL" set "HAS_INTEL_GPU=1"
        if "!DEV_VENDOR!"=="NVIDIA" set "HAS_NVIDIA_GPU=1"
        if "!DEV_VENDOR!"=="AMD" set "HAS_AMD_GPU=1"
    )
)

if !count! equ 0 (
    for /f "tokens=1,2 delims=;" %%A in ('powershell -NoProfile -Command "Get-CimInstance Win32_VideoController -ErrorAction SilentlyContinue | ForEach-Object { $_.AdapterCompatibility + ';' + $_.Name }" 2^>nul') do (
        set "PS_COMPAT=%%A"
        set "PS_NAME=%%B"
        set "DEV_VENDOR=Unknown"
        echo !PS_COMPAT! !PS_NAME! | findstr /i "NVIDIA" >nul && set "DEV_VENDOR=NVIDIA"
        echo !PS_COMPAT! !PS_NAME! | findstr /i "Intel" >nul && set "DEV_VENDOR=INTEL"
        echo !PS_COMPAT! !PS_NAME! | findstr /i /c:"AMD" /c:"Radeon" /c:"Advanced Micro Devices" >nul && set "DEV_VENDOR=AMD"
        if not "!DEV_VENDOR!"=="Unknown" (
            set /a count+=1
            if !count! equ 1 (
                set "GPU1_VENDOR=!DEV_VENDOR!"
                set "GPU1_NAME=!PS_NAME!"
            )
            if !count! equ 2 (
                set "GPU2_VENDOR=!DEV_VENDOR!"
                set "GPU2_NAME=!PS_NAME!"
            )
            if "!DEV_VENDOR!"=="INTEL" set "HAS_INTEL_GPU=1"
            if "!DEV_VENDOR!"=="NVIDIA" set "HAS_NVIDIA_GPU=1"
            if "!DEV_VENDOR!"=="AMD" set "HAS_AMD_GPU=1"
        )
    )
)

if defined GPU1_NAME (
    echo Main GPU: !GPU1_VENDOR! [!GPU1_NAME!]
) else (
    echo Main GPU: !GPU1_VENDOR!
)
if not "!GPU2_VENDOR!"=="None" (
    if defined GPU2_NAME (
        echo Secondary GPU: !GPU2_VENDOR! [!GPU2_NAME!]
    ) else (
        echo Secondary GPU: !GPU2_VENDOR!
    )
)
echo ===================================================
echo EXECUTION
echo ===================================================

if "!CPU_VENDOR!"=="INTEL" (

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "L3_Cache_Foreground_Priority" /t REG_DWORD /d 31 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "Cache_QoS_Enable" /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "LLC_ForegroundMonopoly" /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "IMC_Scrubber_Disable" /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "Cache_Locality_Strict" /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "CStateLimit" /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Enable" /t REG_DWORD /d 1 /f >nul 2>&1

reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Media\Brighten Movie" /v "DPST" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Media\Darken Movie" /v "DPST" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Media\Enhance Movie" /v "DPST" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Media\Preserve Details" /v "DPST" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Processor\Power" /v "MaxThrottleCapacity" /t REG_DWORD /d 100 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Processor\Power" /v "PerfState" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Processor\Power" /v "ThermalThrottle" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableD3Hot" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableRuntimePowerManagement" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableL1Substates" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableAspm" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0LidOpen" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0ACPower" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0DCPower" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Battery" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Thermal" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Fan" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Cooling" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Heating" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Humidity" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Pressure" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Altitude" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Light" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Proximity" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Orientation" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Location" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Gyroscope" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Accelerometer" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Magnetometer" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Compass" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Barometer" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0AmbientLight" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0RGBLight" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0IRLight" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0UVLight" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0XRay" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0GammaRay" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableLtr" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "PkgCStateLimit" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "TimerCoalescingEnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "S0LowPowerIdle" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "AutonomousCStateEnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "TransitDelay" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "PciePowerGatingEnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "AutonomousPowerStatesDisable" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "PerformanceBias" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "Boost_Policy" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "SamplingInterval" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "IMC_Power_Down_Enable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "IMC_Opportunistic_Refresh_Disable" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "Ring_Bus_Priority_Mode" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "ThermalThrottlingSoftwareDisable" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "MinPerformance" /t REG_DWORD /d 100 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "AutonomousCurrentLimitDisable" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "LatencyToleranceValue" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "RingBusPriority" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "InterruptToleranceValue" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Interrupt_Mode" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Time_Window" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_PerformanceSetting" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "EnableTurboBoost" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "TurboMode" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Desired_Performance" /t REG_DWORD /d 255 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Minimum_Performance" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Maximum_Performance" /t REG_DWORD /d 255 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Energy_Performance_Preference" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Autonomous_Activity_Window" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Autonomous_EPP" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Lowest_Frequency" /t REG_DWORD /d 800 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Highest_Frequency" /t REG_DWORD /d 4200 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Response" /t REG_DWORD /d 0 /f >nul 2>&1

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "RootComplex_VC1_Enable" /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "EnableD3Cold" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_EPP" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "PerfBoostMode" /t REG_DWORD /d 2 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "AllowThrottling" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "BackgroundPriority" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Activity_Window" /t REG_DWORD /d 0 /f >nul 2>&1

) else if "!CPU_VENDOR!"=="AMD" (

    call :APPLY_AMD_CPU
)

if "!HAS_INTEL_GPU!"=="1" call :APPLY_INTEL_GPU
if "!HAS_NVIDIA_GPU!"=="1" call :APPLY_NVIDIA_GPU
if "!HAS_AMD_GPU!"=="1" call :APPLY_AMD_GPU

echo.

echo [*] Applying extra RAM / latency / FPS tweaks...
bcdedit /set disabledynamictick yes >nul 2>&1
bcdedit /set useplatformtick yes >nul 2>&1
bcdedit /set hypervisorlaunchtype off >nul 2>&1
bcdedit /set allowedinmemorysettings 0x0 >nul 2>&1
bcdedit /set isolatedcontext No >nul 2>&1
bcdedit /set quietboot yes >nul 2>&1
bcdedit /timeout 3 >nul 2>&1

for %%S in (WSearch SysMain Spooler TermService SessionEnv UmRdpService wscsvc WbioSrvc Wecsvc) do (
    net stop %%S /y >nul 2>&1
    sc config %%S start= disabled >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%S" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
)
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Ndu" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Audio" /v "DisableProtectedAudioDG" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "ForegroundLockTimeout" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "IconsOnly" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DisableTaskOffload" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "CrashDumpEnabled" /t REG_DWORD /d 3 /f >nul 2>&1
netsh int ip set global taskoffload=disabled >nul 2>&1

powershell -NoProfile -Command "Get-PnpDevice -FriendlyName 'High precision event timer' -ErrorAction SilentlyContinue | Disable-PnpDevice -Confirm:$false -ErrorAction SilentlyContinue" >nul 2>&1
powershell -NoProfile -Command "Get-PnpDevice -Class Net,USB -PresentOnly -ErrorAction SilentlyContinue | Where-Object { $_.InstanceId -like 'PCI\*' } | ForEach-Object { $k = 'HKLM:\SYSTEM\CurrentControlSet\Enum\' + $_.InstanceId + '\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties'; New-Item -Path $k -Force -ErrorAction SilentlyContinue | Out-Null; New-ItemProperty -Path $k -Name 'MSISupported' -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null }" >nul 2>&1
powershell -NoProfile -Command "Disable-NetAdapterRsc -Name '*' -ErrorAction SilentlyContinue; Disable-NetAdapterLso -Name '*' -ErrorAction SilentlyContinue" >nul 2>&1
powershell -NoProfile -Command "Set-ProcessMitigation -System -Disable CFG,SEHOP -ErrorAction SilentlyContinue" >nul 2>&1
powershell -NoProfile -Command "Get-ScheduledTask -TaskPath '\Microsoft\Windows\Windows Defender\' -ErrorAction SilentlyContinue | Disable-ScheduledTask -ErrorAction SilentlyContinue" >nul 2>&1
powershell -NoProfile -Command "Set-MpPreference -MAPSReporting 0 -DisableBlockAtFirstSeen $true" >nul 2>&1

echo [*] Applying extra tweaks pack 2...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableExceptionChainValidation" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "AutoReboot" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "Overwrite" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableICMPRedirect" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DisableIPSourceRouting" /t REG_DWORD /d 2 /f >nul 2>&1
netsh int tcp set global dca=enabled >nul 2>&1
powershell -NoProfile -Command "Disable-NetAdapterBinding -Name '*' -ComponentID ms_lltdio,ms_rspndr -ErrorAction SilentlyContinue" >nul 2>&1

reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v "DontOfferThroughWUAU" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting\Consent" /v "DefaultConsent" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "NoLockScreen" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\BootAnimation" /v "DisableStartupSound" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HubsSidebarEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeShoppingAssistantEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "ShowRecommendationsEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DiagnosticData" /t REG_DWORD /d 0 /f >nul 2>&1

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Multimedia\Audio" /v "UserDuckingPreference" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKCU\AppEvents\Schemes" /ve /t REG_SZ /d ".None" /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v "MouseHoverTime" /t REG_SZ /d "10" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "DelayBeforeAcceptance" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "BounceTime" /t REG_SZ /d "0" /f >nul 2>&1

powercfg /setacvalueindex SCHEME_CURRENT SUB_SLEEP HYBRIDSLEEP 0 >nul 2>&1
powercfg /setdcvalueindex SCHEME_CURRENT SUB_SLEEP HYBRIDSLEEP 0 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1

for %%T in ("Flighting\FeatureConfig\ReconcileFeatures" "Flighting\OneSettings\RefreshCache" "DiskFootprint\Diagnostics" "SettingSync\BackgroundUploadTask" "SettingSync\NetworkStateChangeTask" "ErrorDetails\EnableErrorDetailsUpdate" "Mobile Broadband Accounts\MNO Metadata Parser" "Speech\SpeechModelDownloadTask" "WDI\ResolutionHost" "Registry\RegIdleBackup" "Work Folders\Work Folders Logon Synchronization" "Work Folders\Work Folders Maintenance Work" "Location\Notifications" "Location\WindowsActionDialog") do (
    schtasks /Change /TN "Microsoft\Windows\%%~T" /Disable >nul 2>&1
)
powershell -NoProfile -Command "Disable-WindowsOptionalFeature -Online -FeatureName 'Internet-Explorer-Optional-amd64','Printing-XPSServices-Features' -NoRestart -ErrorAction SilentlyContinue" >nul 2>&1
powershell -NoProfile -Command "Get-WindowsCapability -Online -ErrorAction SilentlyContinue | Where-Object { $_.State -eq 'Installed' -and $_.Name -match 'InternetExplorer|StepsRecorder|WordPad|MathRecognizer' } | Remove-WindowsCapability -Online -ErrorAction SilentlyContinue" >nul 2>&1

echo [*] Applying extra tweaks pack 3...
for %%S in (TrkWks SensrSvc SensorDataService DusmSvc AdobeARMservice AGSService AGMService adobeupdateservice gupdate gupdatem GoogleChromeElevationService MozillaMaintenance JavaQuickStarterService) do (
    net stop %%S /y >nul 2>&1
    sc config %%S start= disabled >nul 2>&1
)

for %%T in ("Application Experience\MareBackup" "Application Experience\AitAgent" "NlaSvc\WiFiTask" "PushToInstall\LoginCheck" "PushToInstall\Registration" "Sysmain\ResPriStaticDbSync" "Sysmain\WsSwapAssessmentTask" "TPM\Tpm-HASCertRetr" "TPM\Tpm-Maintenance" "UNP\RunUpdateNotificationMgr" "WwanSvc\NotificationTask" "WwanSvc\OobeDiscovery" "Printing\EduPrintProv" "Ras\MobilityManager" "RemoteAssistance\RemoteAssistanceTask" "Management\Provisioning\Logon" "Diagnosis\Scheduled" "Windows Media Sharing\UpdateLibrary" "WindowsColorSystem\Calibration Loader") do (
    schtasks /Change /TN "Microsoft\Windows\%%~T" /Disable >nul 2>&1
)
schtasks /Change /TN "Microsoft\XblGameSave\XblGameSaveTask" /Disable >nul 2>&1
powershell -NoProfile -Command "Get-ScheduledTask -TaskName 'GoogleUpdate*','MicrosoftEdgeUpdate*','Adobe*','OneDrive*','Opera*scheduled*' -ErrorAction SilentlyContinue | Disable-ScheduledTask -ErrorAction SilentlyContinue" >nul 2>&1

netsh winsock set autotuning on >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "DisableBandwidthThrottling" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "DisableLargeMtu" /t REG_DWORD /d 0 /f >nul 2>&1

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableFirstLogonAnimation" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisablePreviewDesktop" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowInfoTip" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "MaxCachedIcons" /t REG_SZ /d "4096" /f >nul 2>&1

powershell -NoProfile -Command "Set-MpPreference -DisableArchiveScanning $true -DisableEmailScanning $true -DisableRemovableDriveScanning $true -DisableScanningNetworkFiles $true -DisableScanningMappedNetworkDrivesForFullScan $true -DisableCpuThrottleOnIdleScans $false -ScanScheduleDay 8" >nul 2>&1

del /f /q "%SystemRoot%\MEMORY.DMP" >nul 2>&1
del /f /q "%SystemRoot%\Minidump\*" >nul 2>&1
del /f /s /q "%LOCALAPPDATA%\CrashDumps\*" >nul 2>&1
del /f /s /q "C:\Program Files (x86)\Steam\logs\*" >nul 2>&1
del /f /s /q "C:\Program Files (x86)\Steam\dumps\*" >nul 2>&1
rd /s /q "C:\Program Files (x86)\Steam\appcache\httpcache" >nul 2>&1
powershell -NoProfile -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" >nul 2>&1
dism /online /Cleanup-Image /StartComponentCleanup /ResetBase >nul 2>&1

for %%S in (NgcSvc NgcCtnrSvc) do (
    net stop %%S /y >nul 2>&1
    sc config %%S start= disabled >nul 2>&1
)

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SecondLevelDataCache" /t REG_DWORD /d 4096 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /t REG_DWORD /d 983040 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PoolUsageMaximum" /t REG_DWORD /d 60 /f >nul 2>&1
powershell -NoProfile -Command "Disable-MMAgent -OperationAPI -ErrorAction SilentlyContinue" >nul 2>&1

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "AlwaysShowClassicMenu" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d "1000" /f >nul 2>&1

for %%T in ("Shell\CreateObjectTask" "Device Setup\Metadata Refresh" "FileHistory\File History (maintenance mode)" "International\Synchronize Language Time" "Multimedia\SystemSoundsService" "Offline Files\Background Synchronization" "Offline Files\Logon Synchronization" "SyncCenter\SyncCenter Fallback" "Time Synchronization\SynchronizeTime" "WCM\WiFiTask" "Workplace Join\Automatic-Device-Join") do (
    schtasks /Change /TN "Microsoft\Windows\%%~T" /Disable >nul 2>&1
)

netsh int tcp set supplemental template=internet congestionprovider=ctcp >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NDIS\Parameters" /v "RssBaseCpu" /t REG_DWORD /d 1 /f >nul 2>&1

echo [*] Defender: if Tamper Protection is on, turn it off in Windows Security first or these changes will revert.
for %%S in (WinDefend WdNisSvc Sense SecurityHealthService wscsvc) do (
    net stop %%S /y >nul 2>&1
    sc config %%S start= disabled >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%S" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiVirus" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SpynetReporting" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\UX Configuration" /v "Notification_Suppress" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications" /v "DisableNotifications" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender Security Center\Systray" /v "HideSystray" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f >nul 2>&1
for %%T in ("Windows Defender\Windows Defender Cache Maintenance" "Windows Defender\Windows Defender Cleanup" "Windows Defender\Windows Defender Scheduled Scan" "Windows Defender\Windows Defender Verification") do (
    schtasks /Change /TN "Microsoft\%%~T" /Disable >nul 2>&1
)
taskkill /f /im SecurityHealthSystray.exe >nul 2>&1
taskkill /f /im MsMpEng.exe >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MpCmdRun.exe" /v "Debugger" /t REG_SZ /d "nul" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SecurityHealthSystray.exe" /v "Debugger" /t REG_SZ /d "nul" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SecurityHealthService.exe" /v "Debugger" /t REG_SZ /d "nul" /f >nul 2>&1
for %%D in ("C:\Windows\System32\SecurityHealthSystray.exe" "C:\Windows\System32\SecurityHealthService.exe") do (
    if exist "%%~D" (
        takeown /F "%%~D" >nul 2>&1
        icacls "%%~D" /grant administrators:F >nul 2>&1
        copy /Y "%%~D" "%HEX_FILES_BACKUP%" >nul 2>&1
        del "%%~D" /s /f /q >nul 2>&1
    )
)

if "!DISABLE_WU!"=="1" (
    for %%S in (wuauserv bits dosvc UsoSvc WaaSMedicSvc) do (
        net stop %%S /y >nul 2>&1
        sc config %%S start= disabled >nul 2>&1
    )
    sc delete wuauserv >nul 2>&1
    sc delete UsoSvc >nul 2>&1
    sc delete WaaSMedicSvc >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\UsoClient.exe" /v "Debugger" /t REG_SZ /d "nul" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotification.exe" /v "Debugger" /t REG_SZ /d "nul" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MusNotificationUx.exe" /v "Debugger" /t REG_SZ /d "nul" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SIHClient.exe" /v "Debugger" /t REG_SZ /d "nul" /f >nul 2>&1
)

for %%A in (
    "microsoft.windowscommunicationsapps"
    "Microsoft.MicrosoftStickyNotes"
    "Microsoft.WindowsSoundRecorder"
) do (
    powershell -NoProfile -Command "Get-AppxPackage *%%~A* | Remove-AppxPackage" >nul 2>&1
    powershell -NoProfile -Command "Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -like '*%%~A*'} | Remove-AppxProvisionedPackage -Online" >nul 2>&1
)
powershell -NoProfile -Command "Disable-WindowsOptionalFeature -Online -FeatureName 'Printing-Foundation-Features','Printing-Foundation-InternetPrinting-Client','FaxServicesClientPackage','WindowsMediaPlayer','MediaPlayback' -NoRestart -ErrorAction SilentlyContinue" >nul 2>&1
taskkill /f /im Narrator.exe >nul 2>&1
taskkill /f /im Magnify.exe >nul 2>&1

powershell -NoProfile -Command "Disable-WindowsOptionalFeature -Online -FeatureName 'Microsoft-Hyper-V-All','Microsoft-Hyper-V','VirtualMachinePlatform','Containers-DisposableClientVM','Windows-Defender-ApplicationGuard','Microsoft-Windows-Subsystem-Linux','Containers' -NoRestart -ErrorAction SilentlyContinue" >nul 2>&1
for %%S in (vmms vmcompute HvHost hns vmickvpexchange vmicguestinterface vmicshutdown vmicheartbeat vmictimesync vmicrdv vmicvss) do (
    net stop %%S /y >nul 2>&1
    sc config %%S start= disabled >nul 2>&1
)

powercfg /setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 5d76a2ca-e8c0-402f-a133-2158492d58ad 1 >nul 2>&1
powercfg /setdcvalueindex SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 5d76a2ca-e8c0-402f-a133-2158492d58ad 1 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SwapfileControl" /t REG_DWORD /d 0 /f >nul 2>&1
sc config EMDMgmt start= disabled >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\EMDMgmt" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

for %%T in ("Defrag\ScheduledDefrag" "DiskCleanup\SilentCleanup" "WDI\SQMLogger" "Device Information\Device" "Input\WorkplaceJoinNotification") do (
    schtasks /Change /TN "Microsoft\Windows\%%~T" /Disable >nul 2>&1
)
rd /s /q "C:\$Recycle.Bin" >nul 2>&1
del /f /s /q "%WINDIR%\SoftwareDistribution\DeliveryOptimization\*" >nul 2>&1

rd /s /q "%ProgramData%\Microsoft\Search\Data\Applications\Windows" >nul 2>&1
fsutil usn deletejournal /D %SystemDrive% >nul 2>&1
if exist "%SystemDrive%\Windows.old" rd /s /q "%SystemDrive%\Windows.old" >nul 2>&1
dism /online /Cleanup-Image /SPSuperseded >nul 2>&1

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NoLazyMode" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "AlwaysOn" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AudioEndpointBuilder" /v "Start" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DistributeTimers" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DpcWatchdogProfileOffset" /t REG_DWORD /d 0 /f >nul 2>&1
powershell -NoProfile -Command "Get-PnpDevice -Class 'MEDIA' -PresentOnly -ErrorAction SilentlyContinue | ForEach-Object { $k = 'HKLM:\SYSTEM\CurrentControlSet\Enum\' + $_.InstanceId + '\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties'; New-Item -Path $k -Force -ErrorAction SilentlyContinue | Out-Null; New-ItemProperty -Path $k -Name 'MSISupported' -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null }" >nul 2>&1

powershell -NoProfile -Command "Disable-NetAdapterBinding -Name '*' -ComponentID ms_pacer -ErrorAction SilentlyContinue" >nul 2>&1
powershell -NoProfile -Command "Get-NetAdapter -Physical -ErrorAction SilentlyContinue | Enable-NetAdapterRss -ErrorAction SilentlyContinue" >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PenWorkspace" /v "PenWorkspaceButtonDesiredVisibility" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsInkWorkspace" /v "AllowWindowsInkWorkspace" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\GameBar.exe" /v "Debugger" /t REG_SZ /d "nul" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\GameBarFTServer.exe" /v "Debugger" /t REG_SZ /d "nul" /f >nul 2>&1

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "DisableThumbnailCache" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "DisableThumbsDBOnNetworkFolders" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisableThumbnailCache" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisallowShaking" /t REG_DWORD /d 1 /f >nul 2>&1

netsh int tcp set global chimney=disabled >nul 2>&1
netsh int tcp set global netdma=disabled >nul 2>&1
netsh int udp set global uro=disabled >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PagedPoolSize" /t REG_DWORD /d 4294967295 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v VisualFXSetting /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010000000 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 1 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v FontSmoothing /t REG_SZ /d 2 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v FontSmoothingType /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 3 /f >nul 2>&1
taskkill /f /im explorer.exe >nul 2>&1
taskkill /f /im dwm.exe >nul 2>&1
del /f /q /s "%localappdata%\IconCache.db" >nul 2>&1
del /f /q /s "%localappdata%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
net stop FontCache >nul 2>&1
del /f /q /s "%localappdata%\GDIPFONTCACHEV1.dat" >nul 2>&1
net start FontCache >nul 2>&1
start explorer.exe

echo [*] Applying global scheduler quantum [Win32PrioritySeparation]...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 40 /f >nul 2>&1

echo [*] Enabling MSI / spread interrupts on NVMe controllers...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-PnpDevice -PresentOnly -ErrorAction SilentlyContinue | Where-Object { $_.InstanceId -like 'PCI\*' -and (($_.HardwareID -join ' ') -match 'CC_010802') } | ForEach-Object { $b='HKLM:\SYSTEM\CurrentControlSet\Enum\'+$_.InstanceId+'\Device Parameters\Interrupt Management'; New-Item -Path ($b+'\MessageSignaledInterruptProperties') -Force | Out-Null; New-ItemProperty -Path ($b+'\MessageSignaledInterruptProperties') -Name 'MSISupported' -Value 1 -PropertyType DWord -Force | Out-Null; New-Item -Path ($b+'\Affinity Policy') -Force | Out-Null; New-ItemProperty -Path ($b+'\Affinity Policy') -Name 'DevicePolicy' -Value 4 -PropertyType DWord -Force | Out-Null }" >nul 2>&1

echo [*] Disabling per-device power saving [USB / PCI / HD Audio]...
if "!HEX_LAPTOP!"=="0" powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-CimInstance -Namespace root\wmi -ClassName MSPower_DeviceEnable -ErrorAction SilentlyContinue | Where-Object { $_.InstanceName -match '^(USB|PCI|HDAUDIO)\\' } | ForEach-Object { Set-CimInstance -InputObject $_ -Property @{Enable=$false} -ErrorAction SilentlyContinue }" >nul 2>&1
if "!HEX_LAPTOP!"=="0" powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-PnpDevice -Class USB -PresentOnly -ErrorAction SilentlyContinue | ForEach-Object { $p='HKLM:\SYSTEM\CurrentControlSet\Enum\'+$_.InstanceId+'\Device Parameters'; if (Test-Path $p) { foreach($n in 'EnhancedPowerManagementEnabled','AllowIdleIrpInD3','SelectiveSuspendEnabled','D3ColdSupported'){ New-ItemProperty -Path $p -Name $n -Value 0 -PropertyType DWord -Force -ErrorAction SilentlyContinue | Out-Null } } }" >nul 2>&1

echo [*] Moving network RSS queues off CPU 0...
echo !CPU_MODEL!| findstr /i "X3D" >nul || powershell -NoProfile -Command "if ((Get-CimInstance Win32_ComputerSystem).NumberOfLogicalProcessors -ge 8) { Get-NetAdapter -Physical -ErrorAction SilentlyContinue | Where-Object { $_.Status -eq 'Up' } | ForEach-Object { Set-NetAdapterRss -Name $_.Name -BaseProcessorNumber 2 -MaxProcessors 4 -ErrorAction SilentlyContinue } }" >nul 2>&1

echo [*] Disabling UDP segmentation / ARP / NS offloads on adapters...
powershell -NoProfile -Command "Get-NetAdapter -Physical -ErrorAction SilentlyContinue | ForEach-Object { foreach($k in '*UsoIPv4','*UsoIPv6','*PMARPOffload','*PMNSOffload'){ Set-NetAdapterAdvancedProperty -Name $_.Name -RegistryKeyword $k -RegistryValue 0 -NoRestart -ErrorAction SilentlyContinue } }" >nul 2>&1

echo [*] Tuning DNS negative cache...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "NegativeCacheTime" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "NegativeSOACacheTime" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "NetFailureCacheTime" /t REG_DWORD /d 0 /f >nul 2>&1

echo [*] Disabling kernel energy telemetry and NVMe idle timeouts...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "DisableTaggedEnergyLogging" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "TelemetryMaxApplication" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "TelemetryMaxTagPerApplication" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "PerfCalculateActualUtilization" /t REG_DWORD /d 0 /f >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT SUB_DISK d639518a-e56d-4345-8af2-b9f32fb26109 0 >nul 2>&1
powercfg /setdcvalueindex SCHEME_CURRENT SUB_DISK d639518a-e56d-4345-8af2-b9f32fb26109 0 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1

echo [*] Disabling OEM telemetry services [only if installed]...
for %%S in (SupportAssistAgent DellDataVault DDVDataCollector DDVRulesProcessor DDVCollectorSvcApi DellClientManagementService HPAppHelperCap HPDiagsCap HPNetworkCap HPSysInfoCap HPTouchpointAnalyticsService ICLS) do (
    sc query "%%S" >nul 2>&1 && sc config "%%S" start= disabled >nul 2>&1
)

rem ===== HEX+ SAFE COMPATIBILITY PASS (added; original tweaks retained) =====
echo [*] Restoring essential Windows services for system stability...
sc config EventLog start= auto >nul 2>&1
sc config Dhcp start= auto >nul 2>&1
sc config Dnscache start= auto >nul 2>&1
sc config NlaSvc start= auto >nul 2>&1
sc config nsi start= auto >nul 2>&1
sc config Netman start= demand >nul 2>&1
sc config Audiosrv start= auto >nul 2>&1
sc config AudioEndpointBuilder start= auto >nul 2>&1
sc config RpcSs start= auto >nul 2>&1
sc config DcomLaunch start= auto >nul 2>&1
sc config PlugPlay start= demand >nul 2>&1
sc config BFE start= auto >nul 2>&1
sc config MpsSvc start= auto >nul 2>&1
net start EventLog >nul 2>&1
net start Dhcp >nul 2>&1
net start Dnscache >nul 2>&1
net start NlaSvc >nul 2>&1
net start Audiosrv >nul 2>&1
net start AudioEndpointBuilder >nul 2>&1
if "!DISABLE_WIFI!"=="0" (
    sc config WlanSvc start= auto >nul 2>&1
    net start WlanSvc >nul 2>&1
) else (
    sc config WlanSvc start= disabled >nul 2>&1
)
rem Bluetooth services remain available; no Bluetooth tweak is deleted.
sc config bthserv start= demand >nul 2>&1
sc config BthAvctpSvc start= demand >nul 2>&1
sc config BTAGService start= demand >nul 2>&1
rem Keep Windows Event Log enabled even though it appears in SC_EXTRA.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\EventLog" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
rem Additional low-risk tweaks: Game Mode and Explorer startup-delay reduction.
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v StartupDelayInMSec /t REG_DWORD /d 0 /f >nul 2>&1
rem Keep AC processor limits within normal supported bounds; no overclock/voltage changes.
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMIN 5 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX 100 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1
rem ===== END SAFE COMPATIBILITY PASS =====

goto :hex_done

:APPLY_INTEL_GPU
echo [GPU-INTEL] Applying Intel GPU optimizations...

set "INTEL_GPU_FOUND=0"

for /f "tokens=*" %%K in ('reg query "%GPU_CLASS_KEY%" /s /v "DriverDesc" 2^>nul ^| findstr /i "HKEY"') do (
    set "GPU_KEY=%%K"
    set "IS_MATCH=0"
    reg query "!GPU_KEY!" /v "DriverDesc" 2>nul | findstr /i "Intel" >nul && set "IS_MATCH=1"
    if "!IS_MATCH!"=="0" reg query "!GPU_KEY!" /v "HardwareID" 2>nul | findstr /i "VEN_8086" >nul && set "IS_MATCH=1"
    if "!IS_MATCH!"=="0" reg query "!GPU_KEY!" /v "MatchingDeviceId" 2>nul | findstr /i "VEN_8086" >nul && set "IS_MATCH=1"
    if "!IS_MATCH!"=="1" (
        set "INTEL_GPU_FOUND=1"
        set "SKIP_INST=0"
        call :CHECK_IGPU_KEY "INTEL" "!GPU_KEY!"
        if "!IS_IGPU!"=="1" if "!HAS_DGPU!"=="1" set "SKIP_INST=1"
        if "!SKIP_INST!"=="1" (
            echo [GPU-INTEL] Skipping integrated GPU - a discrete GPU is present.
        ) else (
            call :APPLY_INTEL_INSTANCE "!GPU_KEY!"
        )
    )
)

if "!INTEL_GPU_FOUND!"=="0" echo [NOTICE] No Intel GPU detected in the dynamic loop.
exit /b 0

:APPLY_INTEL_INSTANCE
set "GPU_KEY=%~1"

reg add "%GPU_KEY%" /v "PowerDpstAggressivenessLevel" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "UnderRunCountPipeA" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "Disable_OverlayDSQualityEnhancement" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "PowerPolicy" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "RuntimePowerManagementEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "FbcEnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "FlipQueueSize" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "AdaptiveTessellation" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "ShaderCacheSize" /t REG_DWORD /d 15 /f >nul 2>&1
reg add "%GPU_KEY%" /v "AnisotropicFilteringMode" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "UserPowerMode" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "%GPU_KEY%" /v "RenderStandby" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DirectXHardwareAcceleration" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableVideoEnhancement" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "TextureCacheOptimization" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "ForceIntelTurbo" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "RingBufferSize" /t REG_DWORD /d 1024 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableAsyncFlip" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableTripleBuffering" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "VSyncControl" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisablePFonDP" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisablePSR" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "PSREnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableDisplayCaching" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableMemoryCompression" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableRC6" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "RC6Disable" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableRenderStandby" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableMediaPowerSaving" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableDisplayPowerSaving" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableDynamicFrequencyScaling" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "MaxGPUClockFrequency" /t REG_DWORD /d 1350 /f >nul 2>&1
reg add "%GPU_KEY%" /v "MinGPUClockFrequency" /t REG_DWORD /d 300 /f >nul 2>&1
reg add "%GPU_KEY%" /v "GPUClockFrequency" /t REG_DWORD /d 1350 /f >nul 2>&1
reg add "%GPU_KEY%" /v "EnableTurbo" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableFrameBufferCompression" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableLosslessCompression" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableCompression" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "TextureFilteringQuality" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "AntiAliasingMode" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisablePostProcessing" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableVideoProcessing" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableImageProcessing" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableDisplayEnhancement" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableAdaptiveContrast" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "AdaptiveContrastEnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableDynamicContrast" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableDynamicBrightness" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableAmbientLightSensor" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableALS" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisablePowerState0" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisablePowerState1" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisablePowerState2" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisablePowerState3" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisablePowerState4" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisablePowerState5" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisablePowerState6" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisablePowerState7" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisablePowerState8" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisablePowerState9" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisablePowerState10" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisablePowerState11" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisablePowerState12" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisablePowerState13" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisablePowerState14" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisablePowerState15" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableFBC" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableDynamicFBC" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "PSR_Enable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "ConservativeMorphologicalAntiAliasing" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "EuThreadPriority" /t REG_DWORD /d 31 /f >nul 2>&1
reg add "%GPU_KEY%" /v "RCPriority" /t REG_DWORD /d 31 /f >nul 2>&1
reg add "%GPU_KEY%" /v "ContextPriority" /t REG_DWORD /d 31 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableDMACopy" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "MediaPowerSaving" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DynamicVidMemoryControl" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "GfxDynamicPState" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisplayPowerSavingTechnology" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "EnablePowerGating" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "%GPU_KEY%\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Device\OpenGL" /v "DisablePFonDP" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Device\OpenGL" /v "FlipQueueSize" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Device\OpenGL" /v "ThreadedOptimization" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Device\Vulkan" /v "DisableValidation" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Device\Vulkan" /v "PreferSystemMemoryContiguous" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmPageTablePinned" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\GMM" /v "SchedulerPriority" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmContiguousMemoryRequired" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmPageTableSize" /t REG_DWORD /d 4194304 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmPageTablePoolSize" /t REG_DWORD /d 1048576 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmResourceCacheSize" /t REG_DWORD /d 268435456 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmCacheSize" /t REG_DWORD /d 536870912 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmCachePolicy" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmEvictionPolicy" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmDefragPolicy" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmDefragEnable" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmReclaimEnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmReclaimPolicy" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\GMM" /v "LowLatencyAllocations" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\GMM" /v "DisableGmmDelay" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" /v "StartupDelay" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "MaximumFrameLatency" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "VsyncCpuThreadPriority" /t REG_DWORD /d 15 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "ThreadPriority" /t REG_DWORD /d 31 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisablePowerManagement" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableDynamicClock" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableDeepSleep" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableStandby" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableHibernate" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableSleep" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisablePowerButton" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableLidClose" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableLidOpen" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableACPower" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "PkgCStateLimit" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "TimerCoalescingEnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "S0LowPowerIdle" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "AutonomousCStateEnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "TransitDelay" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "PciePowerGatingEnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisablePchClockGating" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisablePchPmClockGating" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DmiLinkPriority" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "ApmEnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Ignore_Platform_Limits" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "Boost_Policy" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "SamplingInterval" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "IMC_Power_Down_Enable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "IMC_Opportunistic_Refresh_Disable" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "Ring_Bus_Priority_Mode" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "ThermalThrottlingSoftwareDisable" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "MinPerformance" /t REG_DWORD /d 100 /f >nul 2>&1
reg add "%GPU_KEY%" /v "CmaaEnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "ColorEnhancement" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "EnableDynamicRefreshRate" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableDynamicClock" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "EnableOverclock" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableTextureCompression" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "IncreaseFixedSegment" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "RenderAheadLimit" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "TextureMemorySize" /t REG_DWORD /d 2048 /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmDisableRegistryCaching" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%\Interrupt Management\Affinity Policy" /v "ThreadPriority" /t REG_DWORD /d 31 /f >nul 2>&1
reg add "%GPU_KEY%\Interrupt Management\MessageSignaledInterruptProperties" /v "MessageNumberLimit" /t REG_DWORD /d 2048 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\GMM" /v "AggressiveGarbageCollection" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\GMM" /v "SegmentAllocationPolicy" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\GMM" /v "DedicatedSegmentSize" /t REG_DWORD /d 2048 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\GMM" /v "UseLargePages" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\GMM" /v "EnableAggressiveMemoryReclaim" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\GMM" /v "MinFreeMemoryPool" /t REG_DWORD /d 256 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\GMM" /v "MaxFreeMemoryPool" /t REG_DWORD /d 512 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\GMM" /v "MemoryPoolPolicy" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "FeatureTestControl" /t REG_DWORD /d 113 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDriverManagement" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "CS_Disable" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "D3D9AsyncQueue" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d 10 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay" /t REG_DWORD /d 10 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\501a4d13-42af-4429-95c4-324a7d577775\ee12f2c1-9844-474d-987a-928659de2989" /v "Attributes" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 40 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PoolUsageMaximum" /t REG_DWORD /d 60 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "ThreadPriority" /t REG_DWORD /d 31 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx\Parameters" /v "DisablePowerSaving" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx\Parameters" /v "DisableDynamicClock" /t REG_DWORD /d 0 /f >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPREFERENCE 1 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPOWER 100 >nul 2>&1
powercfg /setdcvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPREFERENCE 1 >nul 2>&1
powercfg /setdcvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPOWER 100 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1

exit /b 0

:APPLY_NVIDIA_GPU
echo [GPU-NVIDIA] Applying NVIDIA GPU optimizations...

set "VRAM_MB=8192"

for /f "tokens=*" %%A in ('powershell -NoProfile -Command "$v=(Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0*' -ErrorAction SilentlyContinue | Where-Object { $_.DriverDesc -match 'NVIDIA' } | Select-Object -First 1).'HardwareInformation.qwMemorySize'; if ($v -is [byte[]]) { $v = [BitConverter]::ToUInt64($v, 0) }; if ($v) { [math]::Round($v / 1MB) } else { 8192 }" 2^>nul') do set "VRAM_MB=%%A"

if "!VRAM_MB!"=="" set "VRAM_MB=8192"

echo [GPU-NVIDIA] VRAM detected: !VRAM_MB! MB

reg add "HKCU\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "Gestalt" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\nvcontainer.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\nvcontainer.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID66610" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID64640" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID44231" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "Gestalt" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "CoolBits" /t REG_DWORD /d 31 /f >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "FlipQueueSize" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "ThreadedOptimization" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "ShaderCache" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "TripleBuffering" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "OpenGLShaders" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "DisableOptimusBatteryPolicy" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "OptimusDeleteRenderHint" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "DisableDynamicPstate" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\NVTweak" /v "DisableOverlay" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d 10 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay" /t REG_DWORD /d 10 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "InvalidateDynamicPstate" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "RmDisableRegistryCaching" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "EnablePowerBudget" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "IgnoreBatteryVoltageSag" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "Gestalt" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "DisplayPowerSaving" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "RmProfilingAdminOnly" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "AllowDeepSleep" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "EnableGpuHealthCheck" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "EnablePerformanceMode" /t REG_DWORD /d 1 /f >nul 2>&1
Set "BinaryMask=00ffff0f01ffff0f02ffff0f03ffff0f04ffff0f05ffff0f06ffff0f07ffff0f08ffff0f09ffff0f0affff0f0bffff0f0cffff0f0dffff0f0effff0f0fffff0f10ffff0f11ffff0f12ffff0f13ffff0f14ffff0f15ffff0f16ffff0f00ffff1f01ffff1f02ffff1f03ffff1f04ffff1f05ffff1f06ffff1f07ffff1f08ffff1f09ffff1f0affff1f0bffff1f0cffff1f0dffff1f0effff1f0fffff1f00ffff2f01ffff2f02ffff2f03ffff2f04ffff2f05ffff2f06ffff2f07ffff2f08ffff2f09ffff2f0affff2f0bffff2f0cffff2f0dffff2f0effff2f0fffff2f00ffff3f01ffff3f02ffff3f03ffff3f04ffff3f05ffff3f06ffff3f07ffff3f"
reg add "HKCU\SOFTWARE\NVIDIA Corporation\Global\GFExperience" /v "NotifyNewDisplayUpdates" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\CoProcManager" /v "ShowTrayIcon" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NGXCore" /v "ShowDlssIndicator" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\NvTray" /v "StartOnLogin" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "EnableHDAudioD3Cold" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "PreferSystemMemoryContiguous" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "NvDevToolsVisible" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "HideXGpuTrayIcon" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\Global\Startup" /v "SendTelemetryData" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "LogDisableMasks" /t REG_BINARY /d "%BinaryMask%" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\services\nvlddmkm\Parameters" /v "LogWarningEntries" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\services\nvlddmkm\Parameters" /v "LogPagingEntries" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\services\nvlddmkm\Parameters" /v "LogEventEntries" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\services\nvlddmkm\Parameters" /v "LogErrorEntries" /t REG_DWORD /d "0" /f >nul 2>&1
nvidia-smi.exe -acp 0 >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "NvBackend" /f >nul 2>&1
if exist "C:\Program Files\NVIDIA Corporation\Installer2\InstallerCore\NVI2.dll" (
    for %%C in (Display.3DVision Display.Audio Ansel) do (
        Rundll32.exe "C:\Program Files\NVIDIA Corporation\Installer2\InstallerCore\NVI2.dll",UninstallPackage %%C >nul 2>&1
    )
)
for /d %%F in ("%SystemDrive%\Windows\System32\DriverStore\FileRepository\nv_dispig.inf_amd64_*") do (
    takeown /f "%%F" /r /d Y >nul 2>&1
    icacls "%%F" /grant "%USERNAME%":F /t >nul 2>&1
    del /s /q "%%F\NvTelemetry64.dll" >nul 2>&1
    rd /s /q "%%F\NvCamera" >nul 2>&1
)

echo [GPU-NVIDIA] Dynamically searching for NVIDIA instances...

set "NVIDIA_GPU_FOUND=0"

for /f "tokens=*" %%K in ('reg query "%GPU_CLASS_KEY%" /s /v "DriverDesc" 2^>nul ^| findstr /i "HKEY"') do (
    set "GPU_KEY=%%K"
    set "IS_MATCH=0"

    reg query "!GPU_KEY!" /v "DriverDesc" 2>nul | findstr /i "NVIDIA" >nul && set "IS_MATCH=1"
    if "!IS_MATCH!"=="0" reg query "!GPU_KEY!" /v "HardwareID" 2>nul | findstr /i "VEN_10DE" >nul && set "IS_MATCH=1"
    if "!IS_MATCH!"=="0" reg query "!GPU_KEY!" /v "MatchingDeviceId" 2>nul | findstr /i "VEN_10DE" >nul && set "IS_MATCH=1"

    if "!IS_MATCH!"=="1" (
        set "NVIDIA_GPU_FOUND=1"
        call :APPLY_NVIDIA_INSTANCE "!GPU_KEY!"
    )
)

if "!NVIDIA_GPU_FOUND!"=="0" echo [NOTICE] No NVIDIA GPU detected in the dynamic loop.
exit /b 0

:APPLY_NVIDIA_INSTANCE
set "GPU_KEY=%~1"

reg add "%GPU_KEY%" /v "ReBarEnable" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "ReBarSupported" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmReBarEnable" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableWriteCombining" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "PreferSystemMemoryContiguous" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "IncreaseFixedSegment" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableVRAMCompression" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableTextureCompression" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DedicatedSegmentSize" /t REG_DWORD /d !VRAM_MB! /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmFbsrPagedDMA" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableDynamicClock" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "EnableUlps" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisablePowerGating" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "EnableOverclock" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "EnableCEPreemption" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMForceMaxPerf" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmDisableRegistryCaching" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "PreferredPerformanceMode" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "PerfLevelSrc" /t REG_DWORD /d 13107 /f >nul 2>&1
reg add "%GPU_KEY%" /v "PowerMizerEnable" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "InvalidateDynamicPstate" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMPcieLinkSpeed" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableL1LowPower" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMDisablePostL2Compression" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMGC6Feature" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMElpgStateOnInit" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMHdcpKeyglobZero" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "PeerMappingOverride" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmGspcPerioduS" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMCtxswLog" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMLogMsg" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "VRRAlwaysOn" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "vrrSmartDetection" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "GsyncCompatible" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "WDDMv21Enable2MPageSupport" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "WDDMv21Enable64KbSysmemSupport" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "WDDMv21Force2MSizeAlignment" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "NvencPreProcBlitDisable" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "NVFBCEnable" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "VideoControl3" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "MessageSignaledInterrupts" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "MSISupported" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%" /v "EnableAspm" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "%GPU_KEY%" /v "PciLatencyTimerControl" /t REG_DWORD /d 32 /f >nul 2>&1
reg add "%GPU_KEY%" /v "EnableRuntimePowerManagement" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmDisableHwFaultBuffer" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMDisablePerIntrDPCQueueing" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMElcg" /t REG_DWORD /d "1431655765" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMBlcg" /t REG_DWORD /d "286331153" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMElpg" /t REG_DWORD /d "4095" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMSlcg" /t REG_DWORD /d "262131" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMFspg" /t REG_DWORD /d "15" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMGC6Parameters" /t REG_DWORD /d "85" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMDidleFeatureGC5" /t REG_DWORD /d "44731050" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMHotPlugSupportDisable" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmRcWatchdog" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmLogonRC" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMIntrDetailedLogs" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMNvLog" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMSuppressGPIOIntrErrLog" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMUsbcDebugMode" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMDisableFeatureDisablement" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmBreakonRC" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMDebugSetSMCMode" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMDisableLRCCoalescing" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmEnableI2CNanny" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMPcieLtrOverride" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMPcieLtrL12ThresholdOverride" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMDeepL1EntryLatencyUsec" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmDisablePreosapps" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmPerfLimitsOverride" /t REG_DWORD /d "21" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMGCOffFeature" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmOverrideSupportChipsetAspm" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMEnableASPMDT" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMDisableGpuASPMFlags" /t REG_DWORD /d "3" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMEnableASPMAtLoad" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMEnableEventTracer" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "SkipSwStateErrChecks" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMAERRForceDisable" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RM580312" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmWar1760398" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMLpwrArch" /t REG_DWORD /d "349525" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmLpwrGrPgSwFilterFunction" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmLpwrCtrlMsDifrSwAsrParameters" /t REG_DWORD /d "5461" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmLpwrCacheStatsOnD3" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmPgCtrlParameters" /t REG_DWORD /d "1431655765" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmDwbMscg" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmDisableInforomBBX" /t REG_DWORD /d "15" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmSec2EnableApm" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmOverrideIdleSlowdownSettings" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMClkSlowDown" /t REG_DWORD /d "71303168" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RM2644249" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmDisableACPI" /t REG_DWORD /d "1023" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMNativePcieL1WarFlags" /t REG_DWORD /d "16" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMResetPerfMonD4" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmFbsrWDDMMode" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmFbsrFileMode" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmMIONoPowerOff" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMDisableOptimalPowerForPadlinkPll" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmClkPowerOffDramPllWhenUnused" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMOPSB" /t REG_DWORD /d "10914" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableAsyncPstates" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "SlideMCLK" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMNvlinkUPHYInitControl" /t REG_DWORD /d "16" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmGpsGenoa" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "D3PCLatency" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "EnableMsHybrid" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMDisableIntrIllegalCompstatAccess" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "SetPanelRefreshRate" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RMDisableNoncontigAlloc" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RmDisableHdcp22" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%\Interrupt Management\Affinity Policy" /v "Strategy" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "%GPU_KEY%\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "%GPU_KEY%\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%GPU_KEY%\Interrupt Management\MessageSignaledInterruptProperties" /v "MessageNumberLimit" /t REG_DWORD /d 2048 /f >nul 2>&1

exit /b 0

:APPLY_AMD_GPU
echo [GPU-AMD] Applying AMD GPU optimizations.

reg add "HKCU\Software\AMD\CN" /v "AutoUpdateTriggered" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\AMD\CN" /v "PowerSaverAutoEnable_CUR" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\AMD\CN" /v "BuildType" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\AMD\CN" /v "WizardProfile" /t REG_SZ /d "PROFILE_CUSTOM" /f >nul 2>&1
reg add "HKCU\Software\AMD\CN" /v "UserTypeWizardShown" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Software\AMD\CN" /v "AutoUpdate" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\AMD\CN" /v "RSXBrowserUnavailable" /t REG_SZ /d "true" /f >nul 2>&1
reg add "HKCU\Software\AMD\CN" /v "SystemTray" /t REG_SZ /d "false" /f >nul 2>&1
reg add "HKCU\Software\AMD\CN" /v "AllowWebContent" /t REG_SZ /d "false" /f >nul 2>&1
reg add "HKCU\Software\AMD\CN" /v "CN_Hide_Toast_Notification" /t REG_SZ /d "true" /f >nul 2>&1
reg add "HKCU\Software\AMD\CN" /v "AnimationEffect" /t REG_SZ /d "false" /f >nul 2>&1
reg add "HKCU\Software\AMD\CN\OverlayNotification" /v "AlreadyNotified" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Software\AMD\CN\VirtualSuperResolution" /v "AlreadyNotified" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Software\AMD\DVR" /v "PerformanceMonitorOpacityWA" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\AMD\DVR" /v "DvrEnabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\Software\AMD\DVR" /v "ActiveSceneId" /t REG_SZ /d "0" /f >nul 2>&1
reg add "HKCU\Software\AMD\DVR" /v "PrevInstantReplayEnable" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\AMD\DVR" /v "PrevInGameReplayEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\AMD\DVR" /v "PrevInstantGifEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\AMD\DVR" /v "RemoteServerStatus" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKCU\Software\AMD\DVR" /v "ShowRSOverlay" /t REG_SZ /d "false" /f >nul 2>&1
reg add "HKCU\Software\ATI\ACE\Settings\ADL\AppProfiles" /v "AplReloadCounter" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\Software\AMD\Install" /v "AUEP" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\Software\AUEP" /v "RSX_AUEPStatus" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\AMD Crash Defender Service" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\AMD External Events Utility" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\amdfendr" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\amdfendrmgr" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\amdlog" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Services\amdwddmg" /v "ChillEnabled" /t REG_DWORD /d "0" /f >nul 2>&1

for /f "tokens=2 delims=:" %%S in ('sc query state^= all ^| findstr /i "SERVICE_NAME" ^| findstr /i "AMD"') do (
    set "AMD_SVC=%%S"
    set "AMD_SVC=!AMD_SVC:~1!"
    reg add "HKLM\System\CurrentControlSet\Services\!AMD_SVC!" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
)
for /f "tokens=*" %%K in ('reg query "%GPU_CLASS_KEY%" /s /v "DriverDesc" 2^>nul ^| findstr /i "HKEY"') do (
    set "GPU_KEY=%%K"
    set "IS_MATCH=0"
    reg query "!GPU_KEY!" /v "DriverDesc" 2>nul | findstr /i /c:"AMD" /c:"Radeon" >nul && set "IS_MATCH=1"
    if "!IS_MATCH!"=="0" reg query "!GPU_KEY!" /v "HardwareID" 2>nul | findstr /i "VEN_1002" >nul && set "IS_MATCH=1"
    if "!IS_MATCH!"=="0" reg query "!GPU_KEY!" /v "MatchingDeviceId" 2>nul | findstr /i "VEN_1002" >nul && set "IS_MATCH=1"
    if "!IS_MATCH!"=="1" (
        set "SKIP_INST=0"
        call :CHECK_IGPU_KEY "AMD" "!GPU_KEY!"
        if "!IS_IGPU!"=="1" if "!HAS_DGPU!"=="1" set "SKIP_INST=1"
        if "!SKIP_INST!"=="1" (
            echo [GPU-AMD] Skipping integrated GPU - a discrete GPU is present.
        ) else (
            call :APPLY_AMD_INSTANCE "!GPU_KEY!"
        )
    )
)
exit /b 0

:APPLY_AMD_INSTANCE
set "GPU_KEY=%~1"

reg add "%GPU_KEY%" /v "PP_Force3DPerformanceMode" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "PP_ForceHighDPMLevel" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableGfxCoarseGrainLightSleep" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableGfxCpLightSleep" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableGfxMediumGrainLightSleep" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableGfxRlcLightSleep" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableDrmLightSleep" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableGfx3DCGLS" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableGfxCGTS" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableGfxCGTS_LS" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableGfxMGCGPerfMon" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableDrmdmaMGCG" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableDrmMGCG" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableGfx3DCGCG" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "EnableUvdClockGating" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "EnableVceSwClockGating" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "EnableGfxClockGatingThruSmu" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "EnableSysClockGatingThruSmu" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "IRQMgrDisableIHClockGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "swGcClockGatingMask" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "swGcClockGatingOverride" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableRomMediumGrainClockGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableRomMGCGClockGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableSamuClockGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableSysClockGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableVceClockGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableGfxCoarseGrainClockGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableGfxMediumGrainClockGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableMcMediumGrainClockGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableNbioMediumGrainClockGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableGfxClockGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DalDisableClockGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DalFineGrainClockGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableAllClockGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableGfxPGCondClearStateWA" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableCpPowerGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableAcpPowerGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableDynamicGfxMGPowerGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableGDSPowerGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableGfxCGPowerGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableGFXPipelinePowerGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableUVDPowerGatingDynamic" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisablePowerGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableQuickGfxMGPowerGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableSAMUPowerGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableStaticGfxMGPowerGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableUVDPowerGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableVCEPowerGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableXdmaPowerGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableXdmaSclkGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DalPSRSkipCRTCPowerDown" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "PP_GPUPowerDownEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableAspmSWL1" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableAspmL0s" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableAspmL1" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "EnableAspmL0s" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "EnableAspmL1" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "EnableAspmL1SS" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "AspmL0sTimeout" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "AspmL1Timeout" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableClkReqSupport" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableFBCSupport" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableForceUvdToSclk" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%" /v "PipeTilingDowngrade" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "GroupSizeDowngrade" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "RowTilingDowngrade" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "SampleSplitDowngrade" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "EnableSpreadSpectrum" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "NotifySubscription" /t REG_BINARY /d "3000" /f >nul 2>&1
reg add "%GPU_KEY%" /v "IsComponentControl" /t REG_BINARY /d "00000000" /f >nul 2>&1
reg add "%GPU_KEY%" /v "KMD_USUEnable" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "KMD_RadeonBoostEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "IsAutoDefault" /t REG_BINARY /d "01000000" /f >nul 2>&1
reg add "%GPU_KEY%" /v "KMD_ChillEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "KMD_DeLagEnabled" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "ACE" /t REG_BINARY /d "3000" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableBlockWrite" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "PP_ThermalAutoThrottlingEnable" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "%GPU_KEY%" /v "DisableDrmdmaPowerGating" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "%GPU_KEY%\UMD" /v "AnisoDegree_SET" /t REG_BINARY /d "3020322034203820313600" /f >nul 2>&1
reg add "%GPU_KEY%\UMD" /v "Main3D_SET" /t REG_BINARY /d "302031203220332034203500" /f >nul 2>&1
reg add "%GPU_KEY%\UMD" /v "Tessellation_OPTION" /t REG_BINARY /d "3200" /f >nul 2>&1
reg add "%GPU_KEY%\UMD" /v "Tessellation" /t REG_BINARY /d "3100" /f >nul 2>&1
reg add "%GPU_KEY%\UMD" /v "AAF" /t REG_BINARY /d "30000000" /f >nul 2>&1
reg add "%GPU_KEY%\UMD" /v "GI" /t REG_BINARY /d "31000000" /f >nul 2>&1
reg add "%GPU_KEY%\UMD" /v "CatalystAI" /t REG_BINARY /d "31000000" /f >nul 2>&1
reg add "%GPU_KEY%\UMD" /v "TemporalAAMultiplier_NA" /t REG_BINARY /d "3100" /f >nul 2>&1
reg add "%GPU_KEY%\UMD" /v "ForceZBufferDepth" /t REG_BINARY /d "30000000" /f >nul 2>&1
reg add "%GPU_KEY%\UMD" /v "EnableTripleBuffering" /t REG_BINARY /d "3000" /f >nul 2>&1
reg add "%GPU_KEY%\UMD" /v "ExportCompressedTex" /t REG_BINARY /d "31000000" /f >nul 2>&1
reg add "%GPU_KEY%\UMD" /v "PixelCenter" /t REG_BINARY /d "30000000" /f >nul 2>&1
reg add "%GPU_KEY%\UMD" /v "ZFormats_NA" /t REG_BINARY /d "3100" /f >nul 2>&1
reg add "%GPU_KEY%\UMD" /v "DitherAlpha_NA" /t REG_BINARY /d "3100" /f >nul 2>&1
reg add "%GPU_KEY%\UMD" /v "SwapEffect_D3D_SET" /t REG_BINARY /d "3020312032203320342038203900" /f >nul 2>&1
reg add "%GPU_KEY%\UMD" /v "TFQ" /t REG_BINARY /d "3200" /f >nul 2>&1
reg add "%GPU_KEY%\UMD" /v "VSyncControl" /t REG_BINARY /d "3100" /f >nul 2>&1

exit /b 0

:APPLY_AMD_CPU
echo [CPU-AMD] Applying AMD CPU optimizations...

powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PERFBOOSTPOL 100 >nul 2>&1
powercfg /setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR PERFBOOSTPOL 100 >nul 2>&1
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR 3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb 0 >nul 2>&1
powercfg /setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR 3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb 0 >nul 2>&1
powercfg /setactive SCHEME_CURRENT >nul 2>&1

echo !CPU_MODEL!| findstr /i "X3D" >nul && call :AMD_X3D_FIX
exit /b 0

:AMD_X3D_FIX
echo [CPU-AMD] X3D CPU detected - keeping Game Mode / Game Bar detection alive for the 3D V-Cache driver.
reg add "HKCU\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" /v "ActivationType" /t REG_DWORD /d 1 /f >nul 2>&1
for %%F in ("GameBarPresenceWriter.exe" "GameBarPresenceWriter.proxy.dll") do (
    if exist "%HEX_FILES_BACKUP%\%%~F" if not exist "%SystemRoot%\System32\%%~F" copy /Y "%HEX_FILES_BACKUP%\%%~F" "%SystemRoot%\System32\" >nul 2>&1
)
exit /b 0

:CHECK_IGPU_KEY
set "IS_IGPU=0"
set "IGPU_DESC="
for /f "tokens=2,*" %%A in ('reg query "%~2" /v "DriverDesc" 2^>nul ^| findstr /i "DriverDesc"') do set "IGPU_DESC=%%B"
if /i "%~1"=="INTEL" (
    echo !IGPU_DESC!| findstr /i /r "\<Arc" >nul || set "IS_IGPU=1"
)
if /i "%~1"=="AMD" (
    echo !IGPU_DESC!| findstr /i /r "Graphics$" >nul && set "IS_IGPU=1"
    echo !IGPU_DESC!| findstr /i /r "Radeon.* [0-9][0-9][0-9]M$" >nul && set "IS_IGPU=1"
)
exit /b 0

:hex_done
echo.
echo.
echo !R!!ESC![38;2;255;140;0m          ██╗  ██╗███████╗██╗  ██╗    ██╗      !RESET!
echo !ESC![38;2;255;155;0m          ██║  ██║██╔════╝╚██╗██╔╝    ██║      !RESET!
echo !ESC![38;2;255;170;0m          ███████║█████╗   ╚███╔╝ ██████████╗ !RESET!
echo !ESC![38;2;255;185;0m          ██╔══██║██╔══╝   ██╔██╗ ╚═══██╔═══╝ !RESET!
echo !ESC![38;2;255;200;0m          ██║  ██║███████╗██╔╝ ██╗    ██║      !RESET!
echo !ESC![38;2;255;215;0m          ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝    ╚═╝      !RESET!
echo !ESC![38;2;255;215;0m          ██████╗   ██████╗  ███╗   ██╗ ███████╗!RESET!
echo !ESC![38;2;255;200;0m          ██╔══██╗ ██╔═══██╗ ████╗  ██║ ██╔════╝!RESET!
echo !ESC![38;2;255;185;0m          ██║  ██║ ██║   ██║ ██╔██╗ ██║ █████╗  !RESET!
echo !ESC![38;2;255;170;0m          ██║  ██║ ██║   ██║ ██║╚██╗██║ ██╔══╝  !RESET!
echo !ESC![38;2;255;155;0m          ██████╔╝ ╚██████╔╝ ██║ ╚████║ ███████╗!RESET!
echo !ESC![38;2;255;140;0m          ╚═════╝   ╚═════╝  ╚═╝  ╚═══╝ ╚══════╝!RESET!
echo.
echo !ESC![38;2;120;220;200m                 optimization complete - rebooting!RESET!
echo.
>> "%HEX_KEYS_BACKUP%\hexplus_log.txt" echo finished %date% %time%
timeout /t 2 >nul
shutdown /r /f /t 3
exit /b 0
