[Setup]
AppName=Pyron Launcher
AppPublisher=Pyron
UninstallDisplayName=Pyron
AppVersion=${project.version}
AppSupportURL=https://pyron.com
DefaultDirName={localappdata}\Pyron

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x64
PrivilegesRequired=lowest

WizardSmallImageFile=${basedir}/innosetup/runelite_small.bmp
SetupIconFile=${basedir}/runelite.ico
UninstallDisplayIcon={app}\Pyron.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${basedir}
OutputBaseFilename=PyronSetup

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${basedir}\build\win-x64\Pyron.exe"; DestDir: "{app}"
Source: "${basedir}\build\win-x64\Pyron.jar"; DestDir: "{app}"
Source: "${basedir}\build\win-x64\launcher_amd64.dll"; DestDir: "{app}"
Source: "${basedir}\build\win-x64\config.json"; DestDir: "{app}"
Source: "${basedir}\build\win-x64\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\Pyron\Pyron"; Filename: "{app}\Pyron.exe"
Name: "{userprograms}\Pyron\Pyron (configure)"; Filename: "{app}\Pyron.exe"; Parameters: "--configure"
Name: "{userprograms}\Pyron\Pyron (safe mode)"; Filename: "{app}\Pyron.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\Pyron"; Filename: "{app}\Pyron.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Pyron.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Pyron.exe"; Description: "&Open Pyron"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\Pyron.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.pyron\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"