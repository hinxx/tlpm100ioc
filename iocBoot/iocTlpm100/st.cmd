#!../../bin/linux-x86_64/tlpm100DemoApp

## You may have to change tlpm100DemoApp to something else
## everywhere it appears in this file

< envPaths

epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TLPM100)/db")
epicsEnvSet("PREFIX",   "PM100")

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/tlpm100DemoApp.dbd"
tlpm100DemoApp_registerRecordDeviceDriver pdbbase

#var streamDebug 1

# usbtmcConfigure(port, vendorNum, productNum, serialNumberStr, priority, flags)
usbtmcConfigure("$(PREFIX)")
asynSetTraceIOMask("$(PREFIX)",0,0xff)
#asynSetTraceMask("$(PREFIX)",0,0xff)

# Load record instances
dbLoadRecords("$(TLPM100)/db/tlPM100.template","P=$(PREFIX):,R=,PORT=$(PREFIX)")
dbLoadRecords("$(ASYN)/db/asynRecord.db","P=$(PREFIX):,R=asyn,PORT=$(PREFIX),ADDR=0,OMAX=100,IMAX=100")

# For Autosave, before iocInit is called
#set_requestfile_path(".")
#set_savefile_path("./autosave")
#set_pass0_restoreFile("auto_settings.sav")
#set_pass1_restoreFile("auto_settings.sav")

cd "${TOP}/iocBoot/${IOC}"
iocInit
