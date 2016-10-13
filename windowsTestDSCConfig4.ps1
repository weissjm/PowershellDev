Configuration vumc_IT_Testing {

#Creates a Parameter named "ComputerName"
    param(
        [string[]]$ComputerName
    )
#Declares configuration for -computername
#Import-DscResource -ModuleName PSDesiredStateConfiguration (may be needed if not already done so.)

    Node $ComputerName {
#Installs RSAT  
        WindowsFeature MyFeatureInstance {
            Ensure = "Present"
            Name =    "RSAT"
        }
 #Installs the Telnet-Client
        WindowsFeature My2ndFeatureInstance {
            Ensure = "Present"
            Name = "Telnet-Client"
        }
#Group Resource to add VUMC IT Windows admins to the local admins Group.
        Group VUMCITWindowsAdmins
{
   
# To create a new group, set Ensure to "Present (or absent if not needed)“
    Ensure = "Present"
    GroupName = "Administrators"
    MemberstoInclude = "vanderbilt\VUMC IT Windows Admins","jmw"
}

#Creates C:\TEMP File Resource
File Tempfolder
    {
    Ensure = "Present"
    DestinationPath = "C:\TEMP"
    Type= "Directory"
    }
#creates C:\TEMP\TESTFOLDER1 File Resource
File newfolder1
    {
    Ensure = "Present"
    DestinationPath = "C:\TEMP\TESTFOLDER1"
    Type= "Directory"
    DependsOn = "[File]Tempfolder"
    }
#creates C:\TEMP\TESTFOLDER2 file Resource
File newfolder2
    {
    Ensure = "Present"
    DestinationPath = "C:\TEMP\TESTFOLDER2"
    Type= "Directory"
    }

#Sets path to Windows Firewall Logs.
Registry FWLoggingPath
{
    Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile\Logging"
    Ensure = "Present"
    ValueName = "LogFilePath"
    ValueData = "%systemroot%\\system32\\logfiles\\firewall\\pfirewall.log"
}

Registry FWLoggingDropEnabled
{

    Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile\Logging"
    Ensure = "Present"
    ValueName = "LogDroppedPackets"
    ValueType = "Dword"
    ValueData = "1"
}

Registry FWLogSize
{
    Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile\Logging"
    Ensure = "Present"
    ValueName = "LogDroppedPackets"
    ValueType = "Dword"
    ValueData = "5000"
}
    }
}
