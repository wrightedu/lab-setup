:: This script should query the mac address and compare it to a list, then rename the computer based on that list
:: Prerequisites: C:\Users\student\Music\wsname.exe and hosts.conf
::hosts.conf must follow the following format
::Mac-address host-name
::01-23-45-67-89-0A computer1

@echo off

::sync windows time
net stop w32time
w32tm /unregister
w32tm /register
net start w32time
w32tm /resync

::activate windows and office
cscript \windows\system32\slmgr.vbs -skms mssus1.wright.edu:1688  >nul 2>&1
cscript \windows\system32\slmgr.vbs -ato  >nul 2>&1
cscript "\program files (x86)\microsoft office\office15\ospp.vbs" /act  >nul 2>&1

::rename pc based on mac address and hosts.conf (see above)
for /f %%A IN ('getmac /fo table /nh') do (
    for /f "tokens=1,2" %%X IN (C:\Users\student\Music\hosts.conf) DO (
        if /i %%A==%%X (
            C:\Users\student\Music\wsname.exe /N:%%Y
            goto:end
            )
        )
    )
	
	:end
	shutdown -r
