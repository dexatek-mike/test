# Revision History

script to generate release package:  
1. extract tools
```bash
sh tools/pre_extract.sh tools
```
2. reset your workspace to appropriate commit manually
3. generate release packages
```bash
sh tools/release_build.sh -v 3.1.133 --odm Resideo; \
sh tools/release_build.sh -v 3.1.133 --odm Resideo --release_mode
```

**naming convention of images**: `image_type`-`product_name`-`odm_name`-`version`-`hash`  

**change-note categories**  

+ Submodule Information
+ Changes
+ Bug Fixes
+ Misc


**known issues**  

+ [AS-317](https://dexatek.atlassian.net/browse/AS-317) Battery percentage value jumping around when low in battery
+ [AS-321](https://dexatek.atlassian.net/browse/AS-321) offline mode: smart link does not work
+ [AS-327](https://dexatek.atlassian.net/browse/AS-327) Have chance to fail to create container data
+ [AS-328](https://dexatek.atlassian.net/browse/AS-328) Pair motion device should not send motion detected notification during pairing process
+ [AS-332](https://dexatek.atlassian.net/browse/AS-332) 將 Notification 的通知方式由字串改為 ID
+ [AS-335](https://dexatek.atlassian.net/browse/AS-335) power back siren will receive low battery message for siren
+ [AS-339](https://dexatek.atlassian.net/browse/AS-339) DoS Attack should see Alert History record vs Disarm History record
+ [AS-341](https://dexatek.atlassian.net/browse/AS-341) After done pairing alarm system lite, will see alarm system reboot
+ [AS-344](https://dexatek.atlassian.net/browse/AS-344) Peripheral with 0% battery should also have signal set to 0
+ [AS-345](https://dexatek.atlassian.net/browse/AS-345) Connect Motion device for more than 3 times does not trigger DoS Alert
+ [AS-346](https://dexatek.atlassian.net/browse/AS-346) missing notification if system is busy  
+ [AS-351](https://dexatek.atlassian.net/browse/AS-351) Performance Evaluation Stage 2
+ [AS-352](https://dexatek.atlassian.net/browse/AS-352) Resideo ASL: unable to pair back Thermostat (after unpair/pair devices for few times)  
+ [AS-353](https://dexatek.atlassian.net/browse/AS-353) [Lite] log keep showing "FATAL: HP haven't refresh watchdog from Tick"
+ [AS-354](https://dexatek.atlassian.net/browse/AS-354) Siren low battery detect and trigger issue
+ [AS-356](https://dexatek.atlassian.net/browse/AS-356) [Alarm Lite_3.1.123] 在 Alarming 延遲時間設定中移除 Door，觸發 Door 時，仍然會產生延遲時間
+ [AS-360](https://dexatek.atlassian.net/browse/AS-360) [ASL_3.1.126] Change name after device offline, have chance to cause not receive offline notification
+ [AS-362](https://dexatek.atlassian.net/browse/AS-362) [Lite] (same door) offline message see door device name, but open door message see "MyDevice"   

*note*  
2. AS-335: confirmed with John Lin, may be the problem of siren firmware

--------------------------------------------------------------------------------
## Version: v3.1.133

+ DxFramwork: v3.1.138, branch `develop`, commit `81c2610e`
+ AlarmCommon: branch `develop`, commit `4fbd6f3`
+ BLE: 3.0.21

*Changes*

+ adjust lwip parameters
    + TCP_SYNMAXRTX=2
    + TCP_MAXRTX=4

--------------------------------------------------------------------------------
## Version: v3.1.132

+ DxFramwork: v3.1.138, branch `develop`, commit `81c2610e`
+ AlarmCommon: branch `develop`, commit `4fbd6f3`
+ BLE: 3.0.21

*Changes*

+ DxFramwork: v3.1.137
+ BLE: v3.0.21
+ AlarmCommon: v3.0.21
    + clear meta-container/storage on finishing registration

--------------------------------------------------------------------------------
## Version: v3.1.131

+ DxFramwork: v3.1.136, branch `develop`, commit `4a7daf5e`
+ AlarmCommon: branch `develop`, commit `da9726c`
+ BLE: 3.0.17

*Changes*

+ DxFramwork: v3.1.136

--------------------------------------------------------------------------------
## Version: v3.1.130

+ DxFramwork: v3.1.135, branch `develop`, commit `4ef5b762`
+ AlarmCommon: branch `develop`, commit `da9726c`
+ BLE: 3.0.17

*Changes*

+ DxFramwork: v3.1.135
+ CONFIG_MAXIMUM_DEVICE_KEEPER=32

--------------------------------------------------------------------------------
## Version: v3.1.129

+ DxFramwork: v3.1.133, branch `develop`, commit `51ad4330`
+ AlarmCommon: branch `develop`, commit `da9726c`
+ BLE: 3.0.17

*Changes*

+ DxFramwork: v3.1.133

--------------------------------------------------------------------------------
## Version: v3.1.128

+ DxFramwork: v3.1.132, branch `develop`, commit `a49714fb`
+ AlarmCommon: branch `develop`, commit `da9726c`
+ BLE: 3.0.17

*Changes*

+ DxFramwork: v3.1.132

--------------------------------------------------------------------------------
## Version: v3.1.127

+ DxFramwork: v3.1.131, branch `develop`, commit `53da623a`
+ AlarmCommon: branch `develop`, commit `da9726c`
+ BLE: 3.0.17

*Changes*

+ DxFramwork: v3.1.131
+ BLE: 3.0.17
+ [AS-359](https://dexatek.atlassian.net/browse/AS-359) Disable WiFi power saving mode

--------------------------------------------------------------------------------
## Version: v3.1.126

+ DxFramwork: v3.1.130, branch `develop`, commit `d1f7bf6c`
+ AlarmCommon: branch `develop`, commit `da9726c`
+ BLE: 3.0.13

*Changes*

+ DxFramwork v3.1.130
+ AlarmCommon
    + [AS-358](https://dexatek.atlassian.net/browse/AS-358) Option to disable SOS/Alarming trigger when end device is offline

--------------------------------------------------------------------------------
## Version: v3.1.125

+ DxFramwork: v3.1.129, branch `develop`, commit `2e7370c7`
+ AlarmCommon: branch `develop`, commit `aa61bc17`
+ BLE: 3.0.13

*Changes*

+ DxFramwork v3.1.129: fix segmentation fault

--------------------------------------------------------------------------------
## Version: v3.1.124

+ DxFramwork: v3.1.129, branch `develop`, commit `ce667d97`
+ AlarmCommon: branch `develop`, commit `aa61bc17`
+ BLE: 3.0.13

*Changes*

+ update DxFramwork to 3.1.129
+ update BLE Nordic to 3.0.13

--------------------------------------------------------------------------------
## Version: v3.1.123

+ DxFramwork: v3.1.128, branch `develop`, commit `feae79a1`
+ AlarmCommon: branch `develop`, commit `aa61bc17`
+ BLE: 3.0.11

*Changes*

+ update BLE Nordic to 3.0.11

--------------------------------------------------------------------------------
## Version: v3.1.122

+ DxFramwork: v3.1.128, branch `develop`, commit `feae79a1`
+ AlarmCommon: branch `develop`, commit `aa61bc17`
+ BLE: 3.0.6

*Changes*

+ update DxFramwork to v3.1.128
    + SHSCommonSubModule: branch master, commit 3696979
    + fix the payload for new paired device is not uploaded immediately
    + improve mesh retry mechanism

--------------------------------------------------------------------------------
## Version: v3.1.121

+ DxFramwork: v3.1.127, branch `develop`, commit `c9fe884c`
+ AlarmCommon: branch `develop`, commit `aa61bc17`
+ BLE: 3.0.6

*Changes*

+ update DxFramwork to v3.1.127
+ update AlarmCommon to aa61bc17
    + fix wrong parameter to call storage-manager related API
+ [AS-355](https://dexatek.atlassian.net/browse/AS-355) Change device missing report timeout from 5m to 30m

--------------------------------------------------------------------------------
## Version: v3.1.120

+ DxFramwork: v3.1.126, branch `develop`, commit `2b33833f`
+ AlarmCommon: branch `develop`, commit `b94a5385`
+ BLE: 3.0.6

*Changes*

+ update DxFramwork to v3.1.126
+ update AlarmCommon to b94a5385(trim debug messages)
+ integrate submodule `shscommon-amebatool`

--------------------------------------------------------------------------------
## Version: v3.1.117

+ dx-framwork: v3.1.122, branch `develop`, commit `eeeefe82`
+ alarm-common: branch `develop`, commit `e269d545`
+ BLE: 3.0.6

*Changes*

+ update BLE Nordic to v3.0.6
+ update dx-framwork to v3.1.122

--------------------------------------------------------------------------------
## Version: v3.1.116

+ dx-framwork: v3.1.120, branch `develop`, commit `fc382447`
+ alarm-common: branch `develop`, commit `e269d545`
+ BLE: 3.0.4

*Changes*

+ update dx-framwork to v3.1.120

--------------------------------------------------------------------------------
## Version: v3.1.115

+ dx-framwork: v3.1.112, branch `develop`, commit `3d199267`
+ alarm-common: branch `develop`, commit `e269d545`
+ BLE: 3.0.2

*Changes*

+ update dx-framwork to v3.1.112

--------------------------------------------------------------------------------
## Version: v3.1.114

+ dx-framwork: v3.1.111, branch `develop`, commit `bd55102d`
+ alarm-common: branch `develop`, commit `e269d545`
+ BLE: 3.0.2

*Changes*

+ update dx-framwork to v3.1.111

--------------------------------------------------------------------------------
## Version: v3.1.113

+ dx-framwork: v3.1.108
+ alarm-common: branch `develop`, commit `66f23a62`
+ BLE: 3.0.0, 0826

*Changes*

+ update dx-framwork to v3.1.108

--------------------------------------------------------------------------------
## Version: v3.1.112

+ dx-framwork: v3.1.106, branch `develop`, commit `66f23a62`
+ alarm-common: branch `develop`, commit `c1fdd00`
+ BLE: 3.0.0, 0826

*Changes*

+ update dx-framwork to v3.1.106

--------------------------------------------------------------------------------
## Version: v3.1.111

+ dx-framwork: v3.1.105, branch `develop`, commit `a357c0b7`
+ alarm-common: branch `develop`, commit `c1fdd00`
+ BLE: 3.0.0, 0826

*Changes*

+ update dx-framwork to v3.1.105

*Bug Fixes*
+ [AS-343](https://dexatek.atlassian.net/browse/AS-343) Unpair devices before change WiFi will see green light keep flashing
+ [SCFW-848](https://dexatek.atlassian.net/browse/SCFW-848) Ghost device keep appearing on the keeper list which was not in the cloud
+ [SCFW-856](https://dexatek.atlassian.net/browse/SCFW-856) DKMSG is dropped and in turn causes missing response

--------------------------------------------------------------------------------
## Version: v3.1.110

+ dx-framwork: v3.1.104, branch `develop`, commit `db0fafec`
+ alarm-common: branch `develop`, commit `c1fdd00`
+ BLE: 3.0.1. 0726.1CR

*Changes*

+ update dx-framwork to v3.1.104-db0fafec 

*Bug Fixes*
+ [AS-343](https://dexatek.atlassian.net/browse/AS-343) Unpair devices before change WiFi will see green light keep flashing
+ [AS-347](https://dexatek.atlassian.net/browse/AS-347) ASL on battery and die, does not get notification about low battery
+ [AS-348](https://dexatek.atlassian.net/browse/AS-348) Alarm Common Boot initialization performance Issue
+ [AS-349](https://dexatek.atlassian.net/browse/AS-349) Inconsistent Alarm mode before and after reboot
+ [AS-350/SCFW-846](https://dexatek.atlassian.net/browse/SCFW-846) After reboot Alarm does not respond to trigger alert

*note*  
1. AS-343: similar to SCFW-848

--------------------------------------------------------------------------------
## Version: v3.1.108

+ dx-framwork: v3.1.103, branch `develop-mesh`, commit `ca8d1e3`
+ alarm-common: branch `develop-mesh`, commit `20be610`
+ BLE: 0726CR

*Changes*

+ update dx-framwork to v3.1.103-ca8d1e3

--------------------------------------------------------------------------------
## Version: v3.1.107

+ dx-framwork: v3.1.103, branch `develop-mesh`, commit `6de384b`
+ alarm-common: branch `develop-mesh`, commit `20be610`
+ BLE: 0726CR

*Bug Fixes*

+ [AS-340](https://dexatek.atlassian.net/browse/AS-340) (re-opened)Pair device failed cause green LED light keep flashing on Alarm System Lite
+ [AS-343](https://dexatek.atlassian.net/browse/AS-343) Unpair devices before change WiFi will see green light keep flashing

*Changes*

+ update dx-framwork to v3.1.103-6de384b

--------------------------------------------------------------------------------
## Version: v3.1.106

+ dx-framwork: v3.1.103, branch `develop-mesh`, commit `818a7c9`
+ alarm-common: branch `develop-mesh`, commit `20be610`
+ BLE: 0726CR

*Changes*

+ update dx-framwork to v3.1.103

--------------------------------------------------------------------------------
## Version: v3.0.41

+ dx-framwork: v3.0.113, branch `develop-mesh`, commit `2d05f81`
+ alarm-common: branch `develop-mesh`, commit `c61d233`
+ BLE: v2.0.22

*Changes*

+ update dx-framwork to v3.0.113
+ expected to act the same as v3.0.28 pre-release 4

--------------------------------------------------------------------------------
## Version: v3.0.40

+ dx-framwork: v3.0.110, branch `release`, commit `c7c6835`
+ alarm-common: branch `develop-framework-3.0.110`, commit `79af5a8`
+ BLE: v2.0.22

*Changes*

+ update dx-framwork to v3.0.110
+ expected to act the same as v3.0.28 pre-release 3

--------------------------------------------------------------------------------
## Version: v3.0.28 (pre-release 4; not formally released)

+ dx-framwork: v3.0.100, branch `develop-alarmlite-stable-3.0.100`, commit `633e7bb`
+ alarm-common: branch `develop`, commit `0b3ca62`
+ BLE: v2.0.22

*Changes*

*Bug Fixes*

+ [AS-323](https://dexatek.atlassian.net/browse/AS-323) Resideo: see red light blinking during FW/BLE update
+ [AS-326](https://dexatek.atlassian.net/browse/AS-326) Should support DoS Attack Detect Function
+ [AS-329](https://dexatek.atlassian.net/browse/AS-329) Trigger alert cause Hard Fault
+ [AS-330](https://dexatek.atlassian.net/browse/AS-330) FW/BLE update will stop few hours then continue update process
+ [AS-331](https://dexatek.atlassian.net/browse/AS-331) Alarm System Lite and App out of sync
+ [AS-333](https://dexatek.atlassian.net/browse/AS-333) Default delay time does not work before adding peripherals
+ [AS-334](https://dexatek.atlassian.net/browse/AS-334) Does not send power cut off notification
+ [AS-335](https://dexatek.atlassian.net/browse/AS-335) power back siren will receive low battery message for siren
+ [AS-336](https://dexatek.atlassian.net/browse/AS-336) Not get SOS notification
+ [AS-337](https://dexatek.atlassian.net/browse/AS-337) Does not get device triggered alert message
+ [AS-338](https://dexatek.atlassian.net/browse/AS-338) Should trigger Siren and send Siren sabotage notification
+ [AS-340](https://dexatek.atlassian.net/browse/AS-340) Pair device failed cause green LED light keep flashing on Alarm System Lite

--------------------------------------------------------------------------------
## Version: v3.0.27

+ dx-framwork: v3.0.100, branch `release`, commit `9945dc9`
+ alarm-common: branch `release`, commit `c2894a2`
+ BLE: v2.0.22

*Bug Fixes*

+ [AS-329](https://dexatek.atlassian.net/browse/AS-329) bug: Trigger alert cause Hard Fault

--------------------------------------------------------------------------------
## Version: v3.0.26

+ dx-framwork: v3.0.100, branch `release`, commit `9945dc9`
+ alarm-common: branch `release`, commit `f36f916`
+ BLE: v2.0.22

*Changes*

+ Update framework v3.0.100
+ [AS-317](https://dexatek.atlassian.net/browse/AS-317) Battery percentage value jumping around when low in battery  
    1.take a sample every 1 sec and gather 60 samples for calculation  
    2.send battery level info to server 90 seconds after powered-on  
    3.send battery level info to server every 30 minutes  
    4.update power level along with source change


*Bug Fixes*

+ [AS-320](https://dexatek.atlassian.net/browse/AS-320) No smart link events in History page
+ [AS-322](https://dexatek.atlassian.net/browse/AS-322) system stuck in container initialization
+ [AS-324](https://dexatek.atlassian.net/browse/AS-324) Device keeper list does not sync between the server and device

--------------------------------------------------------------------------------
## Version: v3.0.25

+ dx-framwork: v3.0.98, branch `release`, commit `97a1bce`
+ alarm-common: branch `release`, commit `b52f134`
+ BLE: v2.0.22

*Changes*

+ Update framework v3.0.98 to export MQTT host/port parameters

--------------------------------------------------------------------------------
## Version: v3.0.24

+ dx-framwork: v3.0.97, branch `release`, commit `e486249`
+ alarm-common: branch `release`, commit `b52f134`
+ BLE: v2.0.22

*Bug Fixes*

+ [AS-316](https://dexatek.atlassian.net/browse/AS-316) pair Alarm System Lite on battery, will not see on battery message

*Changes*

+ Update framework v3.0.97

--------------------------------------------------------------------------------
## Version: v3.0.23

+ dx-framwork: v3.0.96, branch `release`, commit `88d2156`
+ alarm-common: branch `release`, commit `0722f90`
+ BLE: v2.0.22

*Changes*

+ Update framework to fix bug

--------------------------------------------------------------------------------
## Version: v3.0.22

+ dx-framwork: v3.0.95, branch `release`, commit `9a72bbe`
+ BLE: v2.0.22

*Changes*

+ Move get_main_version() to framework

--------------------------------------------------------------------------------
## Version: v3.0.21

+ dx-framwork: v3.0.94, branch `release`, commit `b53fecc`
+ BLE: v2.0.22

*Changes*

+ Enable MQTT

--------------------------------------------------------------------------------
## Version: v3.0.20

+ dx-framwork: v3.0.93, branch `release`, commit `1e9ef0e`
+ BLE: v2.0.22

*Bug Fixes*

+ [AS-319](https://dexatek.atlassian.net/browse/AS-319) It should update BLE FW version number to server after BLE FW updated

--------------------------------------------------------------------------------
## Version: v3.0.14

+ dx-framwork: v3.0.81, branch `hotfix-alarmlite`, commit 8e4ac65
+ BLE: v2.0.22

*Bug Fixes*

+ [AS-315](https://dexatek.atlassian.net/browse/AS-315) Create container data
    > clear user info in flash if deregistered
+ [AS-317](https://dexatek.atlassian.net/browse/AS-317) Battery percentage value jumping around when low in battery
    > workaround: suppress jitters of battery voltage; need a further improvement
+ [AS-318](https://dexatek.atlassian.net/browse/AS-318) Non-whitelist triggered during ARMING/HOMING, should not continue countdown

--------------------------------------------------------------------------------
## Version: v3.0.13

*Submodule Information*  

+ dx-framwork: v3.0.81, branch `hotfix-alarmlite`, commit aa2219c
+ BLE: v2.0.22

*Bug Fixes*

+ [AS-315](https://dexatek.atlassian.net/browse/AS-315) task: Create container data

--------------------------------------------------------------------------------
## Version: v3.0.12

*Submodule Information*  

+ dx-framwork: v3.0.81, branch `hotfix-alarmlite`, commit aa2219c
+ BLE: v2.0.22

*Bug Fixes*

+ [AS-315](https://dexatek.atlassian.net/browse/AS-315) task: Create container data

--------------------------------------------------------------------------------
## Version: v3.0.11

*Submodule Information*  

+ dx-framwork: v3.0.81, branch `hotfix-alarmlite`, commit bec39da
+ BLE: v2.0.22

*Bug Fixes*

+ [AS-265](https://dexatek.atlassian.net/browse/AS-265) defect: Should not beeping if countdown is not the last 10 seconds
+ [AS-241](https://dexatek.atlassian.net/browse/AS-241) defect: Alarming delay: trigger device not in white zone does not go to alert right away

*Changes*

+ format of released image name:  
  `image_type`-`product_name`-`odm_name`-`version`-`hash`

*Misc*

+ [AS-313](https://dexatek.atlassian.net/browse/AS-313) task: RTOS timer support to more than 16  
    > already modified in `v3.0.10`

--------------------------------------------------------------------------------
## Version: v3.0.10

*Submodule Information*  

+ dx-framwork: v3.0.81, branch `hotfix-alarmlite`, commit bec39da
+ BLE: v2.0.22

*Changes*

+ supoorts MP-OTA

--------------------------------------------------------------------------------
## Version: v3.0.01

*Submodule Information*  

+ dx-framwork: v3.0.81
+ BLE: v2.0.22

