Configuration vumc_IT_Testing {

    param(
        [string[]]$ComputerName
    )
    Node $ComputerName {
        WindowsFeature MyFeatureInstance {
            Ensure = "Present"
            Name =    "RSAT"
        }
        WindowsFeature My2ndFeatureInstance {
            Ensure = "Present"
            Name = "Telnet-Client"
        }
        Group VUMCITWindowsAdmins
{
    # This will add VUMC IT Windows Admins, to the build-in admins if missing
    # To create a new group, set Ensure to "Present (or absent if not needed)“
    Ensure = "Present"
    GroupName = "Administrators"
    MemberstoInclude = "vanderbilt\VUMC IT Windows Admins","weissjm"
}


File newfolder1
    {
    Ensure = "Present"
    DestinationPath = "C:\TEMP\TESTFOLDER1"
    Type= "Directory"
    }

File newfolder2
    {
    Ensure = "Present"
    DestinationPath = "C:\TEMP\TESTFOLDER2"
    Type= "Directory"
    }
    }
}
