@echo off

echo ---------------ɾ������NGC��Դ---------------
adb root
adb remount
adb shell rm -rf /system/etc/carspeech/assets/ngc/
adb shell rm -rf /sdcard/Android/data/com.xiaopeng.speech.resourcecenter/files/databases/
echo ---------------�����������---------------

echo ---------------������������---------------
set "carspeech=com.xiaopeng.carspeechservice"  REM �滻Ϊʵ�ʵİ���
set "resource=com.xiaopeng.speech.resourcecenter"  REM �滻Ϊʵ�ʵİ���
REM ��ȡcarspeechservice����ID
for /f "tokens=1" %%a in ('adb shell "pidof %carspeech%"') do set "pid=%%a"



REM �������ID��Ϊ�գ���kill����
if defined pid (
    adb shell "kill %pid%"
    echo �ѹر�carspeechservice���̣�����IDΪ %pid%
) else (
    echo δ�ҵ�carspeechservice����
)
for /f "tokens=1" %%a in ('adb shell "pidof %resource%"') do set "pid_resource=%%a"

REM �������ID��Ϊ�գ���kill����
if defined pid_resource (
    adb shell "kill %pid_resource%"
    echo �ѹر�carspeechservice resourcecenter���̣�����IDΪ %pid_resource%
) else (
    echo δ�ҵ�resourcecenter����
)

echo ---------------��ʼ������Դ---------------
adb logcat -c

REM ���� adb logcat ���������ض�����ʱ�ļ�
adb logcat > logcat_output.txt

REM ���ж�ȡ��־�ļ�����
for /f "delims=" %%a in (logcat_output.txt) do (
    REM ���ÿһ���Ƿ���� "start" �ؼ���
    echo %%a | findstr / i "MSG_DOWNLOAD_ALL_RESOURCE DONE" > nul
    if not errorlevel 1 (
	    set "file_path=/sdcard/Android/data/com.xiaopeng.speech.resourcecenter/files/databases/"
        REM ����ҵ� "start" �ؼ��֣����˳��ű�
        echo "start" �ؼ������ҵ����˳��ű���
		        REM ʹ��adb pull������ȡ�ļ�
        adb pull %file_path% .

        REM ���adb pull������˳�״̬
        echo �ļ��ɹ���ȡ����ǰĿ¼��
        goto :eof
    )
)
REM ������ʱ�ļ�
del logcat_output.txt
